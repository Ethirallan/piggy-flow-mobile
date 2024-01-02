import 'dart:io';

import 'package:date_time_picker/date_time_picker.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:piggy_flow_mobile/es_widgets/es_form_slide.dart';
import 'package:piggy_flow_mobile/es_widgets/es_staggered_grid.dart';
import 'package:piggy_flow_mobile/models/account.dart';
import 'package:piggy_flow_mobile/models/bill.dart';
import 'package:piggy_flow_mobile/models/category.dart';
import 'package:piggy_flow_mobile/models/shop.dart';
import 'package:piggy_flow_mobile/providers/account_provider.dart';
import 'package:piggy_flow_mobile/providers/bill_provider.dart';
import 'package:piggy_flow_mobile/providers/category_provider.dart';
import 'package:piggy_flow_mobile/providers/es_message_provider.dart';
import 'package:piggy_flow_mobile/providers/http_provider.dart';
import 'package:piggy_flow_mobile/providers/image_picker_provider.dart';
import 'package:piggy_flow_mobile/providers/shop_provider.dart';

class NewBillPage extends HookConsumerWidget {
  const NewBillPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useAutomaticKeepAlive(wantKeepAlive: true);
    final photos = useState<List<XFile>>([]);
    final pageController = usePageController();
    final page = useState<int>(0);
    const Curve slideCurve = Curves.easeInToLinear;
    const Duration slideDuration = Duration(milliseconds: 300);
    final accountList = ref.read(accountProvider);
    final shopList = ref.read(shopProvider);
    final categoryList = ref.read(categoryProvider);
    final newBill = useState<Bill>(
      Bill(
        date: DateTime.now(),
        price: 0.0,
        comment: '',
        // category: categoryList.first,
        // shop: shopList.first,
      ),
    );
    final priceCtrl = useTextEditingController();
    final commentCtrl = useTextEditingController(
      text: newBill.value.comment,
    );
    final formKey = useState<GlobalKey<FormState>>(GlobalKey<FormState>());
    useListenable(priceCtrl);
    useListenable(pageController);

    Future getImage(ImageSource source) async {
      if (source == ImageSource.camera) {
        final XFile? image = await ref.read(imagePickerProvider).takeAPicture();
        if (image != null) {
          photos.value = [...photos.value, image];
        }
      } else {
        final List<XFile>? images =
            await ref.read(imagePickerProvider).selectPhotosFromGallery();

        if (images != null) {
          for (XFile image in images) {
            photos.value = [...photos.value, image];
          }
        }
      }
    }

    checkDiscard() {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: const Text('Are you sure?'),
            content: const Text('Are you sure you want to discard this bill?'),
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
                        title: 'How much did you spend?',
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
                              priceCtrl.clear;
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
                            newBill.value = newBill.value.copyWith(
                              account: value == 'Personal'
                                  ? null
                                  : accountList
                                      .where((Account account) =>
                                          account.name == value)
                                      .first,
                            );
                          },
                          selectedItem:
                              newBill.value.account?.name ?? 'Personal',
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
                            newBill.value = newBill.value.copyWith(
                                category: categoryList
                                    .where((Category category) =>
                                        category.name == value)
                                    .first);
                          },
                          selectedItem: newBill.value.category?.name ?? '',
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
                            newBill.value = newBill.value.copyWith(
                                shop: shopList
                                    .where((Shop shop) => shop.name == value)
                                    .first);
                          },
                          selectedItem: newBill.value.shop?.name ?? '',
                        ),
                      ),
                      ESFormSlide(
                        title: 'Photos',
                        buttonLabel: 'CONTINUE',
                        next: () {
                          pageController.nextPage(
                              duration: slideDuration, curve: slideCurve);
                          page.value++;
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            if (photos.value.isNotEmpty) const Text('Photos:'),
                            if (photos.value.isNotEmpty)
                              const SizedBox(
                                height: 10,
                              ),
                            if (photos.value.isNotEmpty)
                              SizedBox(
                                height: 120,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: photos.value.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return ESStaggeredGrid(
                                      index: index,
                                      child: Padding(
                                        padding: const EdgeInsets.all(4),
                                        child: Stack(
                                          children: [
                                            SizedBox(
                                              height: 110,
                                              width: 110,
                                              child: Card(
                                                elevation: 4,
                                                shape:
                                                    const RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(15),
                                                  ),
                                                ),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                    Radius.circular(15),
                                                  ),
                                                  child: Image.file(
                                                    File(photos
                                                        .value[index].path),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              right: 4,
                                              top: 4,
                                              child: Container(
                                                height: 30,
                                                width: 30,
                                                decoration: const BoxDecoration(
                                                  shape: BoxShape.circle,
                                                ),
                                                child: IconButton(
                                                  icon: const Icon(
                                                    Icons.clear,
                                                    size: 20,
                                                  ),
                                                  padding: EdgeInsets.zero,
                                                  onPressed: () {
                                                    photos.value
                                                        .removeAt(index);
                                                    var temp = photos.value;
                                                    photos.value = [];
                                                    photos.value = temp;
                                                  },
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            const SizedBox(
                              height: 20,
                            ),
                            // elevated button for adding photos
                            ElevatedButton(
                              onPressed: () {
                                getImage(ImageSource.camera);
                              },
                              child: const Text('Add a photo'),
                            ),
                          ],
                        ),
                      ),
                      ESFormSlide(
                        title: 'Date and comment',
                        buttonLabel: 'Save',
                        next: () async {
                          newBill.value = newBill.value.copyWith(
                            price: double.parse(
                              priceCtrl.text.replaceAll('€', '').trim(),
                            ),
                            comment: commentCtrl.text,
                          );

                          bool success = await ref
                              .read(httpProvider)
                              .addBill(newBill.value, photos.value);
                          if (success) {
                            ref.read(esMessageProvider.state).state =
                                const ESMessage(
                              'Successfuly added new bill',
                              Colors.green,
                            );
                            ref.read(billProvider.notifier).getBills();
                            if (context.mounted) Navigator.pop(context);
                          } else {
                            ref.read(esMessageProvider.state).state =
                                const ESMessage(
                              'Error creating new bill',
                              Colors.red,
                            );
                          }
                        },
                        child: Column(
                          children: [
                            DateTimePicker(
                              type: DateTimePickerType.dateTime,
                              initialValue: DateTime.now().toString(),
                              dateMask: 'dd. MM. yyyy HH:mm',
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2100),
                              dateLabelText: 'Date and time',
                              onChanged: (String? val) {
                                if (val != null) {
                                  newBill.value = newBill.value.copyWith(
                                    date: DateTime.parse(val),
                                  );
                                }
                              },
                            ),
                            TextFormField(
                              controller: commentCtrl,
                              minLines: 1,
                              maxLines: 30,
                              keyboardType: TextInputType.multiline,
                              decoration: const InputDecoration(
                                labelText: 'Notes',
                                hintText: 'Add notes',
                              ),
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
