import 'dart:convert';
import 'package:flutter/cupertino.dart';

class JewelryDetailsModel {
  final int id;
  final String title;
  final String description;
  final String price;

  final List<String> ocassionList;
  final List<ImageProvider> imageList;
  final String category;
  final String subCategory;
  final List<String> genderList;
  final List<String> materialList;
  final List<String> stoneList;
  final String primaryColor;
  final String secondaryColor;
  const JewelryDetailsModel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.ocassionList,
    required this.imageList,
    required this.category,
    required this.subCategory,
    required this.genderList,
    required this.materialList,
    required this.stoneList,
    required this.primaryColor,
    required this.secondaryColor,
  });

  factory JewelryDetailsModel.fromMap(Map<String, dynamic> map) {
    List<ImageProvider> imageProviderList = [];
    if (map['mainImage'] != null) {
      imageProviderList.add(NetworkImage(map['mainImage']));
    }
    imageProviderList.addAll(
        (map['images'] as List<dynamic>).map((e) => NetworkImage(e)).toList());
    return JewelryDetailsModel(
      id: map['id']?.toInt() ?? 0,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      price: map['price'] ?? '',
      ocassionList: List<String>.from(map['ocassion']),
      imageList: imageProviderList,
      category: map['category'] ?? '',
      subCategory: map['subCategory'] ?? '',
      genderList: List<String>.from(map['gender']),
      materialList: List<String>.from(map['material']),
      stoneList: List<String>.from(map['stone']),
      primaryColor: map['primaryColor'] ?? '',
      secondaryColor: map['secondaryColor'] ?? '',
    );
  }

  factory JewelryDetailsModel.fromJson(String source) =>
      JewelryDetailsModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'JewelryDetailsModel(id: $id, title: $title, description: $description, price: $price, ocassionList: $ocassionList, imageList: ${imageList.toString()}, category: $category, subCategory: $subCategory, genderList: $genderList, materialList: $materialList, stoneList: $stoneList, primaryColor: $primaryColor, secondaryColor: $secondaryColor)';
  }
}
