// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class WarehouseModel {
  final String id;
  final String managerName;
  final String emailAddress;
  final String phoneNo;
  final String name;
  final String address;
  final String number;
  final String size;
  final String state;
  final String status;
  WarehouseModel({
    required this.id,
    required this.managerName,
    required this.emailAddress,
    required this.phoneNo,
    required this.name,
    required this.address,
    required this.number,
    required this.size,
    required this.state,
    required this.status,
  });

  WarehouseModel copyWith({
    String? id,
    String? managerName,
    String? emailAddress,
    String? phoneNo,
    String? name,
    String? address,
    String? number,
    String? size,
    String? state,
    String? status,
  }) {
    return WarehouseModel(
      id: id ?? this.id,
      managerName: managerName ?? this.managerName,
      emailAddress: emailAddress ?? this.emailAddress,
      phoneNo: phoneNo ?? this.phoneNo,
      name: name ?? this.name,
      address: address ?? this.address,
      number: number ?? this.number,
      size: size ?? this.size,
      state: state ?? this.state,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'managerName': managerName,
      'emailAddress': emailAddress,
      'phoneNo': phoneNo,
      'name': name,
      'address': address,
      'number': number,
      'size': size,
      'state': state,
      'status': status,
    };
  }

  factory WarehouseModel.fromMap(Map<String, dynamic> map) {
    return WarehouseModel(
      id: map['id'] as String,
      managerName: map['managerName'] as String,
      emailAddress: map['emailAddress'] as String,
      phoneNo: map['phoneNo'] as String,
      name: map['name'] as String,
      address: map['address'] as String,
      number: map['number'] as String,
      size: map['size'] as String,
      state: map['state'] as String,
      status: map['status'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory WarehouseModel.fromJson(String source) =>
      WarehouseModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'WarehouseModel(id: $id, managerName: $managerName, emailAddress: $emailAddress, phoneNo: $phoneNo, name: $name, address: $address, number: $number, size: $size, state: $state, status: $status)';
  }
}
