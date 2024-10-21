import 'package:audioplayers/audioplayers.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GameAudio {

  final player = AudioPlayer();
  bool soundsEnabled = true;

  GameAudio() {
    _init();
  }

  void _init() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    soundsEnabled = prefs.getBool('soundsEnabled') ?? true;
    print(soundsEnabled);
  }
  
  void correctAnswer() {
    if (soundsEnabled) {
      player.play(AssetSource('correct.wav'));
    }
  }

  void incorrectAnswer() {
    if (soundsEnabled) {
      player.play(AssetSource('incorrect.wav'));
    }
  }

  void congratulations() {
    if (soundsEnabled) {
      player.play(AssetSource('congratulations.wav'));
    }
  }

  void flop() {
    if (soundsEnabled) {
      player.play(AssetSource('flop.ogg'));
    }
  }
  
}