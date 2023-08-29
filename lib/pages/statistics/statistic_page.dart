import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:piggy_flow_mobile/models/bill.dart';
import 'package:piggy_flow_mobile/models/category.dart';
import 'package:piggy_flow_mobile/pages/bill/new_bill_page.dart';
import 'package:piggy_flow_mobile/providers/bill_provider.dart';
import 'package:piggy_flow_mobile/providers/category_provider.dart';
import 'package:fl_chart/fl_chart.dart';

class StatisticsPage extends HookConsumerWidget {
  const StatisticsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useAutomaticKeepAlive(wantKeepAlive: true);
    final dateformat = DateFormat('MMMM yyyy');

    final selectedMonth = useState(DateTime.now());
    final touchedIndex = useState(-1);
    final displayedCategories = useState<List<Category>>([]);
    final chartItems = useState<List<PieChartSectionData>>([]);

    final categoryList = ref.read(categoryProvider);

    final priceFormatter = NumberFormat.currency(
      locale: 'sl_SI',
      symbol: '€',
    );

    double calcSum(List<Bill> bills, int categoryId) {
      double sum = 0;
      for (Bill bill in bills.where((Bill bill) =>
          (categoryId == 0 ? true : bill.category?.id == categoryId) &&
          bill.date.month == selectedMonth.value.month &&
          bill.date.year == selectedMonth.value.year)) {
        sum += bill.price;
      }
      return sum;
    }

    generateCategories(List<Bill> bills) {
      if (displayedCategories.value.isNotEmpty) {
        return;
      }
      double total = 0;
      for (Bill bill in bills.where((Bill bill) =>
          bill.date.month == selectedMonth.value.month &&
          bill.date.year == selectedMonth.value.year)) {
        total += bill.price;
      }

      for (Category category in categoryList) {
        double sum = calcSum(bills, category.id ?? 0);
        if (sum > 0) {
          final isTouched = chartItems.value.length == touchedIndex.value;
          final fontSize = isTouched ? 18.0 : 14.0;
          final radius = isTouched ? 120.0 : 100.0;
          const shadows = [Shadow(color: Colors.black, blurRadius: 2)];

          displayedCategories.value.add(category);

          chartItems.value.add(
            PieChartSectionData(
              color: Colors.primaries[category.id! % Colors.primaries.length],
              value: sum / total,
              title: isTouched
                  ? '${category.name}\n${priceFormatter.format(sum)}'
                  : "${(sum / total * 100).toStringAsFixed(0)}%",
              radius: radius,
              titleStyle: TextStyle(
                fontSize: fontSize,
                color: const Color(0xffffffff),
                shadows: shadows,
              ),
            ),
          );
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Statistics',
          style: TextStyle(),
        ),
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).pushNamed('bill_list'),
            icon: const Icon(Icons.history),
          ),
        ],
      ),
      body: Builder(
        builder: (context) {
          final billListState = ref.watch(billProvider);
          return billListState!.when(
            data: (List<Bill> bills) {
              // group bills by category
              generateCategories(bills);
              return AnimationLimiter(
                child: RefreshIndicator(
                  backgroundColor: const Color(0xFFFE3F58),
                  color: Colors.white,
                  onRefresh: () async {
                    return ref.read(billProvider.notifier).getBills();
                  },
                  child: GestureDetector(
                    onHorizontalDragEnd: (details) {
                      if (details.primaryVelocity! > 0) {
                        displayedCategories.value = [];
                        chartItems.value = [];
                        selectedMonth.value = DateTime(
                          selectedMonth.value.year,
                          selectedMonth.value.month - 1,
                        );
                      } else if (details.primaryVelocity! < 0) {
                        displayedCategories.value = [];
                        chartItems.value = [];
                        selectedMonth.value = DateTime(
                          selectedMonth.value.year,
                          selectedMonth.value.month + 1,
                        );
                      }
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                child: IconButton(
                                  onPressed: () {
                                    displayedCategories.value = [];
                                    chartItems.value = [];
                                    selectedMonth.value = DateTime(
                                      selectedMonth.value.year,
                                      selectedMonth.value.month - 1,
                                    );
                                  },
                                  icon: const Icon(Icons.arrow_back_ios),
                                  color: const Color(0xFFFE3F58),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Column(
                                  children: [
                                    Text(
                                      dateformat.format(selectedMonth.value),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFFBD8180),
                                        fontSize: 20,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      'Total: ${priceFormatter.format(
                                        calcSum(bills, 0),
                                      )}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: Color(0xFFBD8180),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: IconButton(
                                  onPressed: () {
                                    displayedCategories.value = [];
                                    chartItems.value = [];
                                    selectedMonth.value = DateTime(
                                      selectedMonth.value.year,
                                      selectedMonth.value.month + 1,
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.arrow_forward_ios,
                                    color: Color(0xFFFE3F58),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (displayedCategories.value.isEmpty)
                          const Center(
                            child: Text('No data for this month'),
                          ),
                        if (displayedCategories.value.isNotEmpty)
                          Expanded(
                            child: PieChart(
                              PieChartData(
                                pieTouchData: PieTouchData(
                                  touchCallback:
                                      (FlTouchEvent event, pieTouchResponse) {
                                    if (!event.isInterestedForInteractions ||
                                        pieTouchResponse == null ||
                                        pieTouchResponse.touchedSection ==
                                            null) {
                                      // touchedIndex.value = -1;
                                      return;
                                    }
                                    touchedIndex.value = pieTouchResponse
                                        .touchedSection!.touchedSectionIndex;
                                    displayedCategories.value = [];
                                    chartItems.value = [];
                                    generateCategories(bills);
                                  },
                                ),
                                startDegreeOffset: 180,
                                borderData: FlBorderData(
                                  show: false,
                                ),
                                sectionsSpace: touchedIndex.value == -1 ? 1 : 4,
                                centerSpaceRadius:
                                    touchedIndex.value == -1 ? 0 : 44,
                                sections: chartItems.value,
                              ),
                            ),
                          ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: displayedCategories.value.length,
                            itemBuilder: (context, index) {
                              Category category =
                                  displayedCategories.value[index];
                              return GestureDetector(
                                onTap: () {
                                  touchedIndex.value = index;
                                  displayedCategories.value = [];
                                  chartItems.value = [];
                                  generateCategories(bills);
                                },
                                child: Card(
                                  color: Colors.primaries[
                                      category.id! % Colors.primaries.length],
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  elevation: 2,
                                  margin:
                                      const EdgeInsets.fromLTRB(16, 8, 16, 8),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                          backgroundColor:
                                              const Color(0xFFFFF3F2),
                                          child: Text(
                                            (category.name.toString())
                                                .substring(0, 1),
                                            style: const TextStyle(
                                              color: Color(0xFFBD8180),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 16),
                                        Text(
                                          category.name.toString(),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFFFFF3F2),
                                          ),
                                        ),
                                        const Spacer(),
                                        Text(
                                          priceFormatter.format(
                                            calcSum(bills, category.id ?? 0),
                                          ),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFFFFF3F2),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, st) {
              return Center(
                child: Text(
                  e.toString(),
                ),
              );
            },
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const NewBillPage(),
            ),
          );
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
