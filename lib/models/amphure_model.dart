// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class AmphureModel {
  final String id;
  final String code;
  final String name_th;
  final String name_en;
  final String province_id;
  AmphureModel({
    required this.id,
    required this.code,
    required this.name_th,
    required this.name_en,
    required this.province_id,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'code': code,
      'name_th': name_th,
      'name_en': name_en,
      'province_id': province_id,
    };
  }

  factory AmphureModel.fromMap(Map<String, dynamic> map) {
    return AmphureModel(
      id: (map['id'] ?? '') as String,
      code: (map['code'] ?? '') as String,
      name_th: (map['name_th'] ?? '') as String,
      name_en: (map['name_en'] ?? '') as String,
      province_id: (map['province_id'] ?? '') as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AmphureModel.fromJson(String source) => AmphureModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
