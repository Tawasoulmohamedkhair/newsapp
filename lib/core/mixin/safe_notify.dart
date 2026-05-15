// import 'package:flutter/foundation.dart';

// mixin SafeNotify on ChangeNotifier {
//   bool isDisposed = false;

//   void safeNotify() {
//     if (!isDisposed) {
//       super.notifyListeners();
//     }
//   }

//   @override
//   void dispose() {
//     isDisposed = true; // Set the flag to true when disposing
//     super.dispose();
//   }
// }
import 'package:flutter/foundation.dart';

mixin SafeNotify on ChangeNotifier {
  bool _isDisposed = false;

  bool get isDisposed => _isDisposed;

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

  /// استخدمي دي بدل notifyListeners() العادية
  void safeNotifyListeners() {
    if (!_isDisposed) {
      notifyListeners();
    }
  }
}
