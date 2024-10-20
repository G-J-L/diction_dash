import 'package:audioplayers/audioplayers.dart';

class GameAudio {

  final player = AudioPlayer();
  
  void correctAnswer() {
    player.play(AssetSource('correct.wav'));
  }

  void incorrectAnswer() {
    player.play(AssetSource('incorrect.wav'));
  }

  void congratulations() {
    player.play(AssetSource('congratulations.wav'));
  }

  void flop() {
    player.play(AssetSource('flop.ogg'));
  }
  
}