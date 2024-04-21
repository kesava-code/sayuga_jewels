
import 'package:equatable/equatable.dart';

class JewelryCategory extends Equatable {
  final int id;
  final String name;
  final String image;

  const JewelryCategory({
    required this.id,
    required this.name,
    required this.image,
  });
  factory JewelryCategory.fromMap(Map<String, dynamic> json) => JewelryCategory(
        id: json['id'],
        name: json['name'],
        image: json['image'],
      );

  @override
  List<Object?> get props => [id, name, image];
}
