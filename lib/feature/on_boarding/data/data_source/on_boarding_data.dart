import 'package:daleeli/core/utils/assets/app_assets.dart';
import 'package:daleeli/feature/on_boarding/data/models/on_boarding_model.dart';

class OnBoardingData {
  static final List<OnBoardingModel> pages = [
    OnBoardingModel(
      image: AppAssets.onBoardingTwo,
      title: 'Discover real places',
      description:
          "Egypt has 5,000 years of wonder. We'll help you find the ones that actually deliver.",
      buttonText: 'Continue',
    ),
    OnBoardingModel(
      image: AppAssets.onBoardingOne,
      title: 'Know the truth before you go',
      description:
          'Every place gets an Honest Truth card — AI-distilled from real visitor reviews. Real strengths. Real warnings.',
      buttonText: 'Continue',
    ),
    OnBoardingModel(
      image: AppAssets.onBoardingThree,
      title: 'Plan with confidence',
      description:
          'Build trips around places you can trust. No brochure copy. No inflated ratings.',
      buttonText: 'Get started',
    ),
  ];
}
