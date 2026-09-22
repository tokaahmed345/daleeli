import 'package:daleeli/feature/home/domain/entity/places_entity.dart';

class PlacesModel extends PlacesEntity {
  PlacesModel({
    required super.id,
    required super.title,
    required super.subtitle,
    required super.location,
    required super.description,
    required super.note,
    required super.rating,
    required super.category,
    required super.imageUrl,
    required super.openingHours,
    required super.entryFee,
    super.isSaved,
  });


  factory PlacesModel.fromJson(Map<String, dynamic> json, String docId) {
    return PlacesModel(
      id: docId,
      title: json['title'] ?? '',
      subtitle: json['subtitle'] ?? '',
      location: json['location'] ?? '',
      description: json['description'] ?? '',
      note: json['note'] ?? '',
      rating: double.tryParse(json['rating'].toString()) ?? 0.0,
      category: json['category'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      openingHours: json['openingHours'] ?? 'Not specified',
      entryFee: json['entryFee'] ?? 'Free entry',
      isSaved: json['isSaved'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'subtitle': subtitle,
      'location': location,
      'description': description,
      'note': note,
      'rating': rating,
      'category': category,
      'imageUrl': imageUrl,
      'openingHours': openingHours,
      'entryFee': entryFee,
      'isSaved': true,
    };
  }

  factory PlacesModel.fromEntity(PlacesEntity entity, {bool isSaved = true}) {
    return PlacesModel(
      id: entity.id,
      title: entity.title,
      subtitle: entity.subtitle,
      location: entity.location,
      description: entity.description,
      note: entity.note,
      rating: entity.rating,
      category: entity.category,
      imageUrl: entity.imageUrl,
      openingHours: entity.openingHours,
      entryFee: entity.entryFee,
      isSaved: isSaved,
    );
  }
}