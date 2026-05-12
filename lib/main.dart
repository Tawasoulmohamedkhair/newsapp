import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:newsapp/core/config/app_config.dart';
import 'package:newsapp/core/di/service_locator.dart';
import 'package:newsapp/core/state/app_flow_controller.dart';
import 'package:newsapp/core/theme/light_theme.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await ScreenUtil.ensureScreenSize();

  await dotenv.load(fileName: ".env");
  await Supabase.initialize(
    url: AppConfig.supabaseUrl,
    anonKey: AppConfig.supabaseAnonKey,
  );

  await setupLocator(); // ← ← ← هنا التعديل: ضيفي await

  final appState = getIt<AppFlowController>();
  await appState.init();

  runApp(const MyApp()); // كمان ضيفي const هنا

  
}
 class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 832),
      minTextAdapt: true,
      builder: (context, child) {
        return ChangeNotifierProvider.value(
          value: getIt<AppFlowController>(),
          child: MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
                      theme: lightTheme,

            routerConfig:  getIt<GoRouter>(), //
          ),
        );
      },
    );
  }
}