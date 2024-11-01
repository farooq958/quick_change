// lib/src/quick_state_builder.dart

import 'package:flutter/material.dart';
import 'quick_state_controller.dart';
///

/// Builder for QuickState widget to display loading, data, and error states.
class QuickChangeBuilder<T> extends StatelessWidget {
  final QuickChangeController<T> controller;

  // Callbacks for core states
  final Widget Function(BuildContext context)? onInitial;
  final Widget Function(BuildContext context)? onLoading;
  final Widget Function(BuildContext context, T data)? onData;
  final Widget Function(BuildContext context, String message)? onError;

  // New callback for custom states
  final Widget Function(BuildContext context, QuickState state)? onCustom;

  const QuickChangeBuilder({
    super.key,
    required this.controller,
    this.onInitial,
    this.onLoading,
    this.onData,
    this.onError,
    this.onCustom,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<QuickState>(
      valueListenable: controller,
      builder: (context, state, child) {
        if (state is QuickInitial) {
          return onInitial?.call(context) ?? const SizedBox.shrink();
        } else if (state is QuickLoading) {
          return onLoading?.call(context) ?? const CircularProgressIndicator();
        } else if (state is QuickData<T>) {
          return onData?.call(context, state.data) ?? const SizedBox.shrink();
        } else if (state is QuickError) {
          return onError?.call(context, state.message) ?? Text("Error: ${state.message}");
        } else if (onCustom != null) {
          // Call onCustom for any custom state
          return onCustom!(context, state);
        }
        return const SizedBox.shrink();
      },
    );
  }
}
