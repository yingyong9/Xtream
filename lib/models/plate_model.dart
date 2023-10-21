import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class PlateModel {
  final String name;
  final String? province;
  PlateModel({
    required this.name,
    this.province,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'province': province,
    };
  }

  factory PlateModel.fromMap(Map<String, dynamic> map) {
    return PlateModel(
      name: (map['name'] ?? '') as String,
      province: (map['province'] ?? '') as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PlateModel.fromJson(String source) =>
      PlateModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
