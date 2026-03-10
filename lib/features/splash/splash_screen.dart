import 'package:flutter/material.dart';
import 'package:newsapp/core/datasource/localData/preferences_manager.dart';
import 'package:newsapp/features/home/screen/home_screen.dart';
import 'package:newsapp/features/auth/login_screen.dart';
import 'package:newsapp/features/onboarding/screen/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  initState() {
    super.initState();
    _navigateToOnboardingScreen();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/main');
    });
  }

  _navigateToOnboardingScreen() async {
    await Future.delayed(const Duration(seconds: 3));
    final bool onboardingComplete =
        PreferencesManager().getBool('onboardingComplete') ?? false;
    final bool is_logged_in =
        PreferencesManager().getBool('isLoggedIn') ?? false;
    if (!mounted) return;

    if (!onboardingComplete) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const OnboardingScreen()),
      );
    } else if (is_logged_in) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Image.asset(
        'assets/images/splash.png',
        width: double.infinity,
        fit: BoxFit.fill,
      ),
    );
  }
}
