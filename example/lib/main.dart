import 'package:example/api_check/screens/post_screen.dart';
import 'package:example/controller.dart';
import 'package:example/second_screen.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
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
