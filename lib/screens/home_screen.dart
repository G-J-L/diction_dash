import 'dart:math';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:diction_dash/services/firestore.dart';
import 'package:diction_dash/services/constants.dart';
import 'package:diction_dash/screens/game/comprehension/comprehension_screen.dart';
import 'package:diction_dash/screens/game/grammar/grammar_screen.dart';
import 'package:diction_dash/screens/game/spelling/spelling_screen.dart';
import 'package:diction_dash/screens/game/vocabulary/vocabulary_screen.dart';
import 'package:diction_dash/screens/settings/settings_screen.dart';
import 'package:diction_dash/widgets/linear_progress_indicators.dart';
import 'package:diction_dash/widgets/fox_loading_indicator.dart';
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
            return const FoxLoadingIndicator();
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error loading user data.'));
          } else if (snapshot.hasData && snapshot.data!.exists) {
            var userData = snapshot.data!.data() as Map<String, dynamic>;

            // Print user data for debugging purposes
            print('$userData');

            // Fetches username, profile picture url, level, and total exp from firestore
            String username = userData['username'];
            var imageUrl = userData['profile_picture'];
            int level = userData['level'];
            int userExp = userData['exp'];
            int maxExp = 100;

            // Fetches level and exp for spelling from firestore
            int spellingLevel = userData['spelling_level'];
            int spellingExp = userData['spelling_exp'];

            // Fetches level and exp for vocabulary from firestore
            int vocabularyLevel = userData['vocabulary_level'];
            int vocabularyExp = userData['vocabulary_exp'];

            // Fetches level and exp for grammar from firestore
            int grammarLevel = userData['grammar_level'];
            int grammarExp = userData['grammar_exp'];

            // Fetches level and exp for comprehension from firestore
            int comprehensionLevel = userData['comprehension_level'];
            int comprehensionExp = userData['comprehension_exp'];

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
                        Text(
                          username,
                          textAlign: TextAlign.center,
                          style: kOswaldLarge,
                        ),
                        UserLevelBar(
                          level: level,
                          currentExp: userExp,
                          maxExp: maxExp,
                        ),
                        const SizedBox(height: 5.0),
                        StatCard(
                          text: 'SPELLING',
                          image: const AssetImage('images/spelling.png'),
                          level: spellingLevel,
                          currentExp: spellingExp,
                          maxExp: maxExp,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SpellingScreen(),
                              ),
                            );
                          },
                        ),
                        StatCard(
                          text: 'VOCABULARY',
                          image: const AssetImage('images/vocabulary.png'),
                          level: vocabularyLevel,
                          currentExp: vocabularyExp,
                          maxExp: maxExp,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const VocabularyScreen(),
                              ),
                            );
                          },
                        ),
                        StatCard(
                          text: 'GRAMMAR',
                          image: const AssetImage('images/grammar.png'),
                          level: grammarLevel,
                          currentExp: grammarExp,
                          maxExp: maxExp,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const GrammarScreen(),
                              ),
                            );
                          },
                        ),
                        StatCard(
                          text: 'COMPREHENSION',
                          image: const AssetImage('images/comprehension.png'),
                          level: comprehensionLevel,
                          currentExp: comprehensionExp,
                          maxExp: maxExp,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const ComprehensionScreen(),
                              ),
                            );
                          },
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
                        backgroundImage: imageUrl != null
                            ? NetworkImage(imageUrl)
                            : const AssetImage(
                                'images/placeholder_profile.png'),
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
