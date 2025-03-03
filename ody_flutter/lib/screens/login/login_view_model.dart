import "package:firebase_messaging/firebase_messaging.dart";
import "package:flutter/cupertino.dart";

class LoginViewModel extends ChangeNotifier{
  Future<void> requestPermission() async {
    await FirebaseMessaging.instance.requestPermission();
    notifyListeners();
  }
}
