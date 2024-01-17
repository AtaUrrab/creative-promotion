import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/constant/enums.dart';
import '../../../../../core/services/firebase/firestore_service.dart';
import '../../../../../models/user_model.dart';

class WarehouseManagerController extends GetxController {
  final TextEditingController search = TextEditingController();
  List<UserModel> totalManagers = [];
  List<UserModel> filterManagers = [];
  String userID = '';

  void onSearch(String value) {
    filterManagers = totalManagers
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
}
