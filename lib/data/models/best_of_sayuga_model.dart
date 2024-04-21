import 'dart:convert';

import 'package:equatable/equatable.dart';

class JewelryList extends Equatable {
  final List<Jewelry> results;

  const JewelryList({
    required this.results,
  });

  factory JewelryList.fromJson(String source) {
    return JewelryList.fromMap((json.decode(source) as List<dynamic>));
  }

  factory JewelryList.fromMap(List<dynamic> json) => JewelryList(
        results: List<Jewelry>.from(
          json.map((x) => Jewelry.fromJson(x['jewelry']!)),
        ),
      );

  @override
  List<Object> get props => [results];
}

class Jewelry extends Equatable {
  final int id;
  final String mainImage;

  const Jewelry({
    required this.id,
    required this.mainImage,
  });

  factory Jewelry.fromJson(Map<String, dynamic> json) => Jewelry(
        id: json['id'],
        mainImage: json['mainImage'] ?? '',
      );

  @override
  List<Object> get props => [id, mainImage];
}
