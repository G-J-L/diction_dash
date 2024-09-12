import 'package:flutter/material.dart';
import 'package:diction_dash/constants.dart';
import 'package:diction_dash/screens/fluency_screen.dart';
import 'package:diction_dash/widgets/buttons.dart';
import 'package:diction_dash/widgets/text_fields.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});

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
          Expanded(
            child: Column(
              children: [
                // Logo
                const Image(
                  image: AssetImage('images/logo.png'),
                  width: 250,
                ),
                // Forms
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('  Register your account',
                          style: kFormInstructionTextStyle),
                      ProfileTextField(
                        icon: Icons.person,
                        hintText: 'Username',
                      ),
                      ProfileTextField(
                        icon: Icons.mail,
                        hintText: 'Email',
                        keyboardType: TextInputType.emailAddress,
                      ),
                      ProfileTextField(
                        icon: Icons.lock,
                        hintText: 'Password',
                        obscureText: true,
                      ),
                      ProfileTextField(
                        icon: Icons.lock,
                        hintText: 'Confirm Password',
                        obscureText: true,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Button
          RoundedRectangleButton(
            color: kOrangeColor600,
            onPressed: () {
              print('REGISTER');
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FluencyScreen(),
                ),
              );
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
    );
  }
}
