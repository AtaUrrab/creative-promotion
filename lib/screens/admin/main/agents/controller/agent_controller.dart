import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/constant/enums.dart';
import '../../../../../core/services/firebase/firestore_service.dart';
import '../../../../../models/user_model.dart';

class AgentController extends GetxController {
  final TextEditingController search = TextEditingController();
  List<UserModel> totalAgents = [];
  List<UserModel> filterAgents = [];

  void onSearch(String value) {
    filterAgents = totalAgents
        .where((element) =>
            element.firstName.toLowerCase().contains(value.toLowerCase()) ||
            element.lastName.toLowerCase().contains(value.toLowerCase()) ||
            element.email.toLowerCase().contains(value.toLowerCase()))
        .toList();
    update();
  }

  Future<void> restrictAgent(String uid) async {
    await FirestoreService.restrictUser(uid, UserStatus.decline);
  }

  Future<void> unRestrictAgent(String uid) async {
    await FirestoreService.restrictUser(uid, UserStatus.approved);
  }

  changeComission(
      BuildContext context, String userid, double currentComission) async {
    bool isSuccess = false;
    final formKey = GlobalKey<FormState>();
    final commission = TextEditingController(text: currentComission.toString());
    await showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
              title: const Text('Change comission'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    const Text('Enter the comission for this agent'),
                    Form(
                      key: formKey,
                      child: TextFormField(
                        controller: commission,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please add the commission";
                          }
                          if (!value.isNum) {
                            return "Please add the commission in digits";
                          }
                          if (value.contains('0.0')) {
                            return "Please add the right commission";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                            suffixIcon: Icon(Icons.attach_money_outlined)),
                      ),
                    )
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text('Done'),
                  onPressed: () {
                    if (!formKey.currentState!.validate()) return;
                    FirestoreService.updateCommission(
                        userid, double.parse(commission.text));
                    isSuccess = true;
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                    update();
                  },
                ),
              ]);
        });
    return isSuccess;
  }
}
