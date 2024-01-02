import 'package:date_time_picker/date_time_picker.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:piggy_flow_mobile/es_widgets/es_form_slide.dart';
import 'package:piggy_flow_mobile/models/account.dart';
import 'package:piggy_flow_mobile/models/subscription.dart';
import 'package:piggy_flow_mobile/models/category.dart';
import 'package:piggy_flow_mobile/models/shop.dart';
import 'package:piggy_flow_mobile/providers/account_provider.dart';
import 'package:piggy_flow_mobile/providers/subscription_provider.dart';
import 'package:piggy_flow_mobile/providers/category_provider.dart';
import 'package:piggy_flow_mobile/providers/es_message_provider.dart';
import 'package:piggy_flow_mobile/providers/http_provider.dart';
import 'package:piggy_flow_mobile/providers/shop_provider.dart';

class NewSubscriptionPage extends HookConsumerWidget {
  const NewSubscriptionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useAutomaticKeepAlive(wantKeepAlive: true);
    final pageController = usePageController();
    final page = useState<int>(0);
    const Curve slideCurve = Curves.easeInToLinear;
    const Duration slideDuration = Duration(milliseconds: 300);
    final accountList = ref.read(accountProvider);
    final shopList = ref.read(shopProvider);
    final categoryList = ref.read(categoryProvider);
    final newSubscription = useState<Subscription>(
      Subscription(
        chargeDay: DateTime.now().day,
        price: 0.0,
        name: '',
        // category: categoryList.first,
        // shop: shopList.first,
      ),
    );
    final formKey = useState<GlobalKey<FormState>>(GlobalKey<FormState>());
    final nameCtrl = useTextEditingController(
      text: newSubscription.value.name,
    );
    final priceCtrl = useTextEditingController();
    useListenable(nameCtrl);
    useListenable(priceCtrl);
    useListenable(pageController);

