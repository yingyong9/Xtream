// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class CommentPostModel {
  final String post;
  final Timestamp timestamp;
  final Map<String, dynamic> mapUserModel;
  CommentPostModel({
    required this.post,
    required this.timestamp,
    required this.mapUserModel,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'post': post,
      'timestamp': timestamp,
      'mapUserModel': mapUserModel,
    };
  }

  factory CommentPostModel.fromMap(Map<String, dynamic> map) {
    return CommentPostModel(
      post: (map['post'] ?? '') as String,
      timestamp: (map['timestamp'] ?? Timestamp(0, 0)),
      mapUserModel: Map<String, dynamic>.from(map['mapUserModel'] ?? {}),
    );
  }

  String toJson() => json.encode(toMap());

  factory CommentPostModel.fromJson(String source) => CommentPostModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
