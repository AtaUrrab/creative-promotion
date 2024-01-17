import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../../constant/constant.dart';
import '../../../utils/loading_helper.dart';

class FirestoreStorage {
  static Future<String> upload(
      {required String filePath, required String path}) async {
    final String newPath = '$path/${Timestamp.now().millisecondsSinceEpoch}';
    Reference firestore = FirebaseStorage.instance.ref().child(newPath);
    UploadTask uploadTask = firestore.putFile(File(filePath));
    LoadingHelper.showLoading();
    TaskSnapshot snapshot = await uploadTask;
    final imgURL = await snapshot.ref.getDownloadURL();
    LoadingHelper.hideLoading();
    return imgURL;
  }

  static Future<String> uploadStoreImg(String filePath) async {
    final String path =
        'storeData/${Constant.user!.uid}/${Timestamp.now().millisecondsSinceEpoch}';
    Reference firestore = FirebaseStorage.instance.ref().child(path);
    UploadTask uploadTask = firestore.putFile(File(filePath));
    LoadingHelper.showLoading();
    TaskSnapshot snapshot = await uploadTask;
    final imgURL = await snapshot.ref.getDownloadURL();
    LoadingHelper.hideLoading();
    return imgURL;
  }

  static Future<String> uploadProfile(String filePath, String uid) async {
    final String path =
        'profile/$uid/${Timestamp.now().millisecondsSinceEpoch}';
    Reference firestore = FirebaseStorage.instance.ref().child(path);
    UploadTask uploadTask = firestore.putFile(File(filePath));
    LoadingHelper.showLoading();
    TaskSnapshot snapshot = await uploadTask;
    final imgURL = await snapshot.ref.getDownloadURL();
    LoadingHelper.hideLoading();
    return imgURL;
  }
}
