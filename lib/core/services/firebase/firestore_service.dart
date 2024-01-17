import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:creativepromotion/core/constant/constant.dart';
import 'package:creativepromotion/models/supply_stock_model.dart';
import 'package:get/get.dart';

import '../../../models/notifications_model.dart';
import '../../../models/store_model.dart';
import '../../../models/user_model.dart';
import '../../../models/warehouse_model.dart';

import '../../constant/enums.dart';
import '../../utils/loading_helper.dart';

class FirestoreService {
  static Future<UserModel?> getCurrentUser(String uid) async {
    try {
      final user = await FirebaseFirestore.instance
          .collection(Collection.users.name)
          .doc(uid)
          .get();
      if (!user.exists) {
        return null;
      }
      return UserModel.fromMap(user.data()!);
    } on FirebaseException catch (e) {
      LoadingHelper.hideLoading();
      log(e.message.toString());
      return null;
    }
  }

  static Future<void> setSupplyStock(SupplyModel supply) async {
    try {
      LoadingHelper.showLoading();
      await FirebaseFirestore.instance
          .collection(Collection.supply.name)
          .doc(supply.id)
          .set(supply.toMap());
      LoadingHelper.hideLoading();
    } on FirebaseException catch (e) {
      LoadingHelper.hideLoading();
      log(e.message.toString());
    }
  }

  static Future<bool> updateStatus(
      NotificationsModel notification, UserStatus status) async {
    try {
      await FirebaseFirestore.instance
          .collection(Collection.notifications.name)
          .doc(notification.id)
          .update({"status": status.name});
      await FirebaseFirestore.instance
          .collection(Collection.users.name)
          .doc(notification.uid)
          .update({"status": status.name});
      return true;
    } on FirebaseException catch (e) {
      LoadingHelper.hideLoading();
      Get.snackbar("Message",
          e.message ?? 'Something went wrong! Please try again later');
      return false;
    }
  }

  static Future<bool> deleteStore(String id) async {
    try {
      LoadingHelper.showLoading();
      await FirebaseFirestore.instance
          .collection(Collection.storeData.name)
          .doc(id)
          .delete();
      LoadingHelper.hideLoading();
      return true;
    } on FirebaseException catch (e) {
      LoadingHelper.hideLoading();
      Get.snackbar("Message",
          e.message ?? 'Something went wrong! Please try again later');
      return false;
    }
  }

  static Future<bool> setStoreData(StoreModel store) async {
    try {
      LoadingHelper.showLoading();
      await FirebaseFirestore.instance
          .collection(Collection.storeData.name)
          .doc(store.id)
          .set(store.toMap());
      LoadingHelper.hideLoading();
      return true;
    } on FirebaseException catch (e) {
      LoadingHelper.hideLoading();
      log(e.message.toString());
      return false;
    }
  }

  static Future<bool> createUser(UserModel user) async {
    try {
      LoadingHelper.showLoading();
      await FirebaseFirestore.instance
          .collection(Collection.users.name)
          .doc(user.uid)
          .set(user.toMap());
      LoadingHelper.hideLoading();
      return true;
    } on FirebaseException catch (e) {
      LoadingHelper.hideLoading();
      log(e.message.toString());
      return false;
    }
  }

  static Future<bool> createNotification(
      NotificationsModel notification) async {
    try {
      await FirebaseFirestore.instance
          .collection(Collection.notifications.name)
          .doc(notification.id)
          .set(notification.toMap());
      return true;
    } on FirebaseException catch (e) {
      LoadingHelper.hideLoading();
      Get.snackbar("Message",
          e.message ?? 'Something went wrong! Please try again later');
      return false;
    }
  }

  static Future<bool> restrictUser(String uid, UserStatus status) async {
    try {
      LoadingHelper.showLoading();
      await FirebaseFirestore.instance
          .collection(Collection.users.name)
          .doc(uid)
          .update({"status": status.name});
      LoadingHelper.hideLoading();
      return true;
    } on FirebaseException catch (e) {
      LoadingHelper.hideLoading();
      Get.snackbar("Message",
          e.message ?? 'Something went wrong! Please try again later');
      return false;
    }
  }

  static Future<bool> updateProfile(UserModel user) async {
    try {
      LoadingHelper.showLoading();
      await FirebaseFirestore.instance
          .collection(Collection.users.name)
          .doc(user.uid)
          .set(user.toMap());
      LoadingHelper.hideLoading();
      return true;
    } on FirebaseException catch (e) {
      LoadingHelper.hideLoading();
      Get.snackbar("Message",
          e.message ?? 'Something went wrong! Please try again later');
      return false;
    }
  }

  static Future<bool> updateCommission(String userid, double commision) async {
    try {
      LoadingHelper.showLoading();
      await FirebaseFirestore.instance
          .collection(Collection.users.name)
          .doc(userid)
          .update({"commision": commision});
      LoadingHelper.hideLoading();
      return true;
    } on FirebaseException catch (e) {
      LoadingHelper.hideLoading();
      Get.snackbar("Message",
          e.message ?? 'Something went wrong! Please try again later');
      return false;
    }
  }

  static Future<bool> createWarehouse(WarehouseModel warehouse) async {
    try {
      LoadingHelper.showLoading();

      await FirebaseFirestore.instance
          .collection(Collection.warehouses.name)
          .doc(warehouse.id)
          .set(warehouse.toMap());
      LoadingHelper.hideLoading();
      return true;
    } on FirebaseException catch (e) {
      LoadingHelper.hideLoading();
      Get.snackbar("Message",
          e.message ?? 'Something went wrong! Please try again later');
      return false;
    }
  }

  static Future<bool> incrementComission(double totalCommsion) async {
    try {
      LoadingHelper.showLoading();
      await FirebaseFirestore.instance
          .collection(Collection.users.name)
          .doc(Constant.user!.uid)
          .update({"totalCommision": totalCommsion});
      LoadingHelper.hideLoading();
      return true;
    } on FirebaseException catch (e) {
      LoadingHelper.hideLoading();
      Get.snackbar("Message",
          e.message ?? 'Something went wrong! Please try again later');
      return false;
    }
  }
}
