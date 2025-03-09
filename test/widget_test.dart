import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:speech_improvement_app/screens/home_screen.dart';

void main() {
  testWidgets('HomeScreen has a title and a button', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: HomeScreen()));

    // Verify that the title is present
    expect(find.text('Speech Improvement App'), findsOneWidget);

    // Verify that the button to start chatting is present
    expect(find.byType(ElevatedButton), findsOneWidget);
  });
}