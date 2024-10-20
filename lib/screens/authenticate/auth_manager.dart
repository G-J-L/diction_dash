import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:diction_dash/services/firestore.dart';
import 'package:diction_dash/services/authentication.dart';
import 'package:diction_dash/services/words_api.dart';
import 'package:diction_dash/screens/authenticate/welcome_screen.dart';
import 'package:diction_dash/screens/fluency/fluency_screen.dart';
import 'package:diction_dash/screens/home_screen.dart';

// The authentication manager listens to authentication changes and redirects
// the user to the appropriate page.

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
    return Scaffold(

      // Listen to authentication changes (login and logout)
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {

          // If the snapshot has data, get user details and navigate to the next page
          if (snapshot.hasData) {
            print('Snapshot has data!');
            String? userID = snapshot.data?.uid;

            // Listen to stored user data
            return StreamBuilder(
              stream: firestoreService.fetchUserData(userID!),
              builder: (context, snapshot) {

                // If the snapshot has error, display an error message.
                if (snapshot.hasError) {
                  return const Center(
                    child: Text('Error loading user data.'),
                  );

                // If snapshot is still loading, return a blank screen
                } else if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Material(color: Colors.white);

                // If the snapshot has data, navigate to the home or fluency screen
                } else if (snapshot.hasData) {
                  var userData = snapshot.data!.data();
                  if (userData != null) {
                    userData = userData as Map<String, dynamic>;
                    String? cefrLevel = userData['cefr_level'];
                    int level = userData['level'];

                    // If user has CEFR Level, navigate to the home screen
                    if (cefrLevel != null) {
                      wordsAPI.loadSpellingQuestionData(cefrLevel: cefrLevel, level: level);
                      wordsAPI.loadVocabularyQuestionData(cefrLevel: cefrLevel, level: level);
                      return HomeScreen();

                    // If the user does not have CEFR Level, navigate to the fluency screen
                    } else {
                      // The fluency screen provides an interface for the user to select their CEFR Level
                      return FluencyScreen();
                    }
                  }

                  // Otherwise, logout the current account
                  print('User data not found');
                  firebaseAuthService.logout();
                  return const Center(
                    child: Text('User data not found.'),
                  );
                } else {
                  // If user cannot be found, display the appropriate error message
                  return const Center(
                    child: Text('User not found.'),
                  );
                }
              },
            );

          // If snapshot does not have data, navigate to the welcome screen
          } else {
            return const WelcomeScreen();
          }
        },
      ),
    );
  }
}
