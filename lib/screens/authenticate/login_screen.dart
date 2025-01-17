import 'package:flutter/material.dart';
import 'package:diction_dash/services/constants.dart';
import 'package:diction_dash/widgets/buttons.dart';
import 'package:diction_dash/widgets/text_fields.dart';
import 'package:diction_dash/widgets/fox_loading_indicator.dart';
import 'package:diction_dash/services/authentication.dart';
import 'package:diction_dash/screens/authenticate/auth_manager.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  FirebaseAuthenticationService firebaseAuthService =
      FirebaseAuthenticationService();

  final _formGlobalKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';

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
          onPressed: () async {
            FocusScope.of(context).unfocus();
            await Future.delayed(const Duration(milliseconds: 500));
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
                          const Text('  Login your account',
                              style: kFormInstructionTextStyle),
                          ProfileTextFormField(
                            icon: Icons.mail,
                            hintText: 'Email',
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please provide an email.';
                              } else if (!RegExp(r'[\w+]*@[\w.]*')
                                  .hasMatch(value)) {
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
                                return 'Invalid password.';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _password = value!;
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
                // Validate user input & navigate to home screen
                if (_formGlobalKey.currentState!.validate()) {
                  _formGlobalKey.currentState!.save();

                  print(_email);
                  print(_password);

                  showDialog(
                    context: context,
                    builder: (context) {
                      return const FoxLoadingIndicator();
                    },
                  );

                  // Attempt to login user
                  try {
                    await firebaseAuthService.loginUser(
                      email: _email,
                      password: _password,
                    );

                    // Destory loading indicator
                    Navigator.pop(context);

                    // Navigate user to authentication manager
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AuthManager(),
                      ),
                    );

                    // If login is unsuccessful display error message and navigate to welcome screen
                  } catch (e) {
                    print('Login failed: $e');
                    // Destory loading indicator
                    Navigator.pop(context);

                    // Display error message
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Invalid email or password. Try again.'),
                      ),
                    );
                  }
                }
              },
              child: const Center(
                child: Text(
                  'LOGIN',
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
