// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class StoreModel {
  final String id;
  final Timestamp createdAt;
  final List<ImageModel> images;
  final String addById;
  final SignatureModel signature;
  final String storeName;
  final String storeEmail;
  final String storeAddress;
  final String storePhone;
  final double comission;
  final Designation designation;
  final String additionalInfo;
  final String fullySyntyheticOW20;
  final String fullySyntyhetic5W20;
  final String fullySyntyhetic5W30;
  final String highMileageOW20;
  final String highMileage5W20;
  final String highMileage5W30;
  final String advanceOW20;
  final String advance5W20;
  final String advance5W30;

  StoreModel({
    required this.id,
    required this.createdAt,
    required this.images,
    required this.addById,
    required this.signature,
    required this.storeName,
    required this.storeEmail,
    required this.storeAddress,
    required this.storePhone,
    required this.comission,
    required this.designation,
    required this.additionalInfo,
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

  StoreModel copyWith({
    String? id,
    Timestamp? createdAt,
    List<ImageModel>? images,
    String? addById,
    SignatureModel? signature,
    String? storeName,
    String? storeEmail,
    String? storeAddress,
    String? storePhone,
    double? comission,
    Designation? designation,
    String? additionalInfo,
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
    return StoreModel(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      images: images ?? this.images,
      addById: addById ?? this.addById,
      signature: signature ?? this.signature,
      storeName: storeName ?? this.storeName,
      storeEmail: storeEmail ?? this.storeEmail,
      storeAddress: storeAddress ?? this.storeAddress,
      storePhone: storePhone ?? this.storePhone,
      comission: comission ?? this.comission,
      designation: designation ?? this.designation,
      additionalInfo: additionalInfo ?? this.additionalInfo,
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
      'createdAt': createdAt,
      'images': images.map((x) => x.toMap()).toList(),
      'addById': addById,
      'signature': signature.toMap(),
      'storeName': storeName,
      'storeEmail': storeEmail,
      'storeAddress': storeAddress,
      'storePhone': storePhone,
      'comission': comission,
      'designation': designation.toMap(),
      'additionalInfo': additionalInfo,
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

  factory StoreModel.fromMap(Map<String, dynamic> map) {
    List<ImageModel> images = [];
    if (map['images'] != null) {
      for (Map<String, dynamic> image in map['images']) {
        images.add(ImageModel.fromMap(image));
      }
    }

    return StoreModel(
      id: map['id'] as String,
      createdAt: map['createdAt'] ?? Timestamp.now(),
      images: images,
      addById: map['addById'] ?? "",
      signature:
          SignatureModel.fromMap(map['signature'] as Map<String, dynamic>),
      storeName: map['storeName'] ?? "",
      storeEmail: map['storeEmail'] ?? "",
      storeAddress: map['storeAddress'] ?? "",
      storePhone: map['storePhone'] ?? "",
      comission: map['comission'] ?? 0.0,
      designation:
          Designation.fromMap(map['designation'] as Map<String, dynamic>),
      additionalInfo: map['additionalInfo'] ?? "",
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

  factory StoreModel.fromJson(String source) =>
      StoreModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'StoreModel(id: $id, createdAt: $createdAt, images: $images, addById: $addById, signature: $signature, storeName: $storeName, storeEmail: $storeEmail, storeAddress: $storeAddress, storePhone: $storePhone, comission: $comission, designation: $designation, additionalInfo: $additionalInfo, fullySyntyheticOW20: $fullySyntyheticOW20, fullySyntyhetic : $fullySyntyhetic5W20, fullySyntyhetic : $fullySyntyhetic5W30, highMileage : $highMileageOW20, highMileage : $highMileage5W20, highMileage : $highMileage5W30, advance : $advanceOW20, advance : $advance5W20, advance : $advance5W30, )';
  }
}

class SignatureModel {
  final Timestamp createdAt;
  final String imgUrl;
  final String signatureName;
  final String type;
  SignatureModel({
    required this.createdAt,
    required this.imgUrl,
    required this.signatureName,
    required this.type,
  });

  SignatureModel copyWith({
    Timestamp? createdAt,
    String? imgUrl,
    String? signatureName,
    String? type,
  }) {
    return SignatureModel(
      createdAt: createdAt ?? this.createdAt,
      imgUrl: imgUrl ?? this.imgUrl,
      signatureName: signatureName ?? this.signatureName,
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'createdAt': createdAt});
    result.addAll({'imgUrl': imgUrl});
    result.addAll({'signatureName': signatureName});
    result.addAll({'type': type});

    return result;
  }

  factory SignatureModel.fromMap(Map<String, dynamic> map) {
    return SignatureModel(
      createdAt: map['createdAt'] ?? Timestamp.now(),
      imgUrl: map['imgUrl'] ?? '',
      signatureName: map['signatureName'] ?? '',
      type: map['type'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory SignatureModel.fromJson(String source) =>
      SignatureModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SignatureModel(createdAt: $createdAt, imgUrl: $imgUrl, signatureName: $signatureName, type: $type)';
  }
}

class ImageModel {
  final Timestamp createdAt;
  final String imageName;
  final String imgUrl;
  final int order;
  final String type;
  ImageModel({
    required this.createdAt,
    required this.imageName,
    required this.imgUrl,
    required this.order,
    required this.type,
  });

  ImageModel copyWith({
    Timestamp? createdAt,
    String? imageName,
    String? imgUrl,
    int? order,
    String? type,
  }) {
    return ImageModel(
      createdAt: createdAt ?? this.createdAt,
      imageName: imageName ?? this.imageName,
      imgUrl: imgUrl ?? this.imgUrl,
      order: order ?? this.order,
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'createdAt': createdAt});
    result.addAll({'imageName': imageName});
    result.addAll({'imgUrl': imgUrl});
    result.addAll({'order': order});
    result.addAll({'type': type});

    return result;
  }

  factory ImageModel.fromMap(Map<String, dynamic> map) {
    return ImageModel(
      createdAt: map['createdAt'] ?? Timestamp.now(),
      imageName: map['imageName'] ?? '',
      imgUrl: map['imgUrl'] ?? '',
      order: map['order']?.toInt() ?? 0,
      type: map['type'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ImageModel.fromJson(String source) =>
      ImageModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ImageModel(createdAt: $createdAt, imageName: $imageName, imgUrl: $imgUrl, order: $order, type: $type)';
  }
}

class Designation {
  final String designation;
  final String name;
  final String email;
  Designation({
    required this.designation,
    required this.name,
    required this.email,
  });

  Designation copyWith({
    String? designation,
    String? name,
    String? email,
  }) {
    return Designation(
      designation: designation ?? this.designation,
      name: name ?? this.name,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'designation': designation,
      'name': name,
      'email': email,
    };
  }

  factory Designation.fromMap(Map<String, dynamic> map) {
    return Designation(
      designation: map['designation'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Designation.fromJson(String source) =>
      Designation.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'Designation(designation: $designation, name: $name, email: $email)';
}
