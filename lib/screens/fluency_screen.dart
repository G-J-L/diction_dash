import 'package:flutter/material.dart';
import 'package:diction_dash/constants.dart';
import 'package:diction_dash/widgets/buttons.dart';
import 'package:diction_dash/widgets/profile_text_field.dart';

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
          Text('HOW FLUENT ARE YOU IN ENGLISH?'),
          OvalButton(
            text: 'BEGINNER',
            textStyle: kButtonTextStyleWhite,
            color: kOrangeColor600,
            onPressed: (){},
          ),
          OvalButton(
            text: 'ELEMENTARY',
            textStyle: kButtonTextStyleWhite,
            color: kOrangeColor600,
            onPressed: (){},
          ),
          OvalButton(
            text: 'INTERMEDIATE',
            textStyle: kButtonTextStyleWhite,
            color: kOrangeColor600,
            onPressed: (){},
          ),
          OvalButton(
            text: 'ADVANCED',
            textStyle: kButtonTextStyleWhite,
            color: kOrangeColor600,
            onPressed: (){},
          ),
          OvalButton(
            text: 'EXPERT',
            textStyle: kButtonTextStyleWhite,
            color: kOrangeColor600,
            onPressed: (){},
          ),
        ],
      ),
    );
  }
}
