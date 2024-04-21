import 'dart:convert';

import 'package:equatable/equatable.dart';

class BannerData extends Equatable{
  final int id;
  final String title;
  final String description;
  final String image;
  final String url;
  final DateTime uploadTime;
  static final empty = BannerData(
    description: '',
    id: 0,
    title: '',
    image: '',
    url: '',
    uploadTime: DateTime.now(),
  );
  const BannerData({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.url,
    required this.uploadTime,
  });

  factory BannerData.fromMap(Map<String, dynamic> map) => BannerData(
        id: map['id'] as int,
        title: map['title'] as String,
        description: map['description'] as String,
        image: map['image'] as String,
        url: map['url'] as String,
        uploadTime: DateTime.parse(map['upload_time'] as String),
      );

  factory BannerData.fromJson(String source) =>
      BannerData.fromMap(json.decode(source)[0] as Map<String, dynamic>);
      
        @override
       
        List<Object?> get props => [id, title, description, image, url, uploadTime];
}
