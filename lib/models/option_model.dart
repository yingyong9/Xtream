import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class OptionModel {
  final String title;
  final List<String> subOptions;

  OptionModel({
    required this.title,
    required this.subOptions,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'subOptions': subOptions,
    };
  }

  factory OptionModel.fromMap(Map<String, dynamic> map) {
    return OptionModel(
      title: (map['title'] ?? '') as String,
      subOptions: List<String>.from(map['subOptions'] ?? []),
    );
  }

  String toJson() => json.encode(toMap());

  factory OptionModel.fromJson(String source) =>
      OptionModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
