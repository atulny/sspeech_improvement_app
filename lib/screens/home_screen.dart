import 'package:flutter/material.dart';
import 'package:speech_improvement_app/widgets/custom_app_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Home'),
      body: Center(
        child: Text('Welcome to the Speech Improvement App!',
            style: Theme.of(context).textTheme.bodyLarge),
      ),
    );
  }
}