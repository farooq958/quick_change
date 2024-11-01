import 'package:example/api_check/screens/post_screen.dart';
import 'package:example/controller.dart';
import 'package:example/second_screen.dart';
import 'package:flutter/material.dart';
import 'package:quick_change/quick_change.dart';

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
            QuickChangeBuilder<int>(
              controller: AppController.counterController,
              onLoading: (context) => const CircularProgressIndicator(),
              onData: (context, data) => Text('Counter: $data', style: const TextStyle(fontSize: 24)),
              onError: (context, message) => Text('Error: $message'),
            ),
            ElevatedButton(
              onPressed: () {
                final currentValue = AppController.counterController.currentData ?? 0;
                AppController.counterController.setData(currentValue + 1);
               ///test with loading
                //AppController.counterController.setLoading();
               //  Future.delayed(const Duration(seconds: 1), () {
               //    final currentValue = AppController.counterController.getCurrentData() ?? 0;
               //    AppController.counterController.setData(currentValue + 1);
               //  });
              },
              child: const Text('Increment Counter'),
            ),

            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) =>  PostsScreen()));
              },
              child: const Text('Api Page'),
            ),
            Text(AppController.counterController.currentData.toString()),
          ],
        ).quickListen<int>(
          controller: AppController.counterController,
          listener: (context, state) {
            if (state is QuickData) {
              if(state.data % 3 == 0){
                Navigator.push(context, MaterialPageRoute(builder: (context) => const SecondScreen()));
              }
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
