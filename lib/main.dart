import 'package:diction_dash/screens/authenticate/auth_manager.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:diction_dash/firebase_options.dart';
import 'package:diction_dash/screens/authenticate/welcome_screen.dart';
import 'package:diction_dash/screens/test_screen.dart';
import 'package:diction_dash/screens/authenticate/registration_screen.dart';
import 'package:diction_dash/screens/authenticate/login_screen.dart';
import 'package:diction_dash/screens/fluency_screen.dart';
import 'package:diction_dash/screens/feedback_screen.dart';
import 'package:diction_dash/screens/home_screen.dart';
import 'package:diction_dash/screens/settings_screen.dart';
import 'package:diction_dash/screens/profile_screen.dart';
import 'package:diction_dash/screens/game/grammar_screen.dart';
import 'package:diction_dash/screens/game/vocabulary_screen.dart';
import 'package:diction_dash/screens/game/spelling_screen.dart';
import 'package:diction_dash/screens/game/comprehension_screen.dart';
import 'package:diction_dash/screens/game/end_game_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthManager(),
    );
  }
}



