import 'package:flutter/material.dart';
import 'package:diction_dash/services/constants.dart';
import 'package:diction_dash/widgets/buttons.dart';
import 'package:diction_dash/screens/authenticate/auth_manager.dart';

class FeedbackScreen extends StatelessWidget {
  const FeedbackScreen({super.key});

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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            children: [
              Image(
                image: AssetImage('images/logo_eyes_closed.png'),
                width: 250,
              ),
              Text(
                'THANK YOU\nFOR YOUR FEEDBACK!',
                textAlign: TextAlign.center,
                style: kOswaldMedium,
              ),
            ],
          ),
          const Text(
            'Your proficiency level will be\nadjusted accordingly, to provide\na better learning interactivity. You can\nadjust the difficulty level in the settings\nlater.',
            textAlign: TextAlign.center,
            style: kGraySubtext18,
          ),
          RoundedRectangleButton(
            color: kOrangeColor600,
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => AuthManager(),
                ),
                    (Route<dynamic> route) => false,
              );
              print('Button was pressed!');
            },
            child: const Center(
              child: Text(
                'PROCEED',
                style: kButtonTextStyleWhite,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
