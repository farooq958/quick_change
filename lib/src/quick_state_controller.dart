import 'package:flutter/foundation.dart';

abstract class QuickState {}

class QuickInitial extends QuickState {}
///loading class
class QuickLoading<T> extends QuickState {
  final T? previousData;
  QuickLoading({this.previousData});
}
///success class
class QuickData<T> extends QuickState {
  final T data;
  QuickData(this.data);
}

class QuickError<T> extends QuickState {
  final String message;
  final T? previousData;
  QuickError(this.message, {this.previousData});
}

class QuickChangeController<T> extends ChangeNotifier implements ValueListenable<QuickState> {
  QuickState _state = QuickInitial();
  QuickState get state => _state;

  T? _currentData; // Holds the most recent data
  T? get currentData => _currentData; // Public getter for currentData

  @override
  QuickState get value => _state;
///
/// Adds the state and notify listeners
  void quickFlux(QuickState newState) {
    // Update _currentData if the new state contains data
    if (newState is QuickData<T>) {
      _currentData = newState.data;
    }
    _state = newState;
    notifyListeners();
  }

  void setInitial() {
    quickFlux(QuickInitial());
  }

  void setLoading() {
    quickFlux(QuickLoading<T>(previousData: _currentData));
  }
///sets data and notify listeners [success state]
  int? _lastHashCode; // Store the last hash code if equality check isn't reliable

  void setData(T data) {
    // Check if the new data is equal to the current data
    if (_currentData.hashCode != data.hashCode) {
      // If equality check fails, fall back to hash code comparison
      if (data.hashCode != _lastHashCode) {
        _lastHashCode = data.hashCode; // Update the hash code for the new data
        _currentData = data; // Update current data
        quickFlux(QuickData<T>(data)); // Notify listeners of the new state
      }
    }
  }

  void setError(String message) {
    quickFlux(QuickError<T>(message, previousData: _currentData));
  }

}
