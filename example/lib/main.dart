import 'package:flutter/material.dart';
import 'package:quick_state/quick_state.dart';

void main() {
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
  final QuickStateController<int> counterController = QuickStateController<int>();


  @override
  void initState() {
  super.initState();
  }
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
            QuickStateBuilder<int>(
              controller: counterController,
              onLoading: (context) => const CircularProgressIndicator(),
              onData: (context, data) => Text('Counter: $data', style: const TextStyle(fontSize: 24)),
              onError: (context, message) => Text('Error: $message'),
            ),
            ElevatedButton(
              onPressed: () {
                final currentValue = counterController.getCurrentData() ?? 0;
                counterController.setData(currentValue + 1);
               ///test with loading
                //counterController.setLoading();
               //  Future.delayed(const Duration(seconds: 1), () {
               //    final currentValue = counterController.getCurrentData() ?? 0;
               //    counterController.setData(currentValue + 1);
               //  });
              },
              child: const Text('Increment Counter'),
            ),
          ],
        ).quickListen<int>(
          controller: counterController,
          listener: (context, state) {
            if (state is QuickData) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Counter: ${state.data}')),
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
