import 'package:flutter/material.dart';
import 'package:newsapp/features/profile/presentation/controller/profile_controller.dart';
import 'package:newsapp/features/profile/presentation/widget/menu_item.dart';
import 'package:newsapp/features/profile/presentation/widget/profile_info_bottom_sheet.dart';

class ProfileMenu extends StatelessWidget {
  final ProfileController controller;
  final BuildContext context;

  const ProfileMenu({
    super.key,
    required this.controller,
    required this.context,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          MenuItem(
            icon: Icons.person_outline_rounded,
            title: 'Personal Info',
            onTap: () => _showBottomSheet(context, controller),
          ),
          const Divider(height: 1),
          MenuItem(
            icon: Icons.language_rounded,
            title: 'Language',
            onTap: () {},
          ),
          const Divider(height: 1),
          MenuItem(icon: Icons.flag_outlined, title: 'Country', onTap: () {}),
          const Divider(height: 1),
          MenuItem(
            icon: Icons.description_outlined,
            title: 'Terms & Conditions',
            onTap: () {},
          ),
          const Divider(height: 1),
          MenuItem(
            icon: Icons.logout_rounded,
            title: 'Logout',
            color: Colors.red,
            onTap: () => controller.logout(),
          ),
        ],
      ),
    );
  }
  void _showBottomSheet(BuildContext context, ProfileController controller) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => ProfileInfoBottomSheet(controller: controller),
    );
  }
}
