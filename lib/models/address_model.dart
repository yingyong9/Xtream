import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class AddressModel {
  final String  name;
  final String  phone;
  final String  province;
  final String  amphur;
  final String  district;
  final String  houseNumber;
  final String  remark;
  AddressModel({
    required this.name,
    required this.phone,
    required this.province,
    required this.amphur,
    required this.district,
    required this.houseNumber,
    required this.remark,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'phone': phone,
      'province': province,
      'amphur': amphur,
      'district': district,
      'houseNumber': houseNumber,
      'remark': remark,
    };
  }

  factory AddressModel.fromMap(Map<String, dynamic> map) {
    return AddressModel(
      name: (map['name'] ?? '') as String,
      phone: (map['phone'] ?? '') as String,
      province: (map['province'] ?? '') as String,
      amphur: (map['amphur'] ?? '') as String,
      district: (map['district'] ?? '') as String,
      houseNumber: (map['houseNumber'] ?? '') as String,
      remark: (map['remark'] ?? '') as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AddressModel.fromJson(String source) => AddressModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
