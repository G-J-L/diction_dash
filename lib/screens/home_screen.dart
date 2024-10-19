import 'dart:math';
import 'package:diction_dash/services/helper.dart';
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

            // Fetches username, profile picture url, level, and total exp from firestore
            String username = userData['username'];
            var imageUrl = userData['profile_picture'];
            String cefrLevel = userData['cefr_level'];

            int level = userData['level'];
            int userExp = userData['exp'];
            int prevMaxExp = userData['previous_max_exp'];
            int maxExp = calculateMaxEXP(level);

            print(maxExp);

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
                          currentExp: prevMaxExp - userExp,
                          maxExp: prevMaxExp - maxExp,
                        ),
                        const SizedBox(height: 5.0),
                        StreamBuilder(
                          stream: firestoreService.fetchSpellingData(userID),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              // TODO: Display fox loading animation
                              return const LoadingCard();
                            } else if (snapshot.hasError) {
                              return const Center(
                                  child: Text('Error loading user data.'));
                            } else if (snapshot.hasData &&
                                snapshot.data!.exists) {
                              var spellingData =
                              snapshot.data!.data() as Map<String, dynamic>;
                              int spellingLevel = spellingData['level'];
                              int spellingExp = spellingData['exp'];
                              int spellingPrevMaxExp = spellingData['previous_max_exp'];
                              int spellingMaxExp = calculateMaxEXP(spellingLevel);
                              return StatCard(
                                text: 'SPELLING',
                                image: const AssetImage('images/spelling.png'),
                                level: spellingLevel,
                                currentExp: spellingPrevMaxExp - spellingExp,
                                maxExp: spellingPrevMaxExp - spellingMaxExp,
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                      SpellingScreen(cefrLevel: cefrLevel, level: level),
                                    ),
                                  );
                                },
                              );
                            } else {
                              return const Center(child: Text('Data not found.'));
                            }
                          },
                        ),
                        StreamBuilder(
                          stream: firestoreService.fetchVocabularyData(userID),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              // TODO: Display fox loading animation
                              return const LoadingCard();
                            } else if (snapshot.hasError) {
                              return const Center(
                                  child: Text('Error loading user data.'));
                            } else if (snapshot.hasData &&
                                snapshot.data!.exists) {
                              var vocabularyData =
                              snapshot.data!.data() as Map<String, dynamic>;
                              int vocabularyLevel = vocabularyData['level'];
                              int vocabularyExp = vocabularyData['exp'];
                              int vocabularyPrevMaxExp = vocabularyData['previous_max_exp'];
                              int vocabularyMaxExp = calculateMaxEXP(vocabularyLevel);
                              return StatCard(
                                text: 'VOCABULARY',
                                image: const AssetImage('images/vocabulary.png'),
                                level: vocabularyLevel,
                                currentExp: vocabularyPrevMaxExp - vocabularyExp,
                                maxExp: vocabularyPrevMaxExp - vocabularyMaxExp,
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                      VocabularyScreen(cefrLevel: cefrLevel, level: level),
                                    ),
                                  );
                                },
                              );
                            } else {
                              return const Center(child: Text('Data not found.'));
                            }
                          },
                        ),
                        StreamBuilder(
                          stream: firestoreService.fetchGrammarData(userID),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              // TODO: Display fox loading animation
                              return const LoadingCard();
                            } else if (snapshot.hasError) {
                              return const Center(
                                  child: Text('Error loading user data.'));
                            } else if (snapshot.hasData &&
                                snapshot.data!.exists) {
                              var grammarData =
                              snapshot.data!.data() as Map<String, dynamic>;
                              int grammarLevel = grammarData['level'];
                              int grammarExp = grammarData['exp'];
                              int grammarPrevMaxExp = grammarData['previous_max_exp'];
                              int grammarMaxExp = calculateMaxEXP(grammarLevel);
                              return StatCard(
                                text: 'GRAMMAR',
                                image: const AssetImage('images/grammar.png'),
                                level: grammarLevel,
                                currentExp: grammarPrevMaxExp - grammarExp,
                                maxExp: grammarPrevMaxExp - grammarMaxExp,
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          GrammarScreen(cefrLevel: cefrLevel),
                                    ),
                                  );
                                },
                              );
                            } else {
                              return const Center(child: Text('Data not found.'));
                            }
                          },
                        ),
                        StreamBuilder(
                          stream:
                              firestoreService.fetchComprehensionData(userID),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              // TODO: Display fox loading animation
                              return const LoadingCard();
                            } else if (snapshot.hasError) {
                              return const Center(
                                  child: Text('Error loading user data.'));
                            } else if (snapshot.hasData &&
                                snapshot.data!.exists) {
                              var comprehensionData =
                              snapshot.data!.data() as Map<String, dynamic>;
                              int comprehensionLevel =
                              comprehensionData['level'];
                              int comprehensionExp = comprehensionData['exp'];
                              int comprehensionPrevMaxExp = comprehensionData['previous_max_exp'];
                              int comprehensionMaxExp = calculateMaxEXP(comprehensionLevel);
                              return StatCard(
                                text: 'COMPREHENSION',
                                image:
                                const AssetImage('images/comprehension.png'),
                                level: comprehensionLevel,
                                currentExp: comprehensionPrevMaxExp - comprehensionExp,
                                maxExp: comprehensionPrevMaxExp - comprehensionMaxExp,
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ComprehensionScreen(
                                          cefrLevel: cefrLevel),
                                    ),
                                  );
                                },
                              );
                            } else {
                              return const Center(child: Text('Data not found.'));
                            }
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
