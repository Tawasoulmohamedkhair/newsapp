import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:newsapp/core/datasource/remoteData/api_service.dart';
import 'package:newsapp/core/datasource/remoteData/news_remote_data_source.dart';
import 'package:newsapp/core/network/dio_logging_interceptor.dart';
import 'package:newsapp/core/router/go_router.dart'; // تأكدي إن هنا فيه الـ routes
import 'package:newsapp/core/router/go_router_refresh.dart';
import 'package:newsapp/core/services/auth_service.dart';
import 'package:newsapp/core/state/app_flow_controller.dart';
import 'package:newsapp/features/auth/data/repository/auth_repositoryimpl.dart';
import 'package:newsapp/features/auth/domain/repository/auth_repository.dart';
import 'package:newsapp/features/auth/domain/usecase/login_usecase.dart';
import 'package:newsapp/features/auth/domain/usecase/register_usecase.dart';
import 'package:newsapp/features/auth/presentation/controller/auth_provider.dart';
import 'package:newsapp/features/home/data/repository/home_repository_impl.dart';
import 'package:newsapp/features/home/domain/repository/home_repository.dart';
import 'package:newsapp/features/home/domain/usecases/get_everything_usecase.dart';
import 'package:newsapp/features/home/domain/usecases/get_top_headlines_usecase.dart';
import 'package:newsapp/features/home/presentation/controller/home_controller.dart';
import 'package:newsapp/features/onboarding/data/datasources/onboarding_local_datasource.dart';
import 'package:newsapp/features/onboarding/data/repositories/onboardingrepository_impl.dart';
import 'package:newsapp/features/onboarding/domain/repositories/onboarding_repository.dart';
import 'package:newsapp/features/onboarding/domain/usecases/complete_onboarding.dart';
import 'package:newsapp/features/onboarding/domain/usecases/getonboarding_data.dart';
import 'package:newsapp/features/onboarding/presentation/controller/onboarding_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

final GetIt getIt = GetIt.instance;

Future<void> setupLocator() async { 
  // ===================== Core / External =====================
  final prefs = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => prefs);

  getIt.registerLazySingleton<Dio>(() {
    final dio = Dio(
      BaseOptions(
        baseUrl: 'https://newsapi.org',
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
      ),
    );
    dio.interceptors.add(DioLoggingInterceptor());
    return dio;
  });

  getIt.registerLazySingleton<ApiService>(() => ApiService(getIt()));

  // ===================== State & Routing =====================
  getIt.registerLazySingleton<AuthService>(() => AuthService());

  getIt.registerLazySingleton<GoRouterRefreshStream>(
    () => GoRouterRefreshStream(),
  );

 getIt.registerLazySingleton<AppFlowController>(() => AppFlowController());

  // ✅ بنسجل الـ Router باستخدام الدالة اللي عملناها في ملف go_router.dart
  // ولا تنسي تعملي import لملف go_router.dart هنا
  getIt.registerLazySingleton<GoRouter>(() => createRouter());
  // ====================== Data Sources ======================
  getIt.registerLazySingleton<NewsRemoteDataSource>(
    () => NewsRemoteDataSourceImpl(getIt<ApiService>()),
  );

  // ===================== ONBOARDING FEATURE =====================
  // Data Sources
  getIt.registerLazySingleton<OnboardingLocalDataSource>(
    () => OnboardingLocalDataSourceImpl(),
  );
  // Repositories
  getIt.registerLazySingleton<OnboardingRepository>(
    () => OnboardingRepositoryImpl(getIt()),
  );
  // Use Cases
  getIt.registerLazySingleton(() => GetOnboardingData(getIt()));
  getIt.registerLazySingleton(() => CompleteOnboarding(getIt()));
  // Controllers
  getIt.registerFactory<OnboardingController>(
    () => OnboardingController(
      appFlowController: getIt(),
      getOnboardingDataUseCase: getIt(),
      goRouter: getIt(),
    ),
  );

  // ===================== AUTH FEATURE =====================
  // Repositories
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(getIt()),
  );
    getIt.registerLazySingleton(() => LoginUseCase(getIt()));
  getIt.registerLazySingleton(() => RegisterUseCase(getIt()));

  // ✅ Controllers / Providers (بعد ما سجلنا الـ Use Cases فوق)
  getIt.registerFactory(
    () => AuthProvider(
      loginUseCase: getIt(), // ← بنحقن الـ Use Case
      registerUseCase: getIt(), // ← بنحقن الـ Use Case
      appFlowController: getIt(),
    ),
  );
  // Controllers / Providers
 

  // ===================== HOME FEATURE =====================
  // Repositories
  getIt.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(getIt()),
  );
  // Use Cases
  getIt.registerLazySingleton(() => GetEverythingUseCase(getIt()));
  getIt.registerLazySingleton(() => GetTopHeadlinesUseCase(getIt()));
  // Controllers
  getIt.registerFactory<HomeController>(
    () => HomeController(
      getEverythingUseCase: getIt(),
      getTopHeadlinesUseCase: getIt(),
    ),
  );
}
