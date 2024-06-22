import 'package:flutter/material.dart';

class QiblaProvider extends ChangeNotifier {
  Color _buttonColor = Colors.green;

  Color get buttonColor => _buttonColor;

  void updateButtonColor(double difference) {
    if (difference < 10) {
      _buttonColor = Colors.green;
    } else if (difference < 20) {
      _buttonColor = Colors.yellow;
    } else {
      _buttonColor = Colors.red;
    }
    notifyListeners();
  }
}
