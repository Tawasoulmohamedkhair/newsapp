// // // import 'package:flutter/material.dart';
// // // import 'package:newsapp/core/datasource/localData/preferences_manager.dart';

// // // enum AppStatus { loading, onboarding, loggedOut, loggedIn }

// // // class AppFlowController extends ChangeNotifier {
// // //   AppStatus _status = AppStatus.loading;
// // // bool onboardingCompleted = false;
// // //   AppStatus get status => _status;
// // //   Future<void> init() async {
// // //     final prefs = PreferencesManager();
// // //     final onboardingDone = await prefs.getBool('onboardingComplete') ?? false;

// // //     if (!onboardingDone) {
// // //       _status = AppStatus.onboarding;
// // //     } else {
// // //      _status = AppStatus.loggedOut;
// // //     }

// // //     notifyListeners();
// // //   }
  

// // //   void setLoggedIn(bool value) {
// // //     PreferencesManager().setBool('isLoggedIn', value);

// // //     _status = value ? AppStatus.loggedIn : AppStatus.loggedOut;

// // //     notifyListeners();
// // //   }
// // // }

// // import 'package:flutter/material.dart';
// // import 'package:newsapp/core/datasource/localData/preferences_manager.dart';
// // import 'package:supabase_flutter/supabase_flutter.dart'; // ✅ إضافة Supabase

// // enum AppStatus { loading, onboarding, loggedOut, loggedIn }

// // class AppFlowController extends ChangeNotifier {
// //   AppStatus _status = AppStatus.loading;
// //   bool _onboardingCompleted = false; // ✅ أصبح خاص (Private)

// //   // Getters
// //   AppStatus get status => _status;
// //   bool get onboardingCompleted => _onboardingCompleted; // ✅ Getter للقراءة فقط

// //   Future<void> init() async {
// //     final prefs = PreferencesManager();

// //     // 1. التحقق من الـ Onboarding
// //     _onboardingCompleted = await prefs.getBool('onboardingComplete') ?? false;

// //     if (!_onboardingCompleted) {
// //       _status = AppStatus.onboarding;
// //     } else {
// //       // 2. ✅ التحقق من Supabase (هل يوجد جلسة صالحة؟)
// //       final session = Supabase.instance.client.auth.currentSession;

// //       if (session != null) {
// //         _status = AppStatus.loggedIn; // نعم، المستخدم مسجل الدخول مسبقاً
// //       } else {
// //         _status = AppStatus.loggedOut; // لا، يجب أن يسجل دخول
// //       }
// //     }

// //     notifyListeners();

// //     // 3. ✅ الاستماع لتغيرات المصادقة في الخلفية (مهم جداً لـ GoRouter)
// //     Supabase.instance.client.auth.onAuthStateChange.listen((data) {
// //       if (data.event == AuthChangeEvent.signedIn) {
// //         _status = AppStatus.loggedIn;
// //       } else if (data.event == AuthChangeEvent.signedOut) {
// //         _status = AppStatus.loggedOut;
// //       }
// //       notifyListeners(); // سيخبر الـ GoRouter بالتغيير فوراً
// //     });
// //   }

// //   // ✅ دالة لتغيير حالة الـ Onboarding (ستستدعيها من زر Get Started)
// //   Future<void> completeOnboarding() async {
// //     final prefs = PreferencesManager();
// //     await prefs.setBool('onboardingComplete', true);
// //     _onboardingCompleted = true;
// //     _status = AppStatus.loggedOut; // الانتقال لوضع عدم تسجيل الدخول
// //     notifyListeners();
// //   }

// //   // يمكنك الاستغناء عن هذه الدالة لأن الـ listener في الأعلى يعمل تلقائياً
// //   // ولكن إذا أردت إبقاؤها كـ Fallback لا بأس
// //   void setLoggedIn(bool value) {
// //     PreferencesManager().setBool('isLoggedIn', value);
// //     _status = value ? AppStatus.loggedIn : AppStatus.loggedOut;
// //     notifyListeners();
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:newsapp/core/datasource/localData/preferences_manager.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';

// enum AppStatus { loading, onboarding, loggedOut, loggedIn }

// class AppFlowController extends ChangeNotifier {
//   AppStatus _status = AppStatus.loading;
//   bool _onboardingCompleted = false;

//   AppStatus get status => _status;
//   bool get onboardingCompleted => _onboardingCompleted;

//   Future<void> init() async {
//     final prefs = PreferencesManager();

//     // 1. شيك على Onboarding الأول
//     _onboardingCompleted = prefs.getBool('onboardingComplete') ?? false;

