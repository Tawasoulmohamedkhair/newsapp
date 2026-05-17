import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:newsapp/core/constant/asset_image.dart';
import 'package:newsapp/features/profile/presentation/controller/profile_controller.dart';

class ProfileHeader extends StatelessWidget {
  final ProfileController controller;

  const ProfileHeader({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              CircleAvatar(
                radius: 62,
                backgroundColor: Colors.grey.shade200,
                backgroundImage: controller.userImagePath != null
                    ? NetworkImage(
                        controller.userImagePath!,
                      ) 
                    : const AssetImage(AssetsImage.logo),
              ),
              GestureDetector(
                onTap: () => _showImageSourceDialog(context, controller),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey.shade300, width: 2),
                  ),
                  child: const Icon(
                    Icons.camera_alt,
                    size: 22,
                    color: Colors.black87,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            controller.username,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  void _showImageSourceDialog(
    BuildContext context,
    ProfileController controller,
  ) {
    showDialog(
      context: context,
      builder: (_) => SimpleDialog(
        title: const Text('choose image source'),
        children: [
          SimpleDialogOption(
            onPressed: () {
              Navigator.pop(context);
              controller.pickImage(ImageSource.camera);
            },
            child: const ListTile(
              leading: Icon(Icons.camera_alt),
              title: Text('Camera'),
            ),
          ),
          SimpleDialogOption(
            onPressed: () {
              Navigator.pop(context);
              controller.pickImage(ImageSource.gallery);
            },
            child: const ListTile(
              leading: Icon(Icons.photo_library),
              title: Text('Gallery'),
            ),
          ),
        ],
      ),
    );
  }
}
