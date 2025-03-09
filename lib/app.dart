import 'package:flutter/material.dart';
import 'package:speech_improvement_app/screens/home_screen.dart';
import 'package:speech_improvement_app/utils/theme.dart';

class SpeechApp extends StatelessWidget {
  const SpeechApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Speech Improvement App',
      theme: AppTheme.lightTheme,
      home: const HomeScreen(),
    );
  }
  
}