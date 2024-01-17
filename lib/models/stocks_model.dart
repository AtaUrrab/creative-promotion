import 'package:cloud_firestore/cloud_firestore.dart';

class StockModel {
  final String? id;
  final String? createdBy;
  final Timestamp? createdAt;
  final String? catagory;
  final int? quantity;
  StockModel({
    this.id,
    this.createdBy,
    this.createdAt,
    this.catagory,
    this.quantity,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'createdBy': createdBy,
      'createdAt': createdAt,
      'catagory': catagory,
      'quantity': quantity,
    };
  }

  factory StockModel.fromMap(Map<String, dynamic> map) {
    return StockModel(
      id: map['id'] ?? "",
      createdBy: map['createdBy'] ?? "",
      createdAt: map['createdAt'] ?? Timestamp.now(),
      catagory: map['catagory'] ?? "",
      quantity: map['quantity'] ?? 0,
    );
  }

  @override
  String toString() {
    return 'StocksModel(id: $id, createdBy: $createdBy, createdAt: $createdAt, catagory: $catagory, quantity: $quantity)';
  }
}
