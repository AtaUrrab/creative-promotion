import 'package:get/get.dart';

import '../../../../core/constant/enums.dart';
import '../../../../core/services/firebase/email/email_service.dart';
import '../../../../core/services/firebase/firestore_service.dart';
import '../agents/controller/agent_controller.dart';
import 'notifications_screen.dart';

class NotificationController extends GetxController {
  String notificationSelectedTab = "";
  void accept(UserData userdata) => _accept(userdata);
  void reject(UserData userdata) => _reject(userdata);

  @override
  onInit() {
    super.onInit();
    notificationSelectedTab = Get.arguments["tabName"] ?? "pending";
  }

  List<Status> status = [
    Status("pending", 0),
    Status("approved", 1),
    Status("decline", 2),
  ];

  void _accept(UserData userdata) async {
    final controller = Get.put(AgentController());

    if (userdata.notification.role == "agent") {
      bool isComission = await controller.changeComission(
          userdata.context, userdata.notification.uid, 0.0);
      if (isComission == false) {
        return;
      }
    }
    FirestoreService.updateStatus(userdata.notification, UserStatus.approved);
    if (userdata.status == UserStatus.pending.name) {
      EmailService(
        email: userdata.notification.email,
        name:
            "${userdata.notification.firstName} ${userdata.notification.lastName}",
        role: userdata.notification.role,
      ).acceptReq();
      return;
    }
    EmailService(
      email: userdata.notification.email,
      name:
          "${userdata.notification.firstName} ${userdata.notification.lastName}",
      role: userdata.notification.role,
    ).acceptReq();
  }

  void _reject(UserData userdata) {
    FirestoreService.updateStatus(userdata.notification, UserStatus.decline);
    if (userdata.status == UserStatus.pending.name) {
      EmailService(
        email: userdata.notification.email,
        name:
            "${userdata.notification.firstName} ${userdata.notification.lastName}",
        role: userdata.notification.role,
      ).rejectReq();
      return;
    }
    EmailService(
      email: userdata.notification.email,
      name:
          "${userdata.notification.firstName} ${userdata.notification.lastName}",
      role: userdata.notification.role,
    ).block();
  }
}

class Status {
  final String status;
  final int index;

  Status(this.status, this.index);
}
