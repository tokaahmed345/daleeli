
import 'package:daleeli/feature/ai_honest_review/domain/entity/honest_entity.dart';

class HonestTruthModel extends HonestTruthEntity {
  const HonestTruthModel({
    required super.vibeSummary,
    required super.bulletPoints,
  });

  factory HonestTruthModel.fromAiText(String rawText) {
    String vibe = "No vibe summary available.";
    List<String> bullets = [];

    try {
      final vibeSplitted = rawText.split('[BULLETS]');
      if (vibeSplitted.isNotEmpty) {
        vibe = vibeSplitted[0].replaceAll('[VIBE]', '').trim();
      }

      if (vibeSplitted.length > 1) {
        final bulletsText = vibeSplitted[1];
        final lines = bulletsText.split('\n');
        for (var line in lines) {
          final trimmed = line.trim();
          if (trimmed.startsWith('-') || trimmed.startsWith('•')) {
            bullets.add(trimmed.replaceFirst(RegExp(r'^[-•]\s*'), ''));
          }
        }
      }
    } catch (e) {
      vibe = rawText;
    }

    if (bullets.isEmpty) {
      bullets = [
        "Prices might be higher than expected; bargaining is recommended.",
        "Best to visit during off-peak morning hours for a quieter experience.",
        "Generally worth checking out if you love authentic local culture."
      ];
    }

    return HonestTruthModel(vibeSummary: vibe, bulletPoints: bullets);
  }
}