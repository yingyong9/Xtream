// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class RemarkModel {
  final String remark;
  final Timestamp timestamp;
  final Map<String, dynamic> mapRemark;
  RemarkModel({
    required this.remark,
    required this.timestamp,
    required this.mapRemark,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'remark': remark,
      'timestamp': timestamp,
      'mapRemark': mapRemark,
    };
  }

  factory RemarkModel.fromMap(Map<String, dynamic> map) {
    return RemarkModel(
      remark: (map['remark'] ?? '') as String,
      timestamp: (map['timestamp'] ?? Timestamp(0, 0)),
      mapRemark: Map<String, dynamic>.from(map['mapRemark'] ?? {}),
    );
  }

  String toJson() => json.encode(toMap());

  factory RemarkModel.fromJson(String source) => RemarkModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
