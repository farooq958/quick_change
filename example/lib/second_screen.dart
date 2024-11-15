import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'controller.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({super.key});

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  final counterController = GetIt.I.get<CounterController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(


      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
             Text('Second Screen ${counterController.currentData}'),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Go Back'),
            ),
          ],
        ),
      ),

    );
  }
}
