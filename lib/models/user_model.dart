// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String notificationID;
  final String firstName;
  final String lastName;
  final String imgUrl;
  final Timestamp createdAt;
  final String email;
  final String role;
  final String status;
  final String phone;
  final String area;
  final String snnNo;
  final double commision;
  final double totalCommision;
  final WarehouseDetails? manager;
  final Timestamp restrictedToDate;
  UserModel({
    required this.uid,
    required this.notificationID,
    required this.firstName,
    required this.lastName,
    required this.imgUrl,
    required this.createdAt,
    required this.email,
    required this.role,
    required this.status,
    required this.phone,
    required this.area,
    required this.snnNo,
    required this.commision,
    this.totalCommision = 0,
    this.manager,
    required this.restrictedToDate,
  });

  UserModel copyWith({
    String? uid,
    String? notificationID,
    String? firstName,
    String? lastName,
    String? imgUrl,
    Timestamp? createdAt,
    String? email,
    String? role,
    String? status,
    String? phone,
    String? area,
    String? snnNo,
    double? commision,
    double? totalCommision,
    WarehouseDetails? manager,
    Timestamp? restrictedToDate,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      notificationID: notificationID ?? this.notificationID,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      imgUrl: imgUrl ?? this.imgUrl,
      createdAt: createdAt ?? this.createdAt,
      email: email ?? this.email,
      role: role ?? this.role,
      status: status ?? this.status,
      phone: phone ?? this.phone,
      area: area ?? this.area,
      snnNo: snnNo ?? this.snnNo,
      commision: commision ?? this.commision,
      totalCommision: totalCommision ?? this.totalCommision,
      manager: manager ?? this.manager,
      restrictedToDate: restrictedToDate ?? this.restrictedToDate,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'notificationID': notificationID,
      'firstName': firstName,
      'lastName': lastName,
      'imgUrl': imgUrl,
      'createdAt': createdAt,
      'email': email,
      'role': role,
      'status': status,
      'phone': phone,
      'area': area,
      'snnNo': snnNo,
      'commision': commision,
      'totalCommision': totalCommision,
      'manager': manager?.toMap(),
      'restrictedToDate': restrictedToDate,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? "",
      notificationID: map['notificationID'] ?? "",
      firstName: map['firstName'] ?? "",
      lastName: map['lastName'] ?? "",
      imgUrl: map['imgUrl'] ?? "",
      createdAt: map['createdAt'] ?? Timestamp.now(),
      email: map['email'] ?? "",
      role: map['role'] ?? "",
      status: map['status'] ?? "",
      phone: map['phone'] ?? "",
      area: map['area'] ?? "",
      snnNo: map['snnNo'] ?? "",
      commision: map['commision'] ?? 0.0,
      totalCommision: map['totalCommision'] ?? 0.0,
      manager: map['manager'] != null
          ? WarehouseDetails.fromMap(map['manager'] as Map<String, dynamic>)
          : null,
      restrictedToDate:
          map['restrictedToDate'] ?? Timestamp.fromDate(DateTime(2022)),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(restrictedToDate: $restrictedToDate,uid: $uid, notificationID: $notificationID,  firstName: $firstName, lastName: $lastName, imgUrl: $imgUrl, createdAt: $createdAt, email: $email, role: $role, status: $status, phone: $phone, area: $area, snnNo: $snnNo, commision: $commision, totalCommision: $totalCommision, manager: $manager)';
  }
}

class WarehouseDetails {
  final String name;
  final String address;
  final String number;
  final int size;
  final String state;
  final String storeImgUrl;
  WarehouseDetails({
    required this.name,
    required this.address,
    required this.number,
    required this.size,
    required this.state,
    required this.storeImgUrl,
  });

  WarehouseDetails copyWith({
    String? name,
    String? address,
    String? number,
    int? size,
    String? state,
    String? storeImgUrl,
  }) {
    return WarehouseDetails(
      name: name ?? this.name,
      address: address ?? this.address,
      number: number ?? this.number,
      size: size ?? this.size,
      state: state ?? this.state,
      storeImgUrl: storeImgUrl ?? this.storeImgUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'address': address,
      'number': number,
      'size': size,
      'state': state,
      'storeImgUrl': storeImgUrl,
    };
  }

  factory WarehouseDetails.fromMap(Map<String, dynamic> map) {
    return WarehouseDetails(
      name: map['name'] as String,
      address: map['address'] as String,
      number: map['number'] as String,
      size: map['size'] as int,
      state: map['state'] as String,
      storeImgUrl: map['storeImgUrl'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory WarehouseDetails.fromJson(String source) =>
      WarehouseDetails.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'WarehouseDetails(name: $name, address: $address, number: $number, size: $size, state: $state, storeImgUrl: $storeImgUrl)';
  }
}
