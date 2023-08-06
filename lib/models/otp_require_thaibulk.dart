import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class OtpRequireThaibulk {
  final String status;
  final String token;
  final String refno;
  OtpRequireThaibulk({
    required this.status,
    required this.token,
    required this.refno,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'status': status,
      'token': token,
      'refno': refno,
    };
  }

  factory OtpRequireThaibulk.fromMap(Map<String, dynamic> map) {
    return OtpRequireThaibulk(
      status: (map['status'] ?? '') as String,
      token: (map['token'] ?? '') as String,
      refno: (map['refno'] ?? '') as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory OtpRequireThaibulk.fromJson(String source) => OtpRequireThaibulk.fromMap(json.decode(source) as Map<String, dynamic>);
}