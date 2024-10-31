import 'package:flutter/material.dart';
import 'package:quick_state/quick_state.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CounterScreen(),
    );
  }
}

class CounterScreen extends StatefulWidget {
  @override
  _CounterScreenState createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  final QuickStateController<int> counterController = QuickStateController<int>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quick_State Example'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          QuickStateBuilder<int>(
            controller: counterController,
            onLoading: (context) => CircularProgressIndicator(),
            onData: (context, data) => Text('Counter: $data', style: TextStyle(fontSize: 24)),
            onError: (context, message) => Text('Error: $message'),
          ),
          ElevatedButton(
            onPressed: () {
              counterController.setLoading();
              Future.delayed(Duration(seconds: 1), () {
                counterController.setData((counterController.state as QuickData<int>).data + 1);
              });
            },
            child: Text('Increment Counter'),
          ),
        ],
      ).quickListen<int>(
        controller: counterController,
        listener: (context, state) {
          if (state is QuickError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
      ),
    );
  }
}
