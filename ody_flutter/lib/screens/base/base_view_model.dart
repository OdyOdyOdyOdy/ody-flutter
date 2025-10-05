import "dart:async";
import "package:flutter/material.dart";

class BaseViewModel extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final _snackBarController = StreamController<String>.broadcast();
  Stream<String> get snackBarStream => _snackBarController.stream;

  void showSnackBar(String message) {
    _snackBarController.add(message);
  }

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

  @override
  Future<void> dispose() async {
    await _snackBarController.close();
    super.dispose();
  }
}
