import 'package:flutter/foundation.dart';

mixin SafeNotify on ChangeNotifier {
  bool isDisposed = false;

  void safeNotify() {
    if (!isDisposed) {
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    isDisposed = true; // Set the flag to true when disposing
    super.dispose();
  }
}
