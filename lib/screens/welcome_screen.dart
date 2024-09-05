import 'package:flutter/material.dart';
import 'package:diction_dash/constants.dart';
import 'package:diction_dash/widgets/buttons.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kOrangeColor600,
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Transform.scale(
                    scale: 4.2, // Scale to make it larger than the screen
                    child: Container(
                      width: MediaQuery.of(context).size.width / 2, // Fixed size
                      height: MediaQuery.of(context).size.width / 2, // Fixed size to ensure it's circular
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      SizedBox(height: 80),
                      Image(
                        image: AssetImage('images/logo.png'),
                        width: 300,
                      ),
                      Text(
                        'WELCOME TO',
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Oswald',
                          color: kGrayColor600,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 6,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Image(
                          image: AssetImage('images/diction_dash.png'),
                        ),
                      ),
                    ],
                  ),
                ]
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OvalButton(
                    text: 'LOGIN',
                    textStyle: kButtonTextStyleOrange,
                    color: Colors.white,
                    onPressed: () {
                      print('LOGIN');
                    },
                  ),
                  OvalButton(
                    text: 'REGISTER',
                    textStyle: kButtonTextStyleWhite,
                    color: kOrangeColor600,
                    borderColor: Colors.white,
                    onPressed: () {
                      print('REGISTER');
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


// WELCOME SCREEN TESTING
class WelcomeTestScreen extends StatelessWidget {
  const WelcomeTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kOrangeColor600,
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  SizedBox(height: 50),
                  Image(
                    image: AssetImage('images/logo.png'),
                    width: 300,
                  ),
                  Text(
                    'WELCOME TO',
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Oswald',
                      color: kGrayColor600,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 6,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Image(
                      image: AssetImage('images/diction_dash.png'),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OvalButton(
                    text: 'LOGIN',
                    textStyle: kButtonTextStyleOrange,
                    color: Colors.white,
                    onPressed: () {
                      print('LOGIN');
                    },
                  ),
                  OvalButton(
                    text: 'REGISTER',
                    textStyle: kButtonTextStyleWhite,
                    color: kOrangeColor600,
                    borderColor: Colors.white,
                    onPressed: () {
                      print('REGISTER');
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
