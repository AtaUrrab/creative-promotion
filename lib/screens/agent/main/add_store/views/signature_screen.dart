import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:signature/signature.dart';

import '../../../../../core/helpers/helper_class.dart';
import '../../../../../core/utils/colors.dart';
import '../../../../../core/utils/references.dart';
import '../../../../../core/widgets/button.dart';
import '../../../../../core/widgets/cards.dart';
import '../../../../../core/widgets/selcted_category_widget.dart';
import '../../../../../core/widgets/textfield.dart';
import '../controllers/add_controller.dart';

class SignatureScreen extends StatelessWidget {
  const SignatureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddController());

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Add your signature",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: GetBuilder<AddController>(
            init: AddController(),
            builder: (_) {
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        Assets.logo,
                        width: Get.width * 0.2,
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                  CheckBoxTileWidget(
                    value: controller.isSelectColdVault,
                    onChanged: (value) {
                      controller.isSelectColdVault = value ?? false;
                      controller.update();
                    },
                  ),
                  const SizedBox(height: 25),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 15,
                              offset: const Offset(0, 15),
                              color: Colors.black.withOpacity(0.1))
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Visibility(
                              visible: _.isSelectColdVault,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  const SizedBox(height: 20),
                                  AttachImageWidget(
                                    imgAssetPath: controller.coldVault,
                                    onTap: () async {
                                      XFile? dynamicImagePath =
                                          (await HelperClass()
                                              .bottomSheetImagePicker(context));
                                      controller.update();
                                      if (dynamicImagePath == null) {
                                        return;
                                      }
                                      controller.coldVault =
                                          dynamicImagePath.path;
                                      controller.update();
                                    },
                                  ),
                                  const SizedBox(height: 20),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(20),
                              child: GestureDetector(
                                onTap: () =>
                                    _openSignatureDialog(context, controller),
                                child: Container(
                                    height: 100,
                                    decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                              blurRadius: 5,
                                              offset: const Offset(0, 5),
                                              color:
                                                  Colors.black.withOpacity(0.1))
                                        ],
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: controller.signature.isEmpty
                                        ? const Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(Icons.add),
                                              Text(
                                                  "Tap here to add your signature!")
                                            ],
                                          )
                                        : Image.asset(controller.signature)),
                              ),
                            ),
                          ]),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFieldWidget(
                    isSnableMaxLines: true,
                    maxlines: 5,
                    hintText: "Additional Information (Optional)",
                    controller: controller.additionalInfo,
                  ),
                  const SizedBox(height: 20),
                  Form(
                    key: controller.categoryFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Supplied Stock: ",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
                        SelectCategoryWidget(
                          title: 'Full Synthethic - OW-20',
                          isSelectedBox: controller.isSyncthethicSelectedOW20,
                          onTap: () {
                            controller.fieldFullySyntyheticOW20.requestFocus();
                            controller.isSyncthethicSelectedOW20 =
                                !controller.isSyncthethicSelectedOW20;
                            controller.fullySyntyheticOW20.clear();
                            controller.update();
                          },
                        ),
                        controller.isSyncthethicSelectedOW20 == true
                            ? const SizedBox(height: 10)
                            : const Offstage(),
                        controller.isSyncthethicSelectedOW20 == true
                            ? TextFieldWidget(
                                hintText: "Quantity",
                                controller: controller.fullySyntyheticOW20,
                                keyboardType: TextInputType.number,
                                focusNode: controller.fieldFullySyntyheticOW20,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  if (!value.isNum) {
                                    return 'Please enter Quantity in digits';
                                  }
                                  return null;
                                },
                              )
                            : const Offstage(),
                        SelectCategoryWidget(
                          title: 'Full Synthethic - 5W-20',
                          isSelectedBox: controller.isSyncthethicSelected5W20,
                          onTap: () {
                            controller.fieldFullySyntyheticOW20.unfocus();
                            controller.fieldFullySyntyhetic5W20.requestFocus();
                            controller.isSyncthethicSelected5W20 =
                                !controller.isSyncthethicSelected5W20;
                            controller.fullySyntyhetic5W20.clear();
                            controller.update();
                          },
                        ),
                        controller.isSyncthethicSelected5W20 == true
                            ? const SizedBox(height: 10)
                            : const Offstage(),
                        controller.isSyncthethicSelected5W20 == true
                            ? TextFieldWidget(
                                hintText: "Quantity",
                                controller: controller.fullySyntyhetic5W20,
                                keyboardType: TextInputType.number,
                                focusNode: controller.fieldFullySyntyhetic5W20,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  if (!value.isNum) {
                                    return 'Please enter Quantity in digits';
                                  }
                                  return null;
                                },
                              )
                            : const Offstage(),
                        SelectCategoryWidget(
                          title: 'Full Synthethic - 5W-30',
                          isSelectedBox: controller.isSyncthethicSelected5W30,
                          onTap: () {
                            controller.fieldFullySyntyhetic5W20.unfocus();
                            controller.fieldFullySyntyhetic5W30.requestFocus();
                            controller.isSyncthethicSelected5W30 =
                                !controller.isSyncthethicSelected5W30;
                            controller.fullySyntyhetic5W30.clear();
                            controller.update();
                          },
                        ),
                        controller.isSyncthethicSelected5W30 == true
                            ? const SizedBox(height: 10)
                            : const Offstage(),
                        controller.isSyncthethicSelected5W30 == true
                            ? TextFieldWidget(
                                hintText: "Quantity",
                                controller: controller.fullySyntyhetic5W30,
                                keyboardType: TextInputType.number,
                                focusNode: controller.fieldFullySyntyhetic5W30,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  if (!value.isNum) {
                                    return 'Please enter Quantity in digits';
                                  }
                                  return null;
                                },
                              )
                            : const Offstage(),
                        SelectCategoryWidget(
                          title: 'High Mileage - OW-20',
                          isSelectedBox: controller.isMileageSelectedOW20,
                          onTap: () {
                            controller.fieldFullySyntyhetic5W30.unfocus();
                            controller.fieldHighMileageOW20.requestFocus();
                            controller.isMileageSelectedOW20 =
                                !controller.isMileageSelectedOW20;
                            controller.highMileageOW20.clear();
                            controller.update();
                          },
                        ),
                        controller.isMileageSelectedOW20 == true
                            ? const SizedBox(height: 10)
                            : const Offstage(),
                        controller.isMileageSelectedOW20 == true
                            ? TextFieldWidget(
                                hintText: "Quantity",
                                controller: controller.highMileageOW20,
                                keyboardType: TextInputType.number,
                                focusNode: controller.fieldHighMileageOW20,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  if (!value.isNum) {
                                    return 'Please enter Quantity in digits';
                                  }
                                  return null;
                                },
                              )
                            : const Offstage(),
                        SelectCategoryWidget(
                          title: 'High Mileage - 5W-20',
                          isSelectedBox: controller.isMileageSelected5W20,
                          onTap: () {
                            controller.fieldHighMileageOW20.unfocus();
                            controller.fieldHighMileage5W20.requestFocus();
                            controller.isMileageSelected5W20 =
                                !controller.isMileageSelected5W20;
                            controller.highMileage5W20.clear();
                            controller.update();
                          },
                        ),
                        controller.isMileageSelected5W20 == true
                            ? const SizedBox(height: 10)
                            : const Offstage(),
                        controller.isMileageSelected5W20 == true
                            ? TextFieldWidget(
                                hintText: "Quantity",
                                controller: controller.highMileage5W20,
                                keyboardType: TextInputType.number,
                                focusNode: controller.fieldHighMileage5W20,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  if (!value.isNum) {
                                    return 'Please enter Quantity in digits';
                                  }
                                  return null;
                                },
                              )
                            : const Offstage(),
                        SelectCategoryWidget(
                          title: 'High Mileage - 5W-30',
                          isSelectedBox: controller.isMileageSelected5W30,
                          onTap: () {
                            controller.fieldHighMileage5W20.unfocus();
                            controller.fieldHighMileage5W30.requestFocus();
                            controller.isMileageSelected5W30 =
                                !controller.isMileageSelected5W30;
                            controller.highMileage5W30.clear();
                            controller.update();
                          },
                        ),
                        controller.isMileageSelected5W30 == true
                            ? const SizedBox(height: 10)
                            : const Offstage(),
                        controller.isMileageSelected5W30 == true
                            ? TextFieldWidget(
                                hintText: "Quantity",
                                controller: controller.highMileage5W30,
                                keyboardType: TextInputType.number,
                                focusNode: controller.fieldHighMileage5W30,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  if (!value.isNum) {
                                    return 'Please enter Quantity in digits';
                                  }
                                  return null;
                                },
                              )
                            : const Offstage(),
                        SelectCategoryWidget(
                          title: 'Advance - OW-20',
                          isSelectedBox: controller.isAdvanceSelectedOW20,
                          onTap: () {
                            controller.fieldHighMileage5W30.unfocus();
                            controller.fieldAdvanceOW20.requestFocus();
                            controller.isAdvanceSelectedOW20 =
                                !controller.isAdvanceSelectedOW20;
                            controller.advanceOW20.clear();
                            controller.update();
                          },
                        ),
                        controller.isAdvanceSelectedOW20 == true
                            ? const SizedBox(height: 10)
                            : const Offstage(),
                        controller.isAdvanceSelectedOW20 == true
                            ? TextFieldWidget(
                                hintText: "Quantity",
                                controller: controller.advanceOW20,
                                keyboardType: TextInputType.number,
                                focusNode: controller.fieldAdvanceOW20,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  if (!value.isNum) {
                                    return 'Please enter Quantity in digits';
                                  }
                                  return null;
                                },
                              )
                            : const Offstage(),
                        SelectCategoryWidget(
                          title: 'Advance - 5W-20',
                          isSelectedBox: controller.isAdvanceSelected5W20,
                          onTap: () {
                            controller.fieldAdvanceOW20.unfocus();
                            controller.fieldAdvance5W20.requestFocus();
                            controller.isAdvanceSelected5W20 =
                                !controller.isAdvanceSelected5W20;
                            controller.advance5W20.clear();
                            controller.update();
                          },
                        ),
                        controller.isAdvanceSelected5W20 == true
                            ? const SizedBox(height: 10)
                            : const Offstage(),
                        controller.isAdvanceSelected5W20 == true
                            ? TextFieldWidget(
                                hintText: "Quantity",
                                controller: controller.advance5W20,
                                keyboardType: TextInputType.number,
                                focusNode: controller.fieldAdvance5W20,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  if (!value.isNum) {
                                    return 'Please enter Quantity in digits';
                                  }
                                  return null;
                                },
                              )
                            : const Offstage(),
                        SelectCategoryWidget(
                          title: 'Advance - 5W-30',
                          isSelectedBox: controller.isAdvanceSelected5W30,
                          onTap: () {
                            controller.fieldAdvance5W20.unfocus();
                            controller.fieldAdvance5W30.requestFocus();
                            controller.isAdvanceSelected5W30 =
                                !controller.isAdvanceSelected5W30;
                            controller.advance5W30.clear();
                            controller.update();
                          },
                        ),
                        controller.isAdvanceSelected5W30 == true
                            ? const SizedBox(height: 10)
                            : const Offstage(),
                        controller.isAdvanceSelected5W30 == true
                            ? TextFieldWidget(
                                hintText: "Quantity",
                                controller: controller.advance5W30,
                                keyboardType: TextInputType.number,
                                focusNode: controller.fieldAdvance5W30,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                  if (!value.isNum) {
                                    return 'Please enter Quantity in digits';
                                  }
                                  return null;
                                },
                              )
                            : const Offstage(),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    child: AppButton(
                      onTap: () => controller.gotoThankYouScreen(),
                      title: "Submit",
                    ),
                  ),
                  const SizedBox(height: 50),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  _openSignatureDialog(BuildContext context, AddController controller) async {
    controller.signatureController.clear();
    await showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
              title: const Text('Store manager signature'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    ClipRRect(
                      child: Container(
                        width: Get.width * 0.8,
                        height: Get.height * 0.2,
                        decoration: BoxDecoration(border: Border.all()),
                        child: Signature(
                          height: Get.height * 0.2,
                          controller: controller.signatureController,
                          width: double.infinity,
                          backgroundColor: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              actions: [
                TextButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text('Done'),
                  onPressed: () async {
                    Navigator.of(context).pop();
                    final image =
                        await controller.signatureController.toPngBytes();
                    if (image == null) return;
                    final tempDir = await getTemporaryDirectory();
                    File file = await File(
                            '${tempDir.path}/signature${DateTime.now().microsecondsSinceEpoch}.png')
                        .create();
                    file.writeAsBytesSync(image);
                    controller.signature = file.path;
                    controller.update();
                  },
                ),
              ]);
        });
  }
}

class CheckBoxTileWidget extends StatelessWidget {
  final bool value;
  final void Function(bool?)? onChanged;
  const CheckBoxTileWidget({
    super.key,
    required this.value,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Checkbox(
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          value: value,
          onChanged: onChanged,
          activeColor: AppColor.red,
        ),
        const Flexible(
          child: Text(
            "If the store owner wants more free oil then we need to take their picture of cold vault.",
            style: TextStyle(overflow: TextOverflow.visible),
          ),
        ),
      ],
    );
  }
}
