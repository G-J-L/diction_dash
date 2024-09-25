import 'package:flutter/material.dart';
import 'package:diction_dash/constants.dart';
import 'package:diction_dash/screens/authenticate/login_screen.dart';
import 'package:diction_dash/screens/authenticate/registration_screen.dart';
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
              child: Stack(alignment: Alignment.topCenter, children: [
                Transform.scale(
                  scale: 4.2, // Scale to make it larger than the screen
                  child: Container(
                    width: MediaQuery.of(context).size.width / 2, // Fixed size
                    height: MediaQuery.of(context).size.width /
                        2, // Fixed size to ensure it's circular
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                const Column(
                  children: [
                    SizedBox(height: 80),
                    Hero(
                      tag: 'app-logo',
                      child: Image(
                        image: AssetImage('images/logo.png'),
                        width: 300,
                      ),
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
                      child: Hero(
                        tag: 'app-title',
                        child: Image(
                          image: AssetImage('images/diction_dash.png'),
                        ),
                      ),
                    ),
                  ],
                ),
              ]),
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OvalButton(
                    color: Colors.white,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                      );
                      print('LOGIN');
                    },
                    child: const Center(
                      child: Text(
                        'LOGIN',
                        style: kButtonTextStyleOrange,
                      ),
                    ),
                  ),
                  OvalButton(
                    color: kOrangeColor600,
                    borderColor: Colors.white,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegistrationScreen(),
                        ),
                      );
                      print('REGISTER');
                    },
                    child: const Center(
                      child: Text(
                        'REGISTER',
                        style: kButtonTextStyleWhite,
                      ),
                    ),
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