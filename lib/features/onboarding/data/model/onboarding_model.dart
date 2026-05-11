import 'package:newsapp/features/onboarding/domain/entities/onboardingentity.dart';

class OnboardingModel extends OnboardingEntity {
  const OnboardingModel({
    required super.image,
    required super.title,
    required super.description,
  });

  factory OnboardingModel.fromJson(Map<String, dynamic> json) {
    return OnboardingModel(
      image: json['image'],
      title: json['title'],
      description: json['description'],
    );
  }
}

