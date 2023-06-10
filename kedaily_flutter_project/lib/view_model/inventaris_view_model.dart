import 'package:flutter/material.dart';

class InventarisViewModel with ChangeNotifier {
  String barCode = '';

  void setBarCodeScanner(String code) {
    barCode = code;
    notifyListeners();
  }
}
