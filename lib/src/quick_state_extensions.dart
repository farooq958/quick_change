import 'package:flutter/material.dart';
import 'quick_state_controller.dart';
/// An extension to listen to state of [QuickChangeController].
///
/// This widget is mostly used with [StatefulWidget]s.
///
/// Please check Example:
///
extension QuickStateListenerExtension on Widget {
  Widget quickListen<T>({
    required QuickChangeController<T> controller,
    required void Function(BuildContext context, QuickState state) listener,
  }) {
    return QuickStateListenerWidget(

      controller: controller,
      listener: listener,
      child: this,
    );
  }
}
class QuickStateListenerWidget<T> extends StatefulWidget {
  final Widget child;
  final QuickChangeController<T> controller;
  final void Function(BuildContext context, QuickState state) listener;

  const QuickStateListenerWidget({
    super.key,
    required this.child,
    required this.controller,
    required this.listener,
  });

  @override
  QuickStateListenerWidgetState<T> createState() => QuickStateListenerWidgetState<T>();
}

class QuickStateListenerWidgetState<T> extends State<QuickStateListenerWidget<T>> {
  late VoidCallback _stateListener;

  @override
  void initState() {
    super.initState();

    // Define the listener callback
    _stateListener = () {
      widget.listener(context, widget.controller.state);
    };

    // Add the listener to the controller
    widget.controller.addListener(_stateListener);
  }

  @override
  void dispose() {
    // Remove the listener when the widget is disposed
    widget.controller.removeListener(_stateListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
