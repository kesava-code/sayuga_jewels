import 'dart:convert';

class ProductFilterDetails {
  final List<Category> categories;
  final List<Occasion> occasions;
  final List<Material> materials;
  final List<Gender> genders;
  final List<Stone> stones;
  final List<Color> colors;

  ProductFilterDetails({
    required this.categories,
    required this.occasions,
    required this.materials,
    required this.genders,
    required this.stones,
    required this.colors,
  });

  factory ProductFilterDetails.fromMap(Map<String, dynamic> map) =>
      ProductFilterDetails(
        categories: List<Category>.from(
          map['categories'].map((e) => Category.fromJson(e)),
        ),
        occasions: List<Occasion>.from(
          map['ocassions'].map((e) => Occasion.fromJson(e)),
        ),
        materials: List<Material>.from(
          map['materials'].map((e) => Material.fromJson(e)),
        ),
        genders: List<Gender>.from(
          map['genders'].map((e) => Gender.fromJson(e)),
        ),
        stones: List<Stone>.from(
          map['stones'].map((e) => Stone.fromJson(e)),
        ),
        colors: List<Color>.from(
          map['colors'].map((e) => Color.fromJson(e)),
        ),
      );

  factory ProductFilterDetails.fromJson(String source) =>
      ProductFilterDetails.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ProductFilterDetails(categories: $categories, occasions: $occasions, materials: $materials, genders: $genders, stones: $stones, colors: $colors)';
  }
}

class Category {
  final String id;
  final String name;
  final List<SubCategory> subCategories;

  Category({
    required this.id,
    required this.name,
    required this.subCategories,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json['id'].toString(),
        name: json['name'],
        subCategories: List<SubCategory>.from(
          json['subCategories']?.map((e) => SubCategory.fromJson(e)) ?? [],
        ),
      );

  @override
  String toString() =>
      'Category(id: $id, name: $name, subCategories: $subCategories)';
}

class SubCategory {
  final String id;
  final String name;

  SubCategory({
    required this.id,
    required this.name,
  });

  factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
        id: json['id'].toString(),
        name: json['name'],
      );

  @override
  String toString() => 'SubCategory(id: $id, name: $name)';
}

class Occasion {
  final String id;
  final String name;

  Occasion({
    required this.id,
    required this.name,
  });

  factory Occasion.fromJson(Map<String, dynamic> json) => Occasion(
        id: json['id'].toString(),
        name: json['name'],
      );

  @override
  String toString() => 'Occasion(id: $id, name: $name)';
}

class Material {
  final String id;
  final String name;

  Material({
    required this.id,
    required this.name,
  });

  factory Material.fromJson(Map<String, dynamic> json) => Material(
        id: json['id'].toString(),
        name: json['name'],
      );

  @override
  String toString() => 'Material(id: $id, name: $name)';
}

class Gender {
  final String id;
  final String name;

  Gender({
    required this.id,
    required this.name,
  });

  factory Gender.fromJson(Map<String, dynamic> json) => Gender(
        id: json['id'].toString(),
        name: json['name'],
      );

  @override
  String toString() => 'Gender(id: $id, name: $name)';
}

class Stone {
  final String id;
  final String name;

  Stone({
    required this.id,
    required this.name,
  });

  factory Stone.fromJson(Map<String, dynamic> json) => Stone(
        id: json['id'].toString(),
        name: json['name'],
      );

  @override
  String toString() => 'Stone(id: $id, name: $name)';
}

class Color {
  final String id;
  final String name;

  Color({
    required this.id,
    required this.name,
  });

  factory Color.fromJson(Map<String, dynamic> json) => Color(
        id: json['id'].toString(),
        name: json['name'],
      );

  @override
  String toString() => 'Color(id: $id, name: $name)';
}
