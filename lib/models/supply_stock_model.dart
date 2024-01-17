import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class SupplyModel {
  final String id;
  final String warehouseName;
  final Timestamp createdAt;
  final String createdBy;
  final String agentName;
  final String emailAddress;
  final Timestamp date;
  final String fullySyntyheticOW20;
  final String fullySyntyhetic5W20;
  final String fullySyntyhetic5W30;
  final String highMileageOW20;
  final String highMileage5W20;
  final String highMileage5W30;
  final String advanceOW20;
  final String advance5W20;
  final String advance5W30;
  SupplyModel({
    required this.id,
    required this.warehouseName,
    required this.createdAt,
    required this.createdBy,
    required this.agentName,
    required this.emailAddress,
    required this.date,
    required this.fullySyntyheticOW20,
    required this.fullySyntyhetic5W20,
    required this.fullySyntyhetic5W30,
    required this.highMileageOW20,
    required this.highMileage5W20,
    required this.highMileage5W30,
    required this.advanceOW20,
    required this.advance5W20,
    required this.advance5W30,
  });

  SupplyModel copyWith({
    String? id,
    String? warehouseName,
    Timestamp? createdAt,
    String? createdBy,
    String? agentName,
    String? emailAddress,
    Timestamp? date,
    String? fullySyntyheticOW20,
    String? fullySyntyhetic5W20,
    String? fullySyntyhetic5W30,
    String? highMileageOW20,
    String? highMileage5W20,
    String? highMileage5W30,
    String? advanceOW20,
    String? advance5W20,
    String? advance5W30,
  }) {
    return SupplyModel(
      id: id ?? this.id,
      warehouseName: warehouseName ?? this.warehouseName,
      createdAt: createdAt ?? this.createdAt,
      createdBy: createdBy ?? this.createdBy,
      agentName: agentName ?? this.agentName,
      emailAddress: emailAddress ?? this.emailAddress,
      date: date ?? this.date,
      fullySyntyheticOW20: fullySyntyheticOW20 ?? this.fullySyntyheticOW20,
      fullySyntyhetic5W20: fullySyntyhetic5W20 ?? this.fullySyntyhetic5W20,
      fullySyntyhetic5W30: fullySyntyhetic5W30 ?? this.fullySyntyhetic5W30,
      highMileageOW20: highMileageOW20 ?? this.highMileageOW20,
      highMileage5W20: highMileage5W20 ?? this.highMileage5W20,
      highMileage5W30: highMileage5W30 ?? this.highMileage5W30,
      advanceOW20: advanceOW20 ?? this.advanceOW20,
      advance5W20: advance5W20 ?? this.advance5W20,
      advance5W30: advance5W30 ?? this.advance5W30,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'warehouseName': warehouseName,
      'createdAt': createdAt,
      'createdBy': createdBy,
      'agentName': agentName,
      'emailAddress': emailAddress,
      'date': date,
      'fullySyntyheticOW20': fullySyntyheticOW20,
      'fullySyntyhetic5W20': fullySyntyhetic5W20,
      'fullySyntyhetic5W30': fullySyntyhetic5W30,
      'highMileageOW20': highMileageOW20,
      'highMileage5W20': highMileage5W20,
      'highMileage5W30': highMileage5W30,
      'advanceOW20': advanceOW20,
      'advance5W20': advance5W20,
      'advance5W30': advance5W30,
    };
  }

  factory SupplyModel.fromMap(Map<String, dynamic> map) {
    return SupplyModel(
      id: map['id'] ?? "",
      warehouseName: map['warehouseName'] ?? "",
      createdAt: map['createdAt'] ?? Timestamp.now(),
      createdBy: map['createdBy'] ?? "",
      agentName: map['agentName'] ?? "",
      emailAddress: map['emailAddress'] ?? "",
      date: map['date'] ?? Timestamp.now(),
      fullySyntyheticOW20: map['fullySyntyheticOW20'] ?? "",
      fullySyntyhetic5W20: map['fullySyntyhetic5W20'] ?? "",
      fullySyntyhetic5W30: map['fullySyntyhetic5W30'] ?? "",
      highMileageOW20: map['highMileageOW20'] ?? "",
      highMileage5W20: map['highMileage5W20'] ?? "",
      highMileage5W30: map['highMileage5W30'] ?? "",
      advanceOW20: map['advanceOW20'] ?? "",
      advance5W20: map['advance5W20'] ?? "",
      advance5W30: map['advance5W30'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory SupplyModel.fromJson(String source) =>
      SupplyModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SupplyModel(id: $id, warehouseName: $warehouseName, createdAt: $createdAt, createdBy: $createdBy, agentName: $agentName, emailAddress: $emailAddress, date: $date,fullySyntyheticOW20: $fullySyntyheticOW20, fullySyntyhetic : $fullySyntyhetic5W20, fullySyntyhetic : $fullySyntyhetic5W30, highMileage : $highMileageOW20, highMileage : $highMileage5W20, highMileage : $highMileage5W30, advance : $advanceOW20, advance : $advance5W20, advance : $advance5W30, )';
  }
}
