import 'package:daleeli/core/utils/constant/endpoints.dart';
import 'package:daleeli/core/utils/networking/api_service.dart';
import 'package:daleeli/feature/ai_honest_review/data/models/honest_model.dart';

abstract class HonestTruthRemoteDataSource {
  Future<HonestTruthModel> fetchHonestTruth({
    required String placeName,
    required String placeDescription,
  });
}

class HonestTruthRemoteDataSourceImpl implements HonestTruthRemoteDataSource {
  final ApiService apiService;

  HonestTruthRemoteDataSourceImpl({required this.apiService});

  @override
  Future<HonestTruthModel> fetchHonestTruth({
    required String placeName,
    required String placeDescription,
  }) async {
    final prompt = '''
    Act as a brutally honest local travel critic and expert. 
    Analyze this place:
    - Name: $placeName
    - Description: $placeDescription

    Provide your response strictly in the following format:
    [VIBE]
    Write 2 clear, engaging sentences describing the real vibe, atmosphere, and the hidden catch or secret tip.
    [BULLETS]
    - First bullet point (around 12-15 words) about prices, bargaining, or timing reality.
    - Second bullet point (around 12-15 words) about local tips, crowds, or vendor behavior.
    - Third bullet point (around 12-15 words) about whether it's truly worth visiting or if there's a better alternative.
    ''';

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

    return HonestTruthModel.fromAiText(rawText);
  }
}