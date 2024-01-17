import 'package:creativepromotion/core/utils/colors.dart';
import 'package:creativepromotion/screens/agent/main/add_store/controllers/add_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/widgets/button.dart';
import '../../../../../core/widgets/textfield.dart';

class AgreementScreen extends StatelessWidget {
  const AgreementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("MOTOR OIL PROMOTION"),
        titleTextStyle: const TextStyle(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: controller.secondFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Divider(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GetBuilder<AddController>(
                      builder: (_) => Checkbox(
                        value: controller.isFirstAggrement,
                        onChanged: (value) {
                          controller.isFirstAggrement = value ?? false;
                          controller.update();
                        },
                        activeColor: AppColor.red,
                      ),
                    ),
                    const Flexible(
                      child: Text(
                        "The Creative Promotion Company is centered around various short term promotional programs, marketing activities, and various product special offerings. The Creative Promotion Company also engages in as a promoter of various special programing and promotions found locally or nationally from public domain. Each promotional project is unique in nature and promotional time frame may differ from few weeks to several months. The Creative Promotion Company reserves the right to modify or cancel the offer at any time without any notice. Offers only applies to product identified below. The Creative Promotion Company’s current offer is good while supplies last and it cannot be combined with any other offer. The offer is for physical goods and is non-transferrable and may not be redistributed without written consent. By accepting the promotion, the retailer agrees to pay all the necessary local, state, & federal taxes after the sale of promotional products. The retail outlet owner or manager agree to indemnify, hold harmless, and defend The Creative Promotion Company's officers, directors, and employees, from and against any claim, demand, cause of action, debt, loss or liability, including reasonable attorneys' fees. Any major dispute or legal actions against The Creative Promotion Company associated with current promotion or marketing of the product must be taken to legal system reside in the Sate of Delaware and its Court system. The offering is only available to retailers located in the United States and are subject to the terms and condition. Comments and questions can be sent at thecreativepromotion@gmail.com.\n\nMOTOR OIL PROMOTION REQUIREMENTS AND DETAILS \n\nThe retailer will receive one time fill, upon accepting terms and condition, at least 18 (one quart) motor oil at no cost to retailer. The motor oil includes Mobil 1TM and MobilTM products. The promotional SKUs listed below will be placed and planogramed wherever automotive section or category located in the store. Retailer agrees to accept approved SKUs, allow advertising shelf talker to be placed, maintain merchandising standards from the date of initial set-up and re-order the SKUs as needed.",
                        overflow: TextOverflow.visible,
                      ),
                    ),
                  ],
                ),
                const Divider(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GetBuilder<AddController>(
                      builder: (_) => Checkbox(
                        value: controller.isSecondAggrement,
                        activeColor: AppColor.red,
                        onChanged: (value) {
                          controller.isSecondAggrement = value ?? false;
                          controller.update();
                        },
                      ),
                    ),
                    const Flexible(
                      child: Text(
                        "Permission Required: The retailer is giving The Creative Promotion Company and its representative permission to take pictures of the following section at the retailer outlet; Automotive category or section pictures before initial setup and Automotive category or section pictures after setup is completed.",
                        overflow: TextOverflow.visible,
                      ),
                    ),
                  ],
                ),
                const Divider(),
                TextFieldWidget(
                  enabled: false,
                  readyOnly: true,
                  controller:
                      TextEditingController(text: controller.designation),
                  hintText: "Title",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFieldWidget(
                  enabled: false,
                  readyOnly: true,
                  controller: controller.name,
                  hintText: "Full Name",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFieldWidget(
                  readyOnly: true,
                  enabled: false,
                  controller: controller.email,
                  hintText: "Email",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    if (!value.isEmail) {
                      return 'Please enter valid email address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFieldWidget(
                  controller:
                      TextEditingController(text: controller.storePhone.text),
                  hintText: "Phone",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    if (!value.isPhoneNumber) {
                      return 'Please enter valid phone number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFieldWidget(
                  controller: controller.storeName,
                  hintText: "Store Name",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFieldWidget(
                  controller: controller.storeAddress,
                  hintText: "Store Address",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 25),
                AppButton(
                  color: AppColor.red,
                  titleStyle: const TextStyle(color: Colors.white),
                  onTap: controller.gotoOilScreen,
                  title: "Continue",
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
