import 'package:flutter/foundation.dart';

abstract class QuickState {}

class QuickInitial extends QuickState {}

class QuickLoading<T> extends QuickState {
  final T? previousData;  // Optional data to carry over from previous state
  QuickLoading({this.previousData});
}

class QuickData<T> extends QuickState {
  final T data;
  QuickData(this.data);
}

class QuickError<T> extends QuickState {
  final String message;
  final T? previousData;  // Optional data to carry over from previous state
  QuickError(this.message, {this.previousData});
}

class QuickStateController<T> extends ChangeNotifier implements ValueListenable<QuickState> {
  QuickState _state = QuickInitial();
  QuickState get state => _state;

  @override
  QuickState get value => _state;

  void setInitial() {
    _state = QuickInitial();
    notifyListeners();
  }

  void setLoading() {
    _state = QuickLoading<T>(previousData: (state is QuickData<T>) ? (state as QuickData<T>).data : null);
    notifyListeners();
  }

  void setData(T data) {
    _state = QuickData<T>(data);
    notifyListeners();
  }

  void setError(String message) {
    _state = QuickError<T>(message, previousData: (state is QuickData<T>) ? (state as QuickData<T>).data : null);
    notifyListeners();
  }

  T? getCurrentData() {
    if (_state is QuickData<T>) {
      return (_state as QuickData<T>).data;
    } else if (_state is QuickLoading<T>) {
      return (_state as QuickLoading<T>).previousData;
    } else if (_state is QuickError<T>) {
      return (_state as QuickError<T>).previousData;
    }
    return null;
  }
}
