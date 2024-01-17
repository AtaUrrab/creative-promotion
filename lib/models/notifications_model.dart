// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationsModel {
  final String id;
  final String uid;
  final String firstName;
  final String lastName;
  final String email;
  final String imgUrl;
  final String status;
  final Timestamp createdAt;
  final String role;
  NotificationsModel({
    required this.id,
    required this.uid,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.imgUrl,
    required this.status,
    required this.createdAt,
    required this.role,
  });

  NotificationsModel copyWith({
    String? id,
    String? uid,
    String? firstName,
    String? lastName,
    String? email,
    String? imgUrl,
    String? status,
    Timestamp? createdAt,
    String? role,
  }) {
    return NotificationsModel(
      id: id ?? this.id,
      uid: uid ?? this.uid,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      imgUrl: imgUrl ?? this.imgUrl,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      role: role ?? this.role,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'uid': uid});
    result.addAll({'firstName': firstName});
    result.addAll({'lastName': lastName});
    result.addAll({'email': email});
    result.addAll({'imgUrl': imgUrl});
    result.addAll({'status': status});
    result.addAll({'createdAt': createdAt});
    result.addAll({'role': role});

    return result;
  }

  factory NotificationsModel.fromMap(Map<String, dynamic> map) {
    return NotificationsModel(
      id: map['id'] ?? '',
      uid: map['uid'] ?? '',
      firstName: map['firstName'] ?? '',
      lastName: map['lastName'] ?? '',
      email: map['email'] ?? '',
      imgUrl: map['imgUrl'] ?? '',
      status: map['status'] ?? '',
      createdAt: map['createdAt'] ?? Timestamp.now(),
      role: map['role'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory NotificationsModel.fromJson(String source) =>
      NotificationsModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'NotificationsModel(id: $id, uid: $uid, firstName: $firstName, lastName: $lastName, email: $email, imgUrl: $imgUrl, status: $status, createdAt: $createdAt, role: $role)';
  }
}
