// lib/src/quick_state_extensions.dart

import 'package:flutter/material.dart';
import 'quick_state_controller.dart';
///Helper extension for listening to QuickState changes
extension QuickStateListenerExtension on Widget {
  Widget quickListen<T>({
    required QuickStateController<T> controller,
    required void Function(BuildContext context, QuickState state) listener,
  }) {
    return ValueListenableBuilder<QuickState>(
      valueListenable: controller,
      builder: (context, state, child) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          listener(context, state);
        });
        return this;
      },
      child: this,
    );
  }
}
