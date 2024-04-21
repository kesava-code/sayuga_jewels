import 'dart:convert';

import 'package:equatable/equatable.dart';

class JewelryList extends Equatable {
  final int count;
  final String? next;
  final String? previous;
  final List<Jewelry> results;

  const JewelryList({
    required this.count,
    this.next,
    this.previous,
    required this.results,
  });

factory JewelryList.fromJson(String source) =>
      JewelryList.fromMap(json.decode(source));
  factory JewelryList.fromMap(Map<String, dynamic> json) => JewelryList(
        count: json['count'],
        next: json['next'] ?? '',
        previous: json['previous'] ?? '',
        results: List<Jewelry>.from(
          json['results'].map((x) => Jewelry.fromJson(x)),
        ),
      );
      
        @override
        
  List<Object> get props => [count, next!, previous!, results];
}

class Jewelry extends Equatable {
  final int id;
  final String title;
  final String price;
  final String mainImage;

  const Jewelry({
    required this.id,
    required this.title,
     required this.price,
    required this.mainImage,
  });

  factory Jewelry.fromJson(Map<String, dynamic> json) => Jewelry(
        id: json['id'],
        title: json['title'],
        price: json['price'],
        mainImage: json['mainImage'] ?? '',
      );

  @override
  List<Object> get props => [id, title, price, mainImage];
}
