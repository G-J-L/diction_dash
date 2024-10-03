import 'package:diction_dash/screens/game/comprehension_screen.dart';
import 'package:diction_dash/screens/game/grammar_screen.dart';
import 'package:diction_dash/screens/game/spelling_screen.dart';
import 'package:diction_dash/screens/game/vocabulary_screen.dart';
import 'package:flutter/material.dart';
import 'package:diction_dash/constants.dart';
import 'package:diction_dash/screens/settings/settings_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.sizeOf(context).height;
    double cardSize = (screenHeight / 6.7).toInt() * 5;
    double profileOffset = cardSize - 70;

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
      body: Stack(
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
                  const Text('USERNAME', style: kOswaldLarge),
                  Stack(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10.0),
                        width: double.infinity,
                        height: 30,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            color: kGrayColor500,
                            width: 1,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10.0),
                        width: 230,
                        height: 30,
                        decoration: BoxDecoration(
                          color: kOrangeColor500,
                          borderRadius: BorderRadius.circular(200),
                        ),
                      ),
                      const Center(
                        child: Text('Level 1', style: kSubtext20),
                      ),
                    ],
                  ),
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
                      }),
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
              child: const CircleAvatar(
                radius: 80,
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  radius: 70,
                  backgroundImage: AssetImage('images/placeholder_profile.png'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class StatCard extends StatelessWidget {
  const StatCard({super.key, this.text, this.image, this.onPressed});

  final String? text;
  final ImageProvider<Object>? image;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        child: GestureDetector(
          onTap: onPressed,
          child: Container(
            decoration: BoxDecoration(
              color: kGrayColor200,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Expanded(
                    child: CircleAvatar(
                      backgroundImage: image!,
                      radius: 40,
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(text!, style: kOswaldSmall),
                        Container(
                          margin:
                              const EdgeInsets.symmetric(horizontal: 10.0),
                          width: double.infinity,
                          height: 20,
                          decoration: BoxDecoration(
                            color: kGrayColor100,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Center(
                            child: Text('Level 1'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
