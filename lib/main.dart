import 'package:flutter/material.dart';
import 'package:newsapp/core/datasource/localData/preferences_manager.dart';
import 'package:newsapp/features/splash/splash_screen.dart';
//import 'package:newsapp/features/onboarding/screen/onboarding_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PreferencesManager().init();
  PreferencesManager().clear();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: const SplashScreen(),
      //  home: OnboardingScreen(),
      //home: MainScreen(),
    );
  }
}
