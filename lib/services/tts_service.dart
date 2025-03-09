import 'package:flutter_tts/flutter_tts.dart';

class TTSService {
  final FlutterTts flutterTts = FlutterTts();

  Future<void> speak(String text, String language) async {
    await flutterTts.setLanguage(language);
    await flutterTts.setPitch(1.0);
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.speak(text);
  }
}