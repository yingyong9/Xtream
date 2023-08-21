// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class CommentModel {
  final String comment;
  final Timestamp timestamp;
  final Map<String, dynamic> mapComment;
  final bool upBool;
  CommentModel({
    required this.comment,
    required this.timestamp,
    required this.mapComment,
    required this.upBool,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'comment': comment,
      'timestamp': timestamp,
      'mapComment': mapComment,
      'upBool': upBool,
    };
  }

  factory CommentModel.fromMap(Map<String, dynamic> map) {
    return CommentModel(
      comment: (map['comment'] ?? '') as String,
      timestamp: (map['timestamp'] ?? Timestamp(0, 0)),
      mapComment: Map<String, dynamic>.from(map['mapComment'] ?? {}),
      upBool: (map['upBool'] ?? false) as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory CommentModel.fromJson(String source) =>
      CommentModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
