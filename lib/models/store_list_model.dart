import 'package:cloud_firestore/cloud_firestore.dart';

class StoreListModel {
  Timestamp? createdAt;
  String? docId;
  // String? agentID;
  String? agentName;
  Timestamp? assigningDate;
  Timestamp? endDate;
  List<String>? storesList;

  StoreListModel({
    this.createdAt,
    this.docId,
    // this.agentID,
    this.agentName,
    this.storesList,
    this.assigningDate,
    this.endDate,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'createdAt': createdAt,
      'docId': docId,
      // 'agentID': agentID,
      'agentName': agentName,
      'assigningDate': assigningDate,
      'endDate': endDate,
      'storesList': storesList,
    };
  }

  factory StoreListModel.fromMap(Map<String, dynamic> map) {
    return StoreListModel(
      createdAt: map['createdAt'] ?? Timestamp.now(),
      docId: map['docId'] ?? "",
      // agentID: map['agentID'] ?? "",
      agentName: map['agentName'] ?? "",
      assigningDate: map['assigningDate'] ?? Timestamp.now(),
      endDate: map['endDate'] ?? Timestamp.now(),
      storesList: (map['storesList'] as List<dynamic>).cast<String>(),
    );
  }

  @override
  String toString() {
    return 'StoreListModel(createdAt: $createdAt,  docId: $docId, agentName: $agentName, assigningDate: $assigningDate, endDate: $endDate, storesList: $storesList)';
  }
}
