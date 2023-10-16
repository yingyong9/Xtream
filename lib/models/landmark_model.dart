// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class LandMarkModel {
  final String name;
  final String phone;
  final String type;
  final GeoPoint geoPoint;
  LandMarkModel({
    required this.name,
    required this.phone,
    required this.type,
    required this.geoPoint,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'phone': phone,
      'type': type,
      'geoPoint': geoPoint,
    };
  }

  factory LandMarkModel.fromMap(Map<String, dynamic> map) {
    return LandMarkModel(
      name: (map['name'] ?? '') as String,
      phone: (map['phone'] ?? '') as String,
      type: (map['type'] ?? '') as String,
      geoPoint: (map['geoPoint'] ?? const GeoPoint(0, 0)),
    );
  }

  String toJson() => json.encode(toMap());

  factory LandMarkModel.fromJson(String source) => LandMarkModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
