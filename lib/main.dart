import 'package:flutter/material.dart';
import 'package:diction_dash/screens/feedback_screen.dart';
import 'package:diction_dash/screens/welcome_screen.dart';
import 'package:diction_dash/screens/test_screen.dart';
import 'package:diction_dash/screens/registration_screen.dart';
import 'package:diction_dash/screens/login_screen.dart';
import 'package:diction_dash/screens/fluency_screen.dart';
import 'package:diction_dash/screens/home_screen.dart';
import 'package:diction_dash/screens/settings_screen.dart';
import 'package:diction_dash/screens/profile_screen.dart';
import 'package:diction_dash/screens/game/grammar_screen.dart';
import 'package:diction_dash/screens/game/vocabulary_screen.dart';
import 'package:diction_dash/screens/game/spelling_screen.dart';
import 'package:diction_dash/screens/game/comprehension_screen.dart';
import 'package:diction_dash/screens/game/end_game_screen.dart';

void main() {
  runApp(
    MaterialApp(
      home: WelcomeScreen(),
      debugShowCheckedModeBanner: false,
    ),
  );
}


