// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:io';

Socket? socket;
var videoList = [
  'test-video-10.MP4',
  'test-video-6.mp4',
  'test-video-9.MP4',
  'test-video-8.MP4',
  'test-video-7.MP4',
  'test-video-1.mp4',
  'test-video-2.mp4',
  'test-video-3.mp4',
  'test-video-4.mp4',
];

String urlVideo = 'https://stream115.otaro.co.th:443/vod/mp4:GitConfig.mp4/playlist.m3u8';

class UserVideo {
  final String url;
  final String image;
  final String? desc;

  UserVideo({
    required this.url,
    required this.image,
    this.desc,
  });

  // static List<UserVideo> fetchVideo() {
  //   List<UserVideo> list = videoList
  //       .map((e) => UserVideo(
  //           image: '', url: 'https://static.ybhospital.net/$e', desc: '$e'))
  //       .toList();
  //   return list;
  // }

  static List<UserVideo> fetchVideo() {
    List<UserVideo> list = videoList
        .map((e) => UserVideo(
            image: '', url: urlVideo, desc: '$e'))
        .toList();
    return list;
  }

  @override
  String toString() {
    return 'image:$image' '\nvideo:$url';
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'url': url,
      'image': image,
      'desc': desc,
    };
  }

  factory UserVideo.fromMap(Map<String, dynamic> map) {
    return UserVideo(
      url: (map['url'] ?? '') as String,
      image: (map['image'] ?? '') as String,
      desc: map['desc'] != null ? map['desc'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserVideo.fromJson(String source) =>
      UserVideo.fromMap(json.decode(source) as Map<String, dynamic>);
}