//     if (!_onboardingCompleted) {
//       _status = AppStatus.onboarding;
//       notifyListeners();
//       return; // مهم: متكملش لو لسه مخلصش onboarding
//     }

//     // 2. لو خلص onboarding شيك على Session
//     final session = Supabase.instance.client.auth.currentSession;
//     _status = session != null ? AppStatus.loggedIn : AppStatus.loggedOut;
//     notifyListeners();

//     // 3. اسمع للتغييرات بعد كدا
//     Supabase.instance.client.auth.onAuthStateChange.listen((data) {
//       final newStatus = data.session != null
//           ? AppStatus.loggedIn
//           : AppStatus.loggedOut;

//       if (_status != newStatus) {
//         _status = newStatus;
//         notifyListeners(); // دا هيخلي GoRouter يعمل redirect تلقائي
//       }
//     });
//   }
//     // Add this method to AppFlowController
//   void markAsLoggedIn() {
//     if (_status != AppStatus.loggedIn) {
//       _status = AppStatus.loggedIn;
//       notifyListeners(); // This instantly triggers GoRouter's redirect!
//     }
//   }

//   Future<void> completeOnboarding() async {
//     await PreferencesManager().setBool('onboardingComplete', true);
//     _onboardingCompleted = true;

//     // بعد ما يخلص، شوف هو مسجل ولا لأ
//     final session = Supabase.instance.client.auth.currentSession;
//     _status = session != null ? AppStatus.loggedIn : AppStatus.loggedOut;
//     notifyListeners(); // GoRouter هيوديه للمكان الصح تلقائي
//   }

//   Future<void> logout() async {
//     await Supabase.instance.client.auth.signOut();
//     // الـ listener فوق هيغير الـ status تلقائي
//   }
// }

import 'package:flutter/material.dart';
import 'package:newsapp/core/datasource/localData/preferences_manager.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

enum AppStatus { loading, onboarding, loggedOut, loggedIn }

class AppFlowController extends ChangeNotifier {
  AppStatus _status = AppStatus.loading; // الحالة الافتراضية
  bool _onboardingCompleted = false;

  AppStatus get status => _status;
  bool get onboardingCompleted => _onboardingCompleted;

  // ✅ 1. دالة Init تقرأ البيانات بصمت فقط (بدون notifyListeners)
  Future<void> init() async {
    final prefs = PreferencesManager();

    // نقرأ قيمة الـ Onboarding ولا نغير الحالة
    _onboardingCompleted = prefs.getBool('onboardingComplete') ?? false;

    // لا نضع أي notifyListeners هنا حتى لا نقزز الـ GoRouter

    // نبدأ الاستماع لتغييرات الـ Auth (لكن نتجاهلها لو كنا لا زلنا في Splash)
    Supabase.instance.client.auth.onAuthStateChange.listen((data) {
      // ✅ مهم جداً: إذا كان التطبيق لا يزال في حالة التحميل (الـ Splash)
      // لا تفعل شيئاً، انتظر حتى ينتهي الـ Splash.
      if (_status == AppStatus.loading) return;

      final newStatus = data.session != null
          ? AppStatus.loggedIn
          : AppStatus.loggedOut;

      if (_status != newStatus) {
        _status = newStatus;
        notifyListeners(); // هنا يسمح للتوجيه بالعمل
      }
    });
  }

  // ✅ 2. دالة جديدة: سيتم استدعاؤها من الـ SplashScreen فقط بعد انتهاء الوقت
  Future<void> finishSplash() async {
    if (!_onboardingCompleted) {
      _status = AppStatus.onboarding;
    } else {
      final session = Supabase.instance.client.auth.currentSession;
      _status = session != null ? AppStatus.loggedIn : AppStatus.loggedOut;
    }

    // الآن نبلغ الـ GoRouter بأن الـ Splash انتهى وأن عليه التوجيه
    notifyListeners();
  }

  Future<void> completeOnboarding() async {
    await PreferencesManager().setBool('onboardingComplete', true);
    _onboardingCompleted = true;

    final session = Supabase.instance.client.auth.currentSession;
    _status = session != null ? AppStatus.loggedIn : AppStatus.loggedOut;
    notifyListeners();
  }

  Future<void> logout() async {
    await Supabase.instance.client.auth.signOut();
  }

  // ✅ دالة تسجيل الدخول التي استخدمناها سابقاً
  void markAsLoggedIn() {
    if (_status != AppStatus.loggedIn) {
      _status = AppStatus.loggedIn;
      notifyListeners();
    }
  }
}
