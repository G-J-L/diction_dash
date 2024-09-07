import 'package:flutter/material.dart';
import 'package:diction_dash/constants.dart';
import 'package:diction_dash/widgets/buttons.dart';

class ComprehensionScreen extends StatefulWidget {
  const ComprehensionScreen({super.key});

  @override
  State<ComprehensionScreen> createState() => _ComprehensionScreenState();
}

class _ComprehensionScreenState extends State<ComprehensionScreen> {
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
            RichText(
              text: const TextSpan(
                style: kSubtext20,
                children: [
                  TextSpan(
                    text: 'Comprehend',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: ' the sentence\nand answer the given question.'),
                ],
              ),
              textAlign: TextAlign.center,
            ),
            const Text(
              'The cat jumped onto the\nand answer the given question.\n\nWhat did the cat do?',
              style: kSubtext20,
              textAlign: TextAlign.center,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 15.0),
              child: Column(
                children: [
                  ChoiceButton(
                    text: 'enjoyed the view',
                    onPressed: () {},
                  ),
                  ChoiceButton(
                    text: 'leaped from a window',
                    onPressed: () {},
                  ),
                  ChoiceButton(
                    text: 'hissed at the dog',
                    onPressed: () {},
                  ),
                  ChoiceButton(
                    text: 'washed the brids',
                    onPressed: () {},
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ChoiceButton extends StatelessWidget {
  ChoiceButton({this.text, this.onPressed});

  final String? text;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return OvalButton(
      color: kOrangeColor600,
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.only(left: 18),
        child: Text(
          text!,
          style: kButtonTextStyleWhite20,
        ),
      ),
    );
  }
}
