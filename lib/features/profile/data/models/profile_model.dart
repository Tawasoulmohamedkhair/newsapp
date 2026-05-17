// lib/features/profile/data/models/profile_model.dart
import 'package:newsapp/features/profile/domain/entities/profile_entity.dart';

class ProfileModel {
  final String id;
  final String name;
  final String? email;
  final String? phone;
  final String? imagePath;

  const ProfileModel({
    required this.id,
    required this.name,
    this.email,
    this.phone,
    this.imagePath,
  });

  ProfileEntity toEntity() {
    return ProfileEntity(
      id: id,
      name: name,
      email: email,
      phone: phone,
      imagePath: imagePath,
    );
  }
}
