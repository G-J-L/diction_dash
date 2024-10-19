import 'package:diction_dash/widgets/fox_loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:diction_dash/services/firestore.dart';
import 'package:diction_dash/services/authentication.dart';
import 'package:diction_dash/screens/authenticate/welcome_screen.dart';
import 'package:diction_dash/screens/fluency/fluency_screen.dart';
import 'package:diction_dash/screens/home_screen.dart';

import 'package:diction_dash/services/words_api.dart';

class AuthManager extends StatefulWidget {
  @override
  State<AuthManager> createState() => _AuthManagerState();
}

class _AuthManagerState extends State<AuthManager> {
  final FirebaseAuthenticationService firebaseAuthService = FirebaseAuthenticationService();
  final FirestoreService firestoreService = FirestoreService();

  final WordsAPI wordsAPI = WordsAPI();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //wordsAPI.fetchWord(cefrLevel: 'A1', level: 3);
    // wordsAPI.fetchWordsWithFrequency(5, 5);
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print('Snapshot has data!');
            String? userID = snapshot.data?.uid;
            return StreamBuilder(
              stream: firestoreService.fetchUserData(userID!),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(
                    child: Text('Error loading user data.'),
                  );
                } else if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Material(color: Colors.white);
                } else if (snapshot.hasData) {

                  var userData = snapshot.data!.data();
                  if (userData != null) {
                    userData = userData as Map<String, dynamic>;
                    String? cefrLevel = userData['cefr_level'];
                    int level = userData['level'];
                    if (cefrLevel != null) {
                      wordsAPI.loadPreloadedWords(cefrLevel: cefrLevel, level: level);
                      return HomeScreen();
                    } else {
                      return FluencyScreen();
                    }
                  }
                  print('User data not found');
                  firebaseAuthService.logout();
                  return const Center(
                    child: Text('User data not found.'),
                  );
                } else {
                  return const Center(
                    child: Text('User not found.'),
                  );
                }
              },
            );
          } else {
            return const WelcomeScreen();
          }
        },
      ),
    );
  }
}
