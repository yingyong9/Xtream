import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModel {
  final String name;
  final String uid;
  final String urlAvatar;
  final String phone;
  final String? phoneContact;
  final String? linkLine;
  final String? linkMessaging;
  final String? linktiktok;
  final String? email;
  final String? facebook;
  final String? lazada;
  final String? shoppee;
  final String? intagram;
  final String? twitter;
  final List<String>? friends;
  final List<Map<String, dynamic>>? mapAddress;
  final String? token;
  UserModel({
    required this.name,
    required this.uid,
    required this.urlAvatar,
    required this.phone,
    this.phoneContact,
    this.linkLine,
    this.linkMessaging,
    this.linktiktok,
    this.email,
    this.facebook,
    this.lazada,
    this.shoppee,
    this.intagram,
    this.twitter,
    this.friends,
    this.mapAddress,
    this.token,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'uid': uid,
      'urlAvatar': urlAvatar,
      'phone': phone,
      'phoneContact': phoneContact,
      'linkLine': linkLine,
      'linkMessaging': linkMessaging,
      'linktiktok': linktiktok,
      'email': email,
      'facebook': facebook,
      'lazada': lazada,
      'shoppee': shoppee,
      'intagram': intagram,
      'twitter': twitter,
      'friends': friends,
      'mapAddress': mapAddress,
      'token': token,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: (map['name'] ?? '') as String,
      uid: (map['uid'] ?? '') as String,
      urlAvatar: (map['urlAvatar'] ?? '') as String,
      phone: (map['phone'] ?? '') as String,
      phoneContact: map['phoneContact'] ?? '',
      linkLine: map['linkLine'] ?? '',
      linkMessaging: map['linkMessaging'] ?? '',
      linktiktok: map['linktiktok'] ?? '',
      email: map['email'] ?? '',
      facebook: map['facebook'] ?? '',
      lazada: map['lazada'] ?? '',
      shoppee: map['shoppee'] ?? '',
      intagram: map['intagram'] ?? '',
      twitter: map['twitter'] ?? '',
      friends: List<String>.from(map['friends'] ?? []),
      mapAddress: List<Map<String, dynamic>>.from(
        (map['mapAddress'] ?? []),
      ),
      token: (map['token'] ?? '') as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
