import 'package:flutter/material.dart';
import 'package:diction_dash/constants.dart';
import 'package:diction_dash/widgets/buttons.dart';
import 'package:diction_dash/widgets/bottom_sheets.dart';
import 'package:diction_dash/screens/game/end_game_screen.dart';

class VocabularyScreen extends StatefulWidget {
  const VocabularyScreen({super.key});

  @override
  State<VocabularyScreen> createState() => _VocabularyScreenState();
}

class _VocabularyScreenState extends State<VocabularyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Top Bar
            Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.close,
                        color: kGrayColor500,
                        size: 35,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      height: 30,
                      decoration: BoxDecoration(
                        color: kOrangeColor600,
                        borderRadius: BorderRadius.circular(90),
                      ),
                      child: Center(
                        child: Text(
                          '20 / 20',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: GestureDetector(
                      onTap: (){
                        showGameDescription(context, title: 'Vocabulary', description: 'Select which of the four\noptions you believe to be\nthe best response.');
                      },
                      child: Icon(
                        Icons.help,
                        color: kGrayColor500,
                        size: 35,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            RichText(
              text: const TextSpan(
                style: kSubtext20,
                children: [
                  TextSpan(text: 'Select the appropriate\n'),
                  TextSpan(
                    text: 'synonym.',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              'distinct',
              style: kOswaldLarge,
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OvalButton(
                    color: kOrangeColor600,
                    onPressed: () {
                      print('mystic');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EndGameScreen(),
                        ),
                      );
                    },
                    child: Center(
                      child: Text(
                        'mystic',
                        style: kButtonTextStyleWhite,
                      ),
                    ),
                  ),
                  OvalButton(
                    color: kOrangeColor600,
                    onPressed: () {
                      print('demure');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EndGameScreen(),
                        ),
                      );
                    },
                    child: Center(
                      child: Text(
                        'demure',
                        style: kButtonTextStyleWhite,
                      ),
                    ),
                  ),
                  OvalButton(
                    color: kOrangeColor600,
                    onPressed: () {
                      print('unique');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EndGameScreen(),
                        ),
                      );
                    },
                    child: Center(
                      child: Text(
                        'unique',
                        style: kButtonTextStyleWhite,
                      ),
                    ),
                  ),
                  OvalButton(
                    color: kOrangeColor600,
                    onPressed: () {
                      print('exhausted');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EndGameScreen(),
                        ),
                      );
                    },
                    child: Center(
                      child: Text(
                        'exhausted',
                        style: kButtonTextStyleWhite,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
