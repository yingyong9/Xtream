// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class ReviewModel {
  final double rating;
  final String review;
  final List<String> urlImageReviews;
  final Timestamp timestamp;
  final Map<String, dynamic> mapUserModel;
  ReviewModel({
    required this.rating,
    required this.review,
    required this.urlImageReviews,
    required this.timestamp,
    required this.mapUserModel,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'rating': rating,
      'review': review,
      'urlImageReviews': urlImageReviews,
      'timestamp': timestamp,
      'mapUserModel': mapUserModel,
    };
  }

  factory ReviewModel.fromMap(Map<String, dynamic> map) {
    return ReviewModel(
      rating: (map['rating'] ?? 0.0) as double,
      review: (map['review'] ?? '') as String,
      urlImageReviews: List<String>.from(map['urlImageReviews'] ?? []),
      timestamp: (map['timestamp'] ?? Timestamp(0, 0)),
      mapUserModel: Map<String, dynamic>.from(map['mapUserModel'] ?? {}),
    );
  }

  String toJson() => json.encode(toMap());

  factory ReviewModel.fromJson(String source) => ReviewModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