    checkDiscard() {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: const Text('Are you sure?'),
            content: const Text(
              'Are you sure you want to discard this subscription?',
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: const Text('Yes'),
              ),
            ],
          );
        },
      );
    }

    return WillPopScope(
      onWillPop: () async {
        if (page.value == 0) {
          checkDiscard();
        } else {
          pageController.previousPage(
              duration: slideDuration, curve: slideCurve);
          page.value--;
        }
        return false;
      },
      child: Scaffold(
        body: SafeArea(
          child: Form(
            key: formKey.value,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: SizedBox(
                    height: 120,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        page.value > 0
                            ? IconButton(
                                onPressed: () {
                                  pageController.previousPage(
                                    duration: slideDuration,
                                    curve: slideCurve,
                                  );
                                  page.value--;
                                },
                                icon: const Icon(Icons.arrow_back),
                              )
                            : const SizedBox(
                                width: 48,
                              ),
                        Image.asset('assets/piggy-flow-icon.png'),
                        IconButton(
                          onPressed: () => checkDiscard(),
                          icon: const Icon(Icons.clear),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: PageView(
                    controller: pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      ESFormSlide(
                        title: 'How do you want to call this subscription?',
                        buttonLabel: 'CONTINUE',
                        buttonEnabled: nameCtrl.value.text.length > 2,
                        next: () {
                          FocusManager.instance.primaryFocus?.unfocus();
                          if (formKey.value.currentState!.validate()) {
                            pageController.nextPage(
                              duration: slideDuration,
                              curve: slideCurve,
                            );
                            page.value++;
                          }
                        },
                        child: TextFormField(
                          controller: nameCtrl,
                          decoration: const InputDecoration(
                            labelText: 'Subscription name',
                            // border: InputBorder.none,
                          ),
                          style: const TextStyle(
                            // fontSize: 50,
                            fontWeight: FontWeight.bold,
                          ),
                          autofocus: true,
                          onChanged: (String value) {
                            if (value == '') {
                              nameCtrl.clear();
                            } else {
                              nameCtrl.value = nameCtrl.value.copyWith(
                                text: value,
                              );
                            }
                          },
                          textInputAction: TextInputAction.next,
                          validator: (String? value) {
                            if (value == null || value.isEmpty || value.length < 3) {
                              return '';
                            }
                            return null;
                          },
                          onEditingComplete: () {
                            FocusManager.instance.primaryFocus?.unfocus();
                            if (formKey.value.currentState!.validate()) {
                              pageController.nextPage(
                                  duration: slideDuration, curve: slideCurve);
                              page.value++;
                            }
                          },
                        ),
                      ),
                      ESFormSlide(
                        title: 'How much is the cost of subscription?',
                        buttonLabel: 'CONTINUE',
                        buttonEnabled: priceCtrl.value.text.length > 1,
                        next: () {
                          FocusManager.instance.primaryFocus?.unfocus();
                          if (formKey.value.currentState!.validate()) {
                            pageController.nextPage(
                                duration: slideDuration, curve: slideCurve);
                            page.value++;
                          }
                        },
                        child: TextFormField(
                          controller: priceCtrl,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                              RegExp(r'^\d*\.?\d{0,2}'),
                            ),
                          ],
                          decoration: const InputDecoration(
                            hintText: '0.00 €',
                            border: InputBorder.none,
                          ),
                          enableInteractiveSelection: false,
                          showCursor: false,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 50,
                            fontWeight: FontWeight.bold,
                          ),
                          autofocus: true,
                          onChanged: (String value) {
                            if (value == '') {
                              priceCtrl.clear();
                            } else {
                              priceCtrl.value = priceCtrl.value.copyWith(
                                text: "$value €",
                              );
                            }
                          },
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          textInputAction: TextInputAction.next,
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return '';
                            }
                            return null;
                          },
                          onEditingComplete: () {
                            FocusManager.instance.primaryFocus?.unfocus();
                            if (formKey.value.currentState!.validate()) {
                              pageController.nextPage(
                                  duration: slideDuration, curve: slideCurve);
                              page.value++;
                            }
                          },
                        ),
                      ),
                      ESFormSlide(
                        title: 'Account',
                        buttonLabel: 'CONTINUE',
                        next: () {
                          pageController.nextPage(
                              duration: slideDuration, curve: slideCurve);
                          page.value++;
                        },
                        child: DropdownSearch<String>(
                          popupProps: const PopupProps.menu(
                            showSelectedItems: true,
                          ),
                          items: [
                            'Personal',
                            ...accountList
                                .map((Account account) => account.name)
                                .toList()
                          ],
                          dropdownDecoratorProps: const DropDownDecoratorProps(
                            dropdownSearchDecoration: InputDecoration(
                              labelText: 'Account',
                              hintText: 'Select an account',
                            ),
                          ),
                          onChanged: (value) {
                            newSubscription.value =
                                newSubscription.value.copyWith(
                              account: value == 'Personal'
                                  ? null
                                  : accountList
                                      .where((Account account) =>
                                          account.name == value)
                                      .first,
                            );
                          },
                          selectedItem:
                              newSubscription.value.account?.name ?? 'Personal',
                        ),
                      ),
                      ESFormSlide(
                        title: 'Category',
                        buttonLabel: 'CONTINUE',
                        next: () {
                          pageController.nextPage(
                              duration: slideDuration, curve: slideCurve);
                          page.value++;
                        },
                        child: DropdownSearch<String>(
                          popupProps: const PopupProps.menu(
                            showSelectedItems: true,
                          ),
                          items: categoryList
                              .map((Category category) => category.name)
                              .toList(),
                          dropdownDecoratorProps: const DropDownDecoratorProps(
                            dropdownSearchDecoration: InputDecoration(
                              labelText: 'Category',
                              hintText: 'Select a category',
                            ),
                          ),
                          onChanged: (value) {
                            newSubscription.value = newSubscription.value
                                .copyWith(
                                    category: categoryList
                                        .where((Category category) =>
                                            category.name == value)
                                        .first);
                          },
                          selectedItem:
                              newSubscription.value.category?.name ?? '',
                        ),
                      ),
                      ESFormSlide(
                        title: 'Shop',
                        buttonLabel: 'CONTINUE',
                        next: () {
                          pageController.nextPage(
                              duration: slideDuration, curve: slideCurve);
                          page.value++;
                        },
                        child: DropdownSearch<String>(
                          popupProps: const PopupProps.menu(
                            showSelectedItems: true,
                          ),
                          items:
                              shopList.map((Shop shop) => shop.name).toList(),
                          dropdownDecoratorProps: const DropDownDecoratorProps(
                            dropdownSearchDecoration: InputDecoration(
                              labelText: 'Shop',
                              hintText: 'Select a shop',
                            ),
                          ),
                          onChanged: (value) {
                            newSubscription.value = newSubscription.value
                                .copyWith(
                                    shop: shopList
                                        .where(
                                            (Shop shop) => shop.name == value)
                                        .first);
                          },
                          selectedItem: newSubscription.value.shop?.name ?? '',
                        ),
                      ),
                      ESFormSlide(
                        title: 'When is the next charge day?',
                        buttonLabel: 'Save',
                        next: () async {
                          newSubscription.value =
                              newSubscription.value.copyWith(
                            price: double.parse(
                              priceCtrl.text.replaceAll('€', '').trim(),
                            ),
                            name: nameCtrl.text,
                          );

                          bool success = await ref
                              .read(httpProvider)
                              .addSubscription(newSubscription.value);
                          if (success) {
                            ref.read(esMessageProvider.state).state =
                                const ESMessage(
                              'Successfuly added new subscription',
                              Colors.green,
                            );
                            ref
                                .read(subscriptionProvider.notifier)
                                .getSubscriptions();
                            if (context.mounted) Navigator.pop(context);
                          } else {
                            ref.read(esMessageProvider.state).state =
                                const ESMessage(
                              'Error creating new subscription',
                              Colors.red,
                            );
                          }
                        },
                        child: Column(
                          children: [
                            DateTimePicker(
                              type: DateTimePickerType.date,
                              initialValue: DateTime.now().toString(),
                              dateMask: 'dd. MM. yyyy',
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2100),
                              dateLabelText: 'Next charge date',
                              onChanged: (String? val) {
                                if (val != null) {
                                  newSubscription.value =
                                      newSubscription.value.copyWith(
                                    chargeDay: DateTime.parse(val).day,
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
