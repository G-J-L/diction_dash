import 'package:flutter/material.dart';
import 'package:diction_dash/services/constants.dart';
import 'package:diction_dash/widgets/buttons.dart';
import 'package:diction_dash/widgets/text_fields.dart';
import 'package:diction_dash/services/authentication.dart';
import 'package:diction_dash/services/firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:diction_dash/screens/authenticate/auth_manager.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final FirebaseAuthenticationService firebaseAuthService = FirebaseAuthenticationService();
  final FirestoreService firestoreService = FirestoreService();

  final _formGlobalKey = GlobalKey<FormState>();
  String _username = '';
  String _email = '';
  String _password = '';
  String _confirmPassword = '';

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
                              if (value == null || value.isEmpty || value.trim().isEmpty) {
                                return 'Please provide a username.';
                              } else if (value.length < 3) {
                                return 'Please provide a longer username';
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
                                return 'Please provide an email.';
                              } else if (!RegExp(r'[\w+]*@[\w.]*').hasMatch(value)) {
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
                                return 'Please provide a password.';
                              } else if (value.length < 8 && !RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$').hasMatch(value)) {
                                return 'Please provide a valid password.\n'
                                    '- Minimum 8 Characters\n'
                                    '- Minimum 1 Upper case\n'
                                    '- Minimum 1 Lowercase\n'
                                    '- Minimum 1 Number\n'
                                    '- Minimum 1 Special Character';
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
                                return 'Please confirm password.';
                              }

                              // else if (_password != value && value.isNotEmpty){
                              //   ScaffoldMessenger.of(context).showSnackBar(
                              //       const SnackBar(
                              //           content: Text('Passwords not matching!'),
                              //       ),
                              //   );
                              // }
                              //  else if (_password != value && _password.isNotEmpty) {
                              //   return 'Passwords are not matching.';
                              // } changing to snackbar

                              // else if (value.length < 8 || RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$').hasMatch(value)) {
                              //   return 'Please provide a valid password.\n'
                              //       '- Minimum 8 Characters\n'
                              //       '- Minimum 1 Upper case\n'
                              //       '- Minimum 1 Lowercase\n'
                              //       '- Minimum 1 Number\n'
                              //       '- Minimum 1 Special Character';
                              // } removed cs no need in confirm.
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

                      if (_password != _confirmPassword){
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Passwords do not match. Try again.'),
                          ),
                        );
                        return;
                      }

                  print(_username);
                  print(_email);
                  print(_password);
                  print(_confirmPassword);

                  FocusScope.of(context).unfocus();

                  // Register user in firebase auth
                  User? user = await firebaseAuthService.registerUser(
                    email: _email,
                    password: _password,
                    confirmPassword: _confirmPassword,
                  );

                  // Store user data in firestore
                  await firestoreService.addNewUser(
                    userID: user!.uid,
                    username: _username,
                    email: _email,
                  );

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AuthManager(),
                    ),
                  );
                }
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
