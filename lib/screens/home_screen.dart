import 'package:diction_dash/services/firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:diction_dash/services/constants.dart';
import 'package:diction_dash/screens/game/comprehension/comprehension_screen.dart';
import 'package:diction_dash/screens/game/grammar/grammar_screen.dart';
import 'package:diction_dash/screens/game/spelling/spelling_screen.dart';
import 'package:diction_dash/screens/game/vocabulary/vocabulary_screen.dart';
import 'package:diction_dash/screens/settings/settings_screen.dart';
import 'package:diction_dash/widgets/linear_progress_indicators.dart';
import 'package:diction_dash/widgets/cards.dart';

class HomeScreen extends StatelessWidget {

  FirestoreService firestoreService = FirestoreService();

  String userID = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.sizeOf(context).height;
    double cardSize = (screenHeight / 6.7).toInt() * 5;
    double profileOffset = cardSize - 70;
    double progressValue = 0.8;

    return Scaffold(
      backgroundColor: kOrangeColor600,
      appBar: AppBar(
        backgroundColor: kOrangeColor600,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SettingsScreen(),
                ),
              );
            },
            child: const Icon(
              Icons.settings,
              color: Colors.white,
              size: 35,
            ),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: firestoreService.fetchUserData(userID),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // TODO: Display fox loading animation
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.white70,
              ),
            );
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error loading user data.'));
          } else if (snapshot.hasData && snapshot.data!.exists) {
            var userData = snapshot.data!.data()  as Map<String, dynamic>;
            String username = userData['username'];
            var imageUrl = userData['profile_picture'];
            return Stack(
              children: [
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: double.infinity,
                    // bottom: 600
                    height: cardSize,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 60),
                        Text(username, style: kOswaldLarge),
                        UserLevelBar(progressValue: progressValue),
                        const SizedBox(height: 5.0),
                        StatCard(
                          text: 'SPELLING',
                          image: const AssetImage('images/spelling.png'),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SpellingScreen(),
                              ),
                            );
                          },
                          progressValue: progressValue,
                        ),
                        StatCard(
                          text: 'VOCABULARY',
                          image: const AssetImage('images/vocabulary.png'),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const VocabularyScreen(),
                              ),
                            );
                          },
                          progressValue: progressValue,
                        ),
                        StatCard(
                          text: 'GRAMMAR',
                          image: const AssetImage('images/grammar.png'),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const GrammarScreen(),
                              ),
                            );
                          },
                          progressValue: progressValue,
                        ),
                        StatCard(
                            text: 'COMPREHENSION',
                            image: const AssetImage('images/comprehension.png'),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ComprehensionScreen(),
                                ),
                              );
                            },
                          progressValue: progressValue,
                        ),
                        const SizedBox(height: 10.0),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    // bottom: 530
                    padding: EdgeInsets.only(bottom: profileOffset),
                    child: CircleAvatar(
                      radius: 80,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: 70,
                        backgroundImage: imageUrl != null ? NetworkImage(imageUrl) : const AssetImage('images/placeholder_profile.png'),
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else {
            return const Center(child: Text('User data not found.'));
          }
        },
      ),
    );
  }
}
