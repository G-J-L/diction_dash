import 'package:diction_dash/screens/game/comprehension_screen.dart';
import 'package:diction_dash/screens/game/grammar_screen.dart';
import 'package:diction_dash/screens/game/spelling_screen.dart';
import 'package:diction_dash/screens/game/vocabulary_screen.dart';
import 'package:flutter/material.dart';
import 'package:diction_dash/constants.dart';
import 'package:diction_dash/screens/settings_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kOrangeColor600,
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: SafeArea(
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SettingsScreen(),
                            ),
                          );
                        },
                        child: Icon(
                          Icons.settings,
                          color: Colors.white,
                          size: 35,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 60),
                      Text('USERNAME', style: kOswaldLarge),
                      Stack(
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 10),
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
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            width: 230,
                            height: 30,
                            decoration: BoxDecoration(
                              color: kOrangeColor500,
                              borderRadius: BorderRadius.circular(200),
                            ),
                          ),
                          Center(
                            child: Text('Level 1', style: kSubtext20),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      StatCard(
                        text: 'SPELLING',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SpellingScreen(),
                            ),
                          );
                        },
                      ),
                      StatCard(
                        text: 'VOCABULARY',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => VocabularyScreen(),
                            ),
                          );
                        },
                      ),
                      StatCard(
                        text: 'GRAMMAR',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => GrammarScreen(),
                            ),
                          );
                        },
                      ),
                      StatCard(
                          text: 'COMPREHENSION',
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ComprehensionScreen(),
                              ),
                            );
                          }),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            top: 120,
            left: 110,
            child: CircleAvatar(
              radius: 80,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: 70,
                backgroundImage: NetworkImage(
                    'https://t3.ftcdn.net/jpg/05/16/27/58/360_F_516275801_f3Fsp17x6HQK0xQgDQEELoTuERO4SsWV.jpg'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class StatCard extends StatelessWidget {
  StatCard({this.text, this.onPressed});

  final String? text;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: GestureDetector(
          onTap: onPressed,
          child: Container(
            decoration: BoxDecoration(
              color: kGrayColor200,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://t3.ftcdn.net/jpg/05/16/27/58/360_F_516275801_f3Fsp17x6HQK0xQgDQEELoTuERO4SsWV.jpg'),
                    radius: 30,
                  ),
                  Expanded(
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(text!, style: kOswaldMedium),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            width: double.infinity,
                            height: 20,
                            decoration: BoxDecoration(
                              color: kGrayColor100,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: Text('Level 1'),
                            ),
                          ),
                        ],
                      ),
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