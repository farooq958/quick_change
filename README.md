
# quick_change 🧩

> **A lightweight, intuitive state management solution for Flutter.**  
> Effortlessly manage state transitions with simple, type-safe states and powerful listening and building capabilities.

[![Version](https://img.shields.io/badge/version-1.0.0-blue.svg)](https://pub.dev/packages/quick_state)
[![License](https://img.shields.io/badge/license-MIT-green.svg)](https://opensource.org/licenses/MIT)
[![Flutter](https://img.shields.io/badge/flutter-%2302569B.svg?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev/)

---

`quick_change` is designed to simplify state management in Flutter apps, making it suitable for both small and medium-scale applications, with the flexibility to extend for large apps. This package provides easy-to-use state controllers, built-in state types, and intuitive UI listening and building capabilities.

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

Add `quick_change` to your `pubspec.yaml`:

```yaml
dependencies:
  quick_change: ^1.0.0
```

Then run:

```bash
flutter pub get
```

---

## Quick Start 🚀

1. **Define a `QuickChangeController`** to manage your state.
2. **Use `QuickChangeBuilder`** to listen to state changes and update the UI.
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
import 'package:quick_change/quick_change.dart';

class  CounterController extends QuickChangeController<int> {



  
   incrementCounter(int cVal) {
     print(cVal);
int val = cVal+1;

     setData(val);



   }
   decrementCounter(int cVal) {
     int val = cVal-1;
    

     setData(val);



   }





}
```
```dart
import 'package:flutter/material.dart';
import 'package:quick_change/quick_change.dart';

void main() {
  GetIt.I.registerLazySingleton<CounterController>(() => CounterController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: CounterScreen(),
    );
  }
}

class CounterScreen extends StatefulWidget {
  const CounterScreen({super.key});

  @override
  CounterScreenState createState() => CounterScreenState();
}

class CounterScreenState extends State<CounterScreen> {
  @override
  void initState() {
    super.initState();
  }

  CounterController counterController = GetIt.I<CounterController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quick_State Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            QuickChangeBuilder<int>(
              controller: counterController,
              onLoading: (context) => const CircularProgressIndicator(),
              onData: (context, data) =>
                      Text('Counter: $data', style: const TextStyle(fontSize: 24)),
              onError: (context, message) => Text('Error: $message'),
            ),
            ElevatedButton(
              onPressed: () {
                final currentValue = counterController.currentData ?? 0;
                counterController.incrementCounter(currentValue);
              },
              child: const Text('Increment Counter'),
            ),
            ElevatedButton(
              onPressed: () {
                final currentValue = counterController.currentData ?? 0;
                counterController.decrementCounter(currentValue);
              },
              child: const Text('Decrement Counter'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                        MaterialPageRoute(builder: (context) => PostsScreen()));
              },
              child: const Text('Api Page'),
            ),
            // Text(counterController.currentData.toString()),
          ],
        ).quickListen<int>(
          controller: counterController,
          listener: (context, state) {
            if (state is QuickData) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Counter: ${state.data}'),
                  duration: const Duration(milliseconds: 400),
                ),
              );
            }
            if (state is QuickError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
        ),
      ),
    );
  }
}

```

### Listening for Errors

You can use `.quickListen` to display a Custom message such as `SnackBar` when an error occurs.

```dart


  // Listen for errors
 Widget.quickListen(
      controller: counterController,
      listener: (state) {
        if (state is QuickError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
    );
}
```

---

## Advanced Usage

### Custom State Types

Define custom states by extending `QuickState`.

```dart
class QuickCustomSuccess extends QuickState {
  final String message;
  QuickCustomSuccess(this.message);
}
Just use this in your controller for fluxing or emmiting a custom state 
quickFlux(QuickCustomSuccess("This is custom state "));
```

---

## Contributing 🤝

We welcome contributions! Please read our [Contributing Guide](CONTRIBUTING.md) for more details on how to get involved.

---

## License 📄

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more details.

---

Happy coding! 😊🎉 With `quick_change & Farooq `, managing Flutter state transitions has never been simpler.
