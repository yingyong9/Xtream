// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ProvinceModel {
  final String id;
  final String code;
  final String name_th;
  final String name_en;
  final String geography_id;
  ProvinceModel({
    required this.id,
    required this.code,
    required this.name_th,
    required this.name_en,
    required this.geography_id,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'code': code,
      'name_th': name_th,
      'name_en': name_en,
      'geography_id': geography_id,
    };
  }

  factory ProvinceModel.fromMap(Map<String, dynamic> map) {
    return ProvinceModel(
      id: (map['id'] ?? '') as String,
      code: (map['code'] ?? '') as String,
      name_th: (map['name_th'] ?? '') as String,
      name_en: (map['name_en'] ?? '') as String,
      geography_id: (map['geography_id'] ?? '') as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProvinceModel.fromJson(String source) => ProvinceModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
