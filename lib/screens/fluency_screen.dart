import 'package:flutter/material.dart';
import 'package:diction_dash/constants.dart';
import 'package:diction_dash/screens/feedback_screen.dart';
import 'package:diction_dash/widgets/buttons.dart';
import 'package:diction_dash/widgets/text_fields.dart';

class FluencyScreen extends StatelessWidget {
  const FluencyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context); // Navigate back when back arrow is clicked
          },
        ),
        title: Image.asset(
          'images/diction_dash.png',
          width: 220,
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const Image(
            image: AssetImage('images/logo.png'),
            width: 250,
          ),
          const Text('HOW FLUENT ARE\nYOU IN ENGLISH?', style: kOswaldMedium),
          const SizedBox(height: 15),
          OvalInfoButton(
            text: 'BEGINNER',
            textStyle: kButtonTextStyleWhite,
            color: kOrangeColor600,
            onPressed: (){
              print('BEGINNER');
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FeedbackScreen(),
                ),
              );
            },
            infoTitle: 'BEGINNER',
            infoDescription: 'I know a few words and phrases but struggle with basic sentences.',
          ),
          OvalInfoButton(
            text: 'ELEMENTARY',
            textStyle: kButtonTextStyleWhite,
            color: kOrangeColor600,
            onPressed: (){
              print('ELEMENTARY');
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FeedbackScreen(),
                ),
              );
            },
            infoTitle: 'ELEMENTARY',
            infoDescription: 'I can understand simple spoken English and basic written texts.',
          ),
          OvalInfoButton(
            text: 'INTERMEDIATE',
            textStyle: kButtonTextStyleWhite,
            color: kOrangeColor600,
            onPressed: (){
              print('INTERMEDIATE');
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FeedbackScreen(),
                ),
              );
            },
            infoTitle: 'INTERMEDIATE',
            infoDescription: 'I can hold basic conversations, read, and write with some errors.',
          ),
          OvalInfoButton(
            text: 'ADVANCED',
            textStyle: kButtonTextStyleWhite,
            color: kOrangeColor600,
            onPressed: (){
              print('ADVANCED');
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FeedbackScreen(),
                ),
              );
            },
            infoTitle: 'ADVANCED',
            infoDescription: 'I can understand and engage in various topics, and read and write effectively with minimal errors.',
          ),
          OvalInfoButton(
            text: 'EXPERT',
            textStyle: kButtonTextStyleWhite,
            color: kOrangeColor600,
            onPressed: (){
              print('EXPERT');
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FeedbackScreen(),
                ),
              );
            },
            infoTitle: 'EXPERT',
            infoDescription: 'I am fluent in English, capable of understanding complex texts and engaging in advanced conversations effortlessly.',
          ),
        ],
      ),
    );
  }
}
