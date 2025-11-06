
import 'package:flutter/cupertino.dart';

class LogoModel extends ChangeNotifier {
  bool _flipX = false;
  bool get flipX => _flipX;

  bool _flipY = false;
  bool get flipY => _flipY;

  double _size = 100.0;
  double get size => _size;


  set flipX(bool value) {
    _flipX = value;
    notifyListeners();
  }

  set flipY(bool value) {
    _flipY = value;
    notifyListeners();
  }

  set size(double value) {
    _size = value;
    notifyListeners();
  }
}