
# quick_state 🧩

> **A lightweight, intuitive state management solution for Flutter.**  
> Effortlessly manage state transitions with simple, type-safe states and powerful listening and building capabilities.

[![Version](https://img.shields.io/badge/version-1.0.0-blue.svg)](https://pub.dev/packages/quick_state)
[![License](https://img.shields.io/badge/license-MIT-green.svg)](https://opensource.org/licenses/MIT)
[![Flutter](https://img.shields.io/badge/flutter-%2302569B.svg?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev/)

---

`quick_state` is designed to simplify state management in Flutter apps, making it suitable for both small and medium-scale applications, with the flexibility to extend for large apps. This package provides easy-to-use state controllers, built-in state types, and intuitive UI listening and building capabilities.

## Features ✨

- **Simple and Lightweight**: Manage state without heavy dependencies.
- **Flexible States**: Use predefined states like `QuickLoading`, `QuickData`, and `QuickError`.
- **Easy Listeners**: React to state changes with a clean, intuitive listener API.
- **Modular Design**: Suitable for modular and scalable Flutter applications.
- **Optimized for Performance**: Only rebuilds widgets when necessary.

---

## Table of Contents 📚

- [Installation](#installation)
- [Quick Start](#quick-start)
- [API Overview](#api-overview)
- [Examples](#examples)
  - [Basic Counter Example](#basic-counter-example)
  - [Listening for Errors](#listening-for-errors)
- [Advanced Usage](#advanced-usage)
  - [Custom State Types](#custom-state-types)
  - [Middleware and Logging](#middleware-and-logging)
- [Contributing](#contributing)
- [License](#license)

---

## Installation

Add `quick_state` to your `pubspec.yaml`:

```yaml
dependencies:
  quick_state: ^1.0.0
```

Then run:

```bash
flutter pub get
```

---

## Quick Start 🚀

1. **Define a `QuickStateController`** to manage your state.
2. **Use `QuickStateBuilder`** to listen to state changes and update the UI.
3. **Use `.quickListen`** to respond to state changes outside of rebuilds.

---

## API Overview

- **`QuickStateController`**: Manages state changes and notifies listeners.
- **States**:
  - **`QuickInitial`**: Represents the initial state.
  - **`QuickLoading`**: Represents a loading state.
  - **`QuickData<T>`**: Holds data of type `T`.
  - **`QuickError`**: Represents an error state with a message.
- **`QuickStateBuilder`**: A widget that builds UI based on the controller’s state.
- **`.quickListen`**: An extension on widgets to listen to state changes without rebuilding.

---

## Examples

### Basic Counter Example

Here’s how to create a simple counter using `quick_state`.

```dart
import 'package:flutter/material.dart';
import 'package:quick_state/quick_state.dart';

class CounterScreen extends StatefulWidget {
  @override
  _CounterScreenState createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  final QuickStateController<int> counterController = QuickStateController<int>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Counter Example")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          QuickStateBuilder<int>(
            controller: counterController,
            onInitial: (context) => Text("Welcome! Tap the button to start."),
            onLoading: (context) => CircularProgressIndicator(),
            onData: (context, data) => Text("Counter: $data", style: TextStyle(fontSize: 24)),
            onError: (context, message) => Text("Error: $message"),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              counterController.setLoading();
              Future.delayed(Duration(seconds: 1), () {
                final currentValue = counterController.getCurrentData() ?? 0;
                counterController.setData(currentValue + 1);
              });
            },
            child: Text("Increment Counter"),
          ),
        ],
      ),
    );
  }
}
```

### Listening for Errors

You can use `.quickListen` to display a `SnackBar` when an error occurs.

```dart
@override
void initState() {
  super.initState();

  // Listen for errors
  WidgetsBinding.instance.addPostFrameCallback((_) {
    counterController.quickListen(
      controller: counterController,
      listener: (state) {
        if (state is QuickError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
    );
  });
}
```

---

## Advanced Usage

### Custom State Types

Define custom states by extending `QuickState`.

```dart
class QuickSuccess extends QuickState {
  final String message;
  QuickSuccess(this.message);
}

counterController.setSuccess(String message) {
  _state = QuickSuccess(message);
  notifyListeners();
}
```

### Middleware and Logging

Add logging to track state changes.

```dart
void quickListenWithLogging<T>({
  required QuickStateController<T> controller,
  required void Function(QuickState state) listener,
}) {
  controller.addListener(() {
    print("State changed to: ${controller.state}");
    listener(controller.state);
  });
}
```

---

## Contributing 🤝

We welcome contributions! Please read our [Contributing Guide](CONTRIBUTING.md) for more details on how to get involved.

---

## License 📄

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more details.

---

Happy coding! 😊🎉 With `quick_state`, managing Flutter state transitions has never been simpler.
