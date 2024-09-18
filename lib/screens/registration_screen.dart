import 'package:flutter/material.dart';
import 'package:diction_dash/constants.dart';
import 'package:diction_dash/screens/fluency_screen.dart';
import 'package:diction_dash/widgets/buttons.dart';
import 'package:diction_dash/widgets/text_fields.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {

  final _formGlobalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
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
      body: Form(
        key: _formGlobalKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const Image(
                      image: AssetImage('images/logo.png'),
                      width: 250,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 30.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('  Register your account',
                              style: kFormInstructionTextStyle),
                          ProfileTextFormField(
                            icon: Icons.person,
                            hintText: 'Username',
                          ),
                          ProfileTextFormField(
                            icon: Icons.mail,
                            hintText: 'Email',
                            keyboardType: TextInputType.emailAddress,
                          ),
                          ProfileTextFormField(
                            icon: Icons.lock,
                            hintText: 'Password',
                            obscureText: true,
                          ),
                          ProfileTextFormField(
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
            ),
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
      ),
    );
  }
}
