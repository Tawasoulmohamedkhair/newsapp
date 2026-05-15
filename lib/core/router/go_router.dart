import 'package:go_router/go_router.dart';
import 'package:newsapp/core/di/service_locator.dart';
import 'package:newsapp/core/state/app_flow_controller.dart';
import 'package:newsapp/features/auth/presentation/screens/login_screen.dart';
import 'package:newsapp/features/auth/presentation/screens/register_screen.dart';
import 'package:newsapp/features/main/main_screen.dart';
import 'package:newsapp/features/onboarding/presentation/screen/onboarding_screen.dart';
import 'package:newsapp/features/search/presentation/screen/search_screen.dart';
import 'package:newsapp/features/splash/splash_screen.dart';

GoRouter createRouter() {
  return GoRouter(
    initialLocation: '/splash',

    refreshListenable: getIt<AppFlowController>(),

    routes: [
      GoRoute(path: '/splash', builder: (_, _) => const SplashScreen()),
      GoRoute(path: '/onboarding', builder: (_, _) => const OnboardingScreen()),
      GoRoute(path: '/login', builder: (_, _) => LoginScreen()),
      GoRoute(path: '/register', builder: (_, _) => RegisterScreen()),
      GoRoute(path: '/main', builder: (_, _) => const MainScreen()),

    
      GoRoute(path: '/search', builder: (_, _) => const SearchScreen()),
    ],

    redirect: (context, state) {
      final appFlow = getIt<AppFlowController>();
      final status = appFlow.status;
      final onboardingDone = appFlow.onboardingCompleted;
      final location = state.matchedLocation;

      
      if (status == AppStatus.loading) {
        return location == '/splash' ? null : '/splash';
      }

      
      if (!onboardingDone) {
        return location == '/onboarding' ? null : '/onboarding';
      }

    
      if (status == AppStatus.loggedOut) {
        final isAuthRoute = location == '/login' || location == '/register';
        return isAuthRoute ? null : '/login';
      }

      
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
