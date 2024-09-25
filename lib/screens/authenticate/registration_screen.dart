import 'package:diction_dash/screens/authenticate/auth_manager.dart';
import 'package:diction_dash/screens/authenticate/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  String _username = '';
  String _email = '';
  String _password = '';
  String _confirmPassword = '';

  Future<void> registerUser() async {
    print('Registering New User!');
    if (_password != _confirmPassword) {
      print('Passwords Do Not Match!');
    } else {
      try {
        UserCredential? userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: _email, password: _password);
      } on FirebaseAuthException catch (e) {
        print(e.code);
      }
    }
  }

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
        title: Image(
          image: AssetImage('images/diction_dash.png'),
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
                    const Hero(
                      tag: 'app-logo',
                      child: Image(
                        image: AssetImage('images/logo.png'),
                        width: 250,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40.0, vertical: 30.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('  Register your account',
                              style: kFormInstructionTextStyle),
                          ProfileTextFormField(
                            icon: Icons.person,
                            hintText: 'Username',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please provide a username.';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _username = value!;
                            },
                          ),
                          ProfileTextFormField(
                            icon: Icons.mail,
                            hintText: 'Email',
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please provide a valid email.';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _email = value!;
                            },
                          ),
                          ProfileTextFormField(
                            icon: Icons.lock,
                            hintText: 'Password',
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please provide a valid password.';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _password = value!;
                            },
                          ),
                          ProfileTextFormField(
                            icon: Icons.lock,
                            hintText: 'Confirm Password',
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please provide a valid password.';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _confirmPassword = value!;
                            },
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
              onPressed: () async {
                if (_formGlobalKey.currentState!.validate()) {
                  _formGlobalKey.currentState!.save();
                  print(_username);
                  print(_email);
                  print(_password);
                  print(_confirmPassword);
                }
                await registerUser();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AuthManager(),
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
