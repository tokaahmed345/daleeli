

import 'dart:convert';
import 'package:daleeli/core/utils/constant/endpoints.dart';
import 'package:daleeli/core/utils/networking/api_service.dart';
import 'package:daleeli/core/utils/networking/firebase/firestore/firebase_firestore_service.dart';
import 'package:daleeli/core/utils/networking/firebase/firestore/firestore_fields.dart';
import 'package:daleeli/feature/home/data/models/places_model.dart';

abstract class AiSuggestionTripsRemoteDataSource {
  Future<List<PlacesModel>> suggestPlaces();
}

class AiSuggestionTripsRemoteDataSourceImpl
    implements AiSuggestionTripsRemoteDataSource {
  final ApiService apiService;
  final FirebaseFirestoreService firestore;

  AiSuggestionTripsRemoteDataSourceImpl({
    required this.apiService,
    required this.firestore,
  });
static const String fallbackImage =
      "https://images.unsplash.com/photo-1539650116574-8efeb43e2750?q=80&w=1000&auto=format&fit=crop";

  @override
  Future<List<PlacesModel>> suggestPlaces() async {
    final savedSnapshot = await firestore.getCollection(
      collectionPath: FirestoreFields.plaaces,
      queryBuilder: (collection) =>
          collection.where('isSaved', isEqualTo: true),
    );

    final savedPlaces = savedSnapshot.docs
        .map((doc) => PlacesModel.fromJson(doc.data(), doc.id))
        .toList();

    if (savedPlaces.isEmpty) {
      final unsavedSnapshot = await firestore.getCollection(
        collectionPath: FirestoreFields.plaaces,
        queryBuilder: (collection) =>
            collection.where('isSaved', isEqualTo: false),
      );

      final unsavedPlaces = unsavedSnapshot.docs
          .map((doc) => PlacesModel.fromJson(doc.data(), doc.id))
          .toList();

      if (unsavedPlaces.isEmpty) return [];

      return unsavedPlaces.take(3).toList();
    }

    final savedDetails = savedPlaces
        .map((p) => "- ${p.title} (${p.category}):${p.description}")
        .join('\n');

   final prompt = '''
    You are an expert AI travel assistant. 
    Here are the places that the user has saved and loves:
    $savedDetails
    
    Task: Analyze the user's taste and suggest 3 NEW, real tourist places in Egypt that match their taste, but are NOT in their saved list.
    CRITICAL: Return the response STRICTLY as a valid JSON array of objects. Do NOT use markdown code blocks (like ```json). Do NOT write any extra text.
    Each object must have these exact keys:
    - "title": (String) Name of the place
    - "subtitle": (String) Short catchy subtitle
    - "description": (String) Brief description
    - "category": (String) Category name (e.g., Monuments, Nature, Museums)
    - "location": (String) City or region in Egypt
    - "rating": (String) Rating like "4.8"
    - "entryFee": (String) e.g., "Free" or "50 EGP"
    - "imageUrl": (String) MUST choose the most appropriate direct URL from this list based on the place type:
      - For Pyramids/Deserts: "[https://images.unsplash.com/photo-1539650116574-8efeb43e2750?q=80&w=1000&auto=format&fit=crop](https://images.unsplash.com/photo-1539650116574-8efeb43e2750?q=80&w=1000&auto=format&fit=crop)"
      - For Beaches/Red Sea/Sinai: "[https://images.unsplash.com/photo-1544644181-1484b3fdfc62?q=80&w=1000&auto=format&fit=crop](https://images.unsplash.com/photo-1544644181-1484b3fdfc62?q=80&w=1000&auto=format&fit=crop)"
      - For Old Islamic Cairo/Streets/Mosques: "[https://images.unsplash.com/photo-1572252009286-268acec5ca0a?q=80&w=1000&auto=format&fit=crop](https://images.unsplash.com/photo-1572252009286-268acec5ca0a?q=80&w=1000&auto=format&fit=crop)"
      - For Nile/Nature/Greenery: "[https://images.unsplash.com/photo-1508873696983-2df5c920ac3c?q=80&w=1000&auto=format&fit=crop](https://images.unsplash.com/photo-1508873696983-2df5c920ac3c?q=80&w=1000&auto=format&fit=crop)"
      - For Museums/Castles/Monuments: "[https://images.unsplash.com/photo-1568322445389-f64ac25256e6?q=80&w=1000&auto=format&fit=crop](https://images.unsplash.com/photo-1568322445389-f64ac25256e6?q=80&w=1000&auto=format&fit=crop)"
    ''';

    try {
      final response = await apiService.post(
        EndPoints.generateContent,
        headers: {
          "Content-Type": "application/json",
          "x-goog-api-key": EndPoints.apiKey,
        },
        data: {
          'contents': [
            {
              'parts': [
                {'text': prompt},
              ],
            },
          ],
        },
      );

      final rawText =
          response['candidates'][0]['content']['parts'][0]['text'] as String;

      final cleanedJsonString = rawText
          .replaceAll('```json', '')
          .replaceAll('```', '')
          .trim();

      final List<dynamic> decodedList = jsonDecode(cleanedJsonString);

      return decodedList.map((jsonItem) {
        String imageUrl = jsonItem['imageUrl']?.toString().trim() ?? '';
        if (!imageUrl.startsWith('http')) {
          imageUrl = fallbackImage;
        }

        final Map<String, dynamic> securedJson = Map.from(jsonItem);
        securedJson['imageUrl'] = imageUrl;

        return PlacesModel.fromJson(
          securedJson,
          DateTime.now().millisecondsSinceEpoch.toString(),
        );
      }).toList();
    } catch (e) {
      final fallbackSnapshot = await firestore.getCollection(
        collectionPath: FirestoreFields.plaaces,
      );
      return fallbackSnapshot.docs
          .map((doc) => PlacesModel.fromJson(doc.data(), doc.id))
          .take(3)
          .toList();
    }
  }
}