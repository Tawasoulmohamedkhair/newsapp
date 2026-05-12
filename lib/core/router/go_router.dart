import 'package:go_router/go_router.dart';
import 'package:newsapp/core/di/service_locator.dart';
import 'package:newsapp/core/state/app_flow_controller.dart';
import 'package:newsapp/features/auth/presentation/screens/login_screen.dart';
import 'package:newsapp/features/auth/presentation/screens/register_screen.dart';
import 'package:newsapp/features/main/main_screen.dart';
import 'package:newsapp/features/onboarding/presentation/screen/onboarding_screen.dart';
import 'package:newsapp/features/splash/splash_screen.dart';


GoRouter createRouter() {
  return GoRouter(
    initialLocation: '/splash',

    
    refreshListenable: getIt<AppFlowController>(),

    routes: [
      GoRoute(path: '/splash', builder: (_, _) => const SplashScreen()),
      GoRoute(
        path: '/onboarding',
        builder: (_, _) => const OnboardingScreen(),
      ),
      GoRoute(path: '/login', builder: (_, _) => LoginScreen()),
      GoRoute(path: '/register', builder: (_, _) => RegisterScreen()),
      GoRoute(path: '/main', builder: (_, _) => const MainScreen()),
    ],

    redirect: (context, state) {
      // ✅ الحل هنا: نستخدم getIt بدل context.read
      final appFlow = getIt<AppFlowController>();
      final status = appFlow.status;
      final onboardingDone = appFlow.onboardingCompleted;
      final location = state.matchedLocation;

      // 1. لسه بنحمل
      if (status == AppStatus.loading) {
        return location == '/splash' ? null : '/splash';
      }

      // 2. مخلصش Onboarding - دا أهم شرط
      if (!onboardingDone) {
        return location == '/onboarding' ? null : '/onboarding';
      }

      // 3. خلص Onboarding بس مش مسجل
      if (status == AppStatus.loggedOut) {
        final isAuthRoute = location == '/login' || location == '/register';
        return isAuthRoute ? null : '/login';
      }

      // 4. مسجل دخول وخلص Onboarding
      if (status == AppStatus.loggedIn) {
        final isInAuthFlow = [
          '/splash',
          '/onboarding',
          '/login',
          '/register',
        ].contains(location);
        return isInAuthFlow ? '/main' : null;
      }

      return null;
    },
  );
}
