// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  final int amount;
  final int priceProduct;
  final String nameProduct;
  final String status;
  final Timestamp timestamp;
  final Map<String, dynamic> mapAddress;
  final Map<String, dynamic> mapBuyer;
  final String urlImageProduct;
  final String refNumber;
  final String? urlDelivery;
  final Timestamp? timestampOrder;
  final Timestamp? timestampDelivery;
  OrderModel({
    required this.amount,
    required this.priceProduct,
    required this.nameProduct,
    required this.status,
    required this.timestamp,
    required this.mapAddress,
    required this.mapBuyer,
    required this.urlImageProduct,
    required this.refNumber,
    this.urlDelivery,
     this.timestampOrder,
     this.timestampDelivery,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'amount': amount,
      'priceProduct': priceProduct,
      'nameProduct': nameProduct,
      'status': status,
      'timestamp': timestamp,
      'mapAddress': mapAddress,
      'mapBuyer': mapBuyer,
      'urlImageProduct': urlImageProduct,
      'refNumber': refNumber,
      'urlDelivery': urlDelivery,
      'timestampOrder': timestampOrder,
      'timestampDelivery': timestampDelivery,
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      amount: (map['amount'] ?? 0) as int,
      priceProduct: (map['priceProduct'] ?? 0) as int,
      nameProduct: (map['nameProduct'] ?? '') as String,
      status: (map['status'] ?? '') as String,
      timestamp: (map['timestamp'] ?? Timestamp(0, 0)),
      mapAddress: Map<String, dynamic>.from(map['mapAddress'] ?? {}),
      mapBuyer: Map<String, dynamic>.from(map['mapBuyer'] ?? {}),
      urlImageProduct: (map['urlImageProduct'] ?? '') as String,
      refNumber: (map['refNumber'] ?? '') as String,
      urlDelivery: (map['urlDelivery'] ?? '') as String,
      timestampOrder: (map['timestampOrder'] ?? Timestamp(0, 0)),
      timestampDelivery: (map['timestampDelivery'] ?? Timestamp(0, 0)),
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderModel.fromJson(String source) =>
      OrderModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
