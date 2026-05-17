import 'package:flutter/material.dart';
import 'package:newsapp/core/di/service_locator.dart';
import 'package:newsapp/features/profile/presentation/controller/profile_controller.dart';
import 'package:newsapp/features/profile/presentation/widget/profile_header.dart';
import 'package:newsapp/features/profile/presentation/widget/profile_menu.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => getIt<ProfileController>(), 
      child: const _ProfileScreenContent(),
    );
  }
}

class _ProfileScreenContent extends StatelessWidget {
  const _ProfileScreenContent();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Consumer<ProfileController>(
        builder: (context, controller, child) {
          if (controller.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 32),
                ProfileHeader(controller: controller),
                const SizedBox(height: 40),
                ProfileMenu(controller: controller, context: context,),
              ],
            ),
          );
        },
      ),
    );
  }
}


