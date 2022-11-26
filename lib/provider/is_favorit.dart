import 'package:flutter/material.dart';

class Favorite with ChangeNotifier {
  bool _isFavorit = false;

  bool get isFavorit => _isFavorit;

  void toggleNotification() {
    this._isFavorit = !_isFavorit;
    notifyListeners();
  }
}
