import 'package:creativepromotion/core/utils/colors.dart';
import 'package:flutter/material.dart';

class AppDialog {
  static Future showOSDialog({
    required BuildContext context,
    required String title,
    required String message,
    required String firstButtonText,
    required VoidCallback firstCallBack,
    required String secondButtonText,
    required VoidCallback secondCallBack,
    bool isCrossDisabled = false,
  }) async {
    await showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return WillPopScope(
            onWillPop: () async => false,
            child: CustomDialog(
              title: title,
              description: message,
              firstButtonText: firstButtonText,
              firstCallback: firstCallBack,
              secondButtonText: secondButtonText,
              secondCallback: secondCallBack,
              isCrossDisabled: isCrossDisabled,
            ));
      },
    );
  }
}

class CustomDialog extends StatelessWidget {
  final String title, description, firstButtonText, secondButtonText;
  final VoidCallback firstCallback, secondCallback;
  final bool isCrossDisabled;
  const CustomDialog(
      {Key? key,
      required this.isCrossDisabled,
      required this.title,
      required this.description,
      required this.firstCallback,
      required this.secondCallback,
      required this.firstButtonText,
      required this.secondButtonText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Stack(
              children: [
                Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title,
                          softWrap: true,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 24),
                      Text(description, style: const TextStyle(fontSize: 16)),
                      const SizedBox(height: 33),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Visibility(
                            visible: firstButtonText.isNotEmpty,
                            child: MaterialButton(
                              splashColor: Colors.transparent,
                              onPressed: firstCallback,
                              child: Text(
                                firstButtonText,
                                softWrap: true,
                                style: const TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                          const Spacer(),
                          MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            splashColor: Colors.transparent,
                            elevation: 0,
                            disabledElevation: 0,
                            onPressed: secondCallback,
                            color: AppColor.red,
                            child: Text(
                              secondButtonText,
                              style: const TextStyle(color: Colors.white),
                            ),
                          )
                        ],
                      )
                    ]),
                Positioned(
                    right: 0,
                    top: 0,
                    child: isCrossDisabled
                        ? InkWell(
                            borderRadius: BorderRadius.circular(20),
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(1),
                              child: Icon(Icons.cancel_rounded),
                            ),
                          )
                        : const SizedBox()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
