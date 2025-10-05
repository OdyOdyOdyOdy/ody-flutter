import "package:flutter/material.dart";

class BaseViewModel extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<T> load<T>(Future<T> Function() future) async {
    _setLoading(true);
    try {
      return await future();
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }
}
