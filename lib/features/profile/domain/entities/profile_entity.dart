import 'package:equatable/equatable.dart';

class ProfileEntity extends Equatable {
  final String id;
  final String name;
  final String? email;
  final String? phone;
  final String? imagePath;
  final String? bio;

  const ProfileEntity({
    required this.id,
    required this.name,
    this.email,
    this.phone,
    this.imagePath,
    this.bio,
  });

  ProfileEntity copyWith({
    String? name,
    String? phone,
    String? imagePath,
    String? bio,
  }) {
    return ProfileEntity(
      id: id,
      name: name ?? this.name,
      email: email,
      phone: phone ?? this.phone,
      imagePath: imagePath ?? this.imagePath,
      bio: bio ?? this.bio,
    );
  }

  @override
  List<Object?> get props => [id, name, email, phone, imagePath, bio];
}
