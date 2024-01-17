import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/utils/references.dart';
import '../../../../../core/widgets/button.dart';
import 'add_screen.dart';

class ThankYouScreen extends StatefulWidget {
  const ThankYouScreen({super.key});

  @override
  State<ThankYouScreen> createState() => _ThankYouScreenState();
}

class _ThankYouScreenState extends State<ThankYouScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              Assets.logo,
              width: Get.width * 0.3,
            ),
          ],
        ),
        const Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Thank You!",
                style: TextStyle(fontSize: 24),
                textAlign: TextAlign.center,
              ),
              Text(
                "Store information has been \nsubmitted",
                style: TextStyle(fontSize: 24),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 50)
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          width: double.infinity,
          child: AppButton(
              onTap: () {
                Get.offAll(() => const AddScreen());
              },
              title: "OK"),
        ),
        const SizedBox(height: 50)
      ]),
    );
  }
}
