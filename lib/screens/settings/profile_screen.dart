import 'dart:io';

import 'package:diction_dash/services/authentication.dart';
import 'package:diction_dash/services/firestore.dart';
import 'package:diction_dash/services/profile_picture.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:diction_dash/constants.dart';
import 'package:diction_dash/screens/authenticate/auth_manager.dart';
import 'package:diction_dash/screens/fluency_screen.dart';
import 'package:diction_dash/widgets/bottom_sheets.dart';
import 'package:diction_dash/widgets/buttons.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final FirestoreService firestoreService = FirestoreService();

  final FirebaseAuthenticationService firebaseAuthService =
      FirebaseAuthenticationService();

  String userID = FirebaseAuth.instance.currentUser!.uid;

  final ProfilePicture profilePicture = ProfilePicture();

  File? image;
  String? downloadUrl;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      image = profilePicture.getImage();
      downloadUrl = profilePicture.getDownloadUrl();
      print(downloadUrl);
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: firestoreService.fetchUserData(userID),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // TODO: Display fox loading animation
          return const CircularProgressIndicator();
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Error loading user data.'));
        } else if (snapshot.hasData && snapshot.data!.exists) {
          var userData = snapshot.data!.data() as Map<String, dynamic>;
          String username = userData['username'];
          var imageUrl = userData['profile_picture'];
          print(username);
          print(imageUrl);
          // TODO: Fetch profile picture url
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
                        backgroundImage: imageUrl != null
                            ? NetworkImage(imageUrl)
                            : const AssetImage('images/placeholder_profile.png'),
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
                            child: InkWell(
                              onTap: () async {
                                profilePicture.showImageSourceActionSheet(
                                  context,
                                  () {
                                    setState(() {
                                      image = profilePicture.getImage();
                                      downloadUrl = profilePicture.getDownloadUrl();
                                    });
                                    firestoreService.updateProfilePicture(
                                      userID: userID,
                                      imageUrl: downloadUrl,
                                    );
                                  },
                                );
                                print('================');
                                print(profilePicture.getImage());
                                print(image);
                                print('================');
                              },
                              child: const Icon(Icons.edit,
                                  color: Colors.white, size: 28),
                            ),
                          ),
                        ),
                      ),
                      ProfileEditButton(
                        text: 'USERNAME',
                        labelText: username,
                        onPressed: () {
                          showChangeUsernameInterface(context, username);
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
        } else {
          return const Center(child: Text('User data not found.'));
        }
      },
    );
  }
}
