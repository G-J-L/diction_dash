import 'package:diction_dash/services/authentication.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:diction_dash/constants.dart';
import 'package:diction_dash/screens/authenticate/auth_manager.dart';
import 'package:diction_dash/screens/fluency_screen.dart';
import 'package:diction_dash/screens/authenticate/welcome_screen.dart';
import 'package:diction_dash/widgets/text_fields.dart';
import 'package:diction_dash/widgets/bottom_sheets.dart';
import 'package:diction_dash/widgets/buttons.dart';

class ProfileScreen extends StatelessWidget {

  ProfileScreen({super.key});

  final FirebaseAuthenticationService firebaseAuthService = FirebaseAuthenticationService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: kOswaldMedium,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundImage:
                      const AssetImage('images/placeholder_profile.png'),
                  radius: 80,
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: kGrayColor600,
                      ),
                      child:
                          const Icon(Icons.edit, color: Colors.white, size: 28),
                    ),
                  ),
                ),
                ProfileEditButton(
                  text: 'USERNAME',
                  labelText: 'Alice Guo',
                  onPressed: () {
                    showChangeUsernameInterface(context);
                  },
                ),
                ProfileEditButton(
                  text: 'PASSWORD',
                  labelText: '**********',
                  onPressed: () {
                    showChangePasswordInterface(context);
                  },
                ),
                RoundedRectangleButton(
                  color: kGrayColor400,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const FluencyScreen(),
                      ),
                    );
                  },
                  child: const Center(
                    child: Text(
                      'ADJUST FLUENCY',
                      style: kButtonTextStyleBlack,
                    ),
                  ),
                ),
                RoundedRectangleButton(
                  color: kGrayColor400,
                  onPressed: () {
                    showDeleteAccountInterface(context);
                  },
                  child: const Center(
                    child: Text(
                      'DELETE ACCOUNT',
                      style: kButtonTextStyleBlack,
                    ),
                  ),
                ),
              ],
            ),
            RoundedRectangleButton(
              color: kOrangeColor600,
              onPressed: () async {
                await firebaseAuthService.logout();
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => const AuthManager(),
                  ),
                  (Route<dynamic> route) => false,
                );
              },
              child: const Center(
                child: Text(
                  'LOGOUT',
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
