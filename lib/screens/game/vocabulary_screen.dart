import 'package:flutter/material.dart';
import 'package:diction_dash/constants.dart';
import 'package:diction_dash/widgets/buttons.dart';

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
                    child: Icon(
                      Icons.close,
                      color: kGrayColor500,
                      size: 35,
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
                    child: Icon(
                      Icons.help,
                      color: kGrayColor500,
                      size: 35,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              'Identify if the sentence\nis grammatically correct.',
              style: kSubtext20,
              textAlign: TextAlign.center,
            ),
            Text(
              "She was walking down the\nstreet when she seen a dog\nthat was barking loudly at\nit's owner",
              style: kSubtext20,
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OvalButton(
                    text: 'CORRECT',
                    textStyle: kButtonTextStyleWhite,
                    color: kOrangeColor600,
                    onPressed: () {
                      print('CORRECT');
                    },
                  ),
                  OvalButton(
                    text: 'INCORRECT',
                    textStyle: kButtonTextStyleOrange,
                    color: Colors.white,
                    borderColor: kOrangeColor600,
                    onPressed: () {
                      print('INCORRECT');
                    },
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
