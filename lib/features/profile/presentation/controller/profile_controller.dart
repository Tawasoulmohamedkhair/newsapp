import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:newsapp/core/di/service_locator.dart';
import 'package:newsapp/core/state/app_flow_controller.dart';
import 'package:newsapp/features/profile/domain/usecases/update_profile_usecase.dart';

class ProfileController extends ChangeNotifier {

  String _username = 'User';
  String _phoneNumber = '';
  String? _userImagePath;
  bool _isLoading = true;

  String get username => _username;
  String get phoneNumber => _phoneNumber;
  String? get userImagePath => _userImagePath;
  bool get isLoading => _isLoading;

  final ImagePicker _picker = ImagePicker();

  ProfileController({required UpdateProfileUseCase updateProfileUseCase}) {
    loadData();
  }

  Future<void> loadData() async {
    _isLoading = true;
    notifyListeners();

    try {
      final user = Supabase.instance.client.auth.currentUser;
      final prefs = getIt<SharedPreferences>();

      if (user != null) {
        _username =
            prefs.getString('username') ??
            user.userMetadata?['username'] ??
            user.userMetadata?['name'] ??
            user.email?.split('@')[0] ??
            'User';

        _phoneNumber =
            prefs.getString('user_phone') ??
            user.userMetadata?['phone_number'] ??
            '';
      } else {
        _username = prefs.getString('username') ?? 'Guest User';
        _phoneNumber = prefs.getString('user_phone') ?? '';
      }

      _userImagePath = prefs.getString('user_image');
    } catch (e) {
      debugPrint("Error loading profile data: $e");
      _username = 'User';
      _phoneNumber = '';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> updateUserData({
    required String newName,
    required String newPhone,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      final prefs = getIt<SharedPreferences>();

      await prefs.setString('username', newName);
      await prefs.setString('user_phone', newPhone);

      _username = newName;
      _phoneNumber = newPhone;

      final user = Supabase.instance.client.auth.currentUser;
      if (user != null) {
        await Supabase.instance.client.auth.updateUser(
          UserAttributes(data: {'username': newName, 'phone_number': newPhone}),
        );
      }

      notifyListeners();
      return true;
    } catch (e) {
      debugPrint("Error updating profile: $e");
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> pickImage(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: source,
        imageQuality: 80,
      );

      if (image == null) return;

      final appDir = await getApplicationDocumentsDirectory();
      final newFile = await File(
        image.path,
      ).copy('${appDir.path}/${image.name}');

      final prefs = getIt<SharedPreferences>();
      await prefs.setString('user_image', newFile.path);

      _userImagePath = newFile.path;
      notifyListeners();
    } catch (e) {
      debugPrint("Error picking image: $e");
    }
  }

  Future<void> logout() async {
    try {
      await Supabase.instance.client.auth.signOut();
      final prefs = getIt<SharedPreferences>();
      await prefs.remove("username");
      await prefs.remove("user_phone");
      await prefs.remove("user_image");

      await getIt<AppFlowController>().logout();
    } catch (e) {
      debugPrint("Error during logout: $e");
    }
  }
}
