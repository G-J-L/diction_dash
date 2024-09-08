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
          icon: Icon(
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
          Image(
            image: AssetImage('images/logo.png'),
            width: 250,
          ),
          Text('HOW FLUENT ARE\nYOU IN ENGLISH?', style: kOswaldMedium),
          SizedBox(height: 15),
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
          ),
        ],
      ),
    );
  }
}
