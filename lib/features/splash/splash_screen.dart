// import 'package:flutter/material.dart';
// import 'package:newsapp/core/constant/asset_image.dart';

// class SplashScreen extends StatelessWidget {
  
//   const SplashScreen({super.key});
  

//   @override
//   Widget build(BuildContext context) {
    
//     return Scaffold(
//       body: Image.asset(
//         AssetsImage.splash,
//         width: double.infinity,
//         fit: BoxFit.fill,
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:newsapp/core/datasource/localData/preferences_manager.dart';
import 'package:newsapp/features/auth/presentation/screens/login_screen.dart';
import 'package:newsapp/features/main/main_screen.dart';
import 'package:newsapp/features/onboarding/presentation/screen/onboarding_screen.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateAfterSplash();
  }

  void _navigateAfterSplash() async {
    await Future.delayed(Duration(seconds: 2));

    final bool onboardingComplete =
        PreferencesManager().getBool('onboarding_complete') ?? false;

    final bool isLoggedIn =
        PreferencesManager().getBool('is_logged_in') ?? false;

    if (!mounted) return;
    if (!onboardingComplete) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) {
            return OnboardingScreen();
          },
        ),
      );
    } else if (!isLoggedIn) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) {
            return LoginScreen();
          },
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) {
            return MainScreen();
          },
        ),
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
