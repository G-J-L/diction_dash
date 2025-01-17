import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:diction_dash/firebase_options.dart';
import 'package:diction_dash/screens/authenticate/auth_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthManager(),
    );
  }
}



