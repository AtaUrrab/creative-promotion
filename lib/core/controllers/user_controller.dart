import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../models/user_model.dart';
import '../constant/constant.dart';
import '../services/firebase/firestore_service.dart';

class UserController extends GetxController {
  final _authUser = FirebaseAuth.instance.currentUser;
  UserModel? user;
  @override
  void onInit() {
    user = Constant.user;
    super.onInit();
  }

  updateUserState(UserModel newUser) {
    user = newUser;
    update();
  }

  getUserData() async {
    Constant.user = await FirestoreService.getCurrentUser(_authUser!.uid);
  }
}
