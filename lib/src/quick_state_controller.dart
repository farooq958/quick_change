import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

abstract class QuickState {}

class QuickLoading extends QuickState {}

class QuickData<T> extends QuickState {
  final T data;
  QuickData(this.data);
}

class QuickError extends QuickState {
  final String message;
  QuickError(this.message);
}

/// Implement <QuickState> in QuickStateController to use it in your widget tree
class QuickStateController<T> extends ChangeNotifier implements ValueListenable<QuickState> {
  QuickState _state = QuickLoading(); // Initial state
  @override
  QuickState get value => _state; // Implement the 'value' getter for ValueListenable

  void setLoading() {
    _state = QuickLoading();
    notifyListeners();
  }

  void setData(T data) {
    _state = QuickData<T>(data);
    notifyListeners();
  }

  void setError(String message) {
    _state = QuickError(message);
    notifyListeners();
  }
}
