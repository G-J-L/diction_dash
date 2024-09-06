import 'package:flutter/material.dart';
import 'package:diction_dash/screens/settings_screen.dart';
import 'package:diction_dash/screens/feedback_screen.dart';
import 'package:diction_dash/screens/welcome_screen.dart';
import 'package:diction_dash/screens/test_screen.dart';
import 'package:diction_dash/screens/registration_screen.dart';
import 'package:diction_dash/screens/login_screen.dart';
import 'package:diction_dash/screens/fluency_screen.dart';

void main() {
  runApp(
    MaterialApp(
      home: FluencyScreen(),
      debugShowCheckedModeBanner: false,
    ),
  );
}


