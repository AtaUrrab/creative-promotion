import 'package:cloud_firestore/cloud_firestore.dart';

class StoreNotificationModel {
  String? agentName;
  String? notificationId;
  bool? notificationView;
  bool? isDecline;
  String? agentID;
  String? storeName;
  Timestamp? createdAt;
  String? declineReason;

  StoreNotificationModel({
    this.agentName,
    this.notificationId,
    this.notificationView,
    this.isDecline,
    this.agentID,
    this.storeName,
    this.createdAt,
    this.declineReason,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'agentName': agentName,
      "notificationId": notificationId,
      "notificationView": notificationView,
      "isDecline": isDecline,
      "agentID": agentID,
      "storeName": storeName,
      "createdAt": createdAt,
      "declineReason": declineReason,
    };
  }

  factory StoreNotificationModel.fromMap(Map<String, dynamic> map) {
    return StoreNotificationModel(
      agentName: map['agentName'] ?? "",
      notificationId: map['notificationId'] ?? "",
      notificationView: map['notificationView'] ?? "",
      isDecline: map['isDecline'] ?? "",
      agentID: map['agentID'] ?? "",
      storeName: map['storeName'] ?? "",
      createdAt: map['createdAt'] ?? Timestamp.now(),
      declineReason: map['declineReason'] ?? "",
    );
  }
}
