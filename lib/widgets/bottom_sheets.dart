import 'package:diction_dash/services/authentication.dart';
import 'package:diction_dash/services/firestore.dart';
import 'package:diction_dash/widgets/fox_loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:diction_dash/services/constants.dart';
import 'package:diction_dash/screens/authenticate/auth_manager.dart';
import 'package:diction_dash/widgets/buttons.dart';
import 'package:diction_dash/widgets/text_fields.dart';

// Show Game Description
void showGameDescription(BuildContext context,
    {String? title, String? description}) {
  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
          width: double.infinity,
          height: 300,
          child: Column(
            children: [
              Container(
                width: 80,
                height: 4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(90),
                  color: kGrayColor500,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                title!,
                style: kSubtext32.copyWith(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Text(
                description!,
                style: kSubtext20,
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      );
    },
  );
}

// Show Change Username Interface
void showChangeUsernameInterface(BuildContext context, String username) {
  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    builder: (context) {
      return ChangeUsernameInterface(username: username);
    },
  );
}

class ChangeUsernameInterface extends StatefulWidget {
  const ChangeUsernameInterface({
    super.key,
    this.username,
  });

  final String? username;

  @override
  State<ChangeUsernameInterface> createState() =>
      _ChangeUsernameInterfaceState();
}

class _ChangeUsernameInterfaceState extends State<ChangeUsernameInterface> {
  final FirestoreService firestoreService = FirestoreService();

  final String userID = FirebaseAuth.instance.currentUser!.uid;

  final TextEditingController _newUsernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
        height: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Container(
                  width: 80,
                  height: 4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(90),
                    color: kGrayColor500,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Change Username',
                  style: kSubtext20.copyWith(fontWeight: FontWeight.bold),
                ),
                ProfileEditTextField(
                  controller: _newUsernameController,
                  labelText: 'NEW USERNAME',
                  initialValue: widget.username,
                ),
              ],
            ),
            RoundedRectangleButton(
              color: kOrangeColor600,
              onPressed: () {
                print(_newUsernameController.text);
                firestoreService.updateUsername(
                    userID: userID, newUsername: _newUsernameController.text);
                Navigator.pop(context);
              },
              child: const Center(
                child: Text(
                  'CONTINUE',
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

// Show Change Password Interface
void showChangePasswordInterface(BuildContext context) {
  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    builder: (context) {
      return const ChangePasswordInterface();
    },
  );
}

class ChangePasswordInterface extends StatefulWidget {
  const ChangePasswordInterface({
    super.key,
  });

  @override
  State<ChangePasswordInterface> createState() =>
      _ChangePasswordInterfaceState();
}

class _ChangePasswordInterfaceState extends State<ChangePasswordInterface> {
  final FirebaseAuthenticationService firebaseAuthService =
      FirebaseAuthenticationService();

  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        height: 460,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Container(
                  width: 80,
                  height: 4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(90),
                    color: kGrayColor500,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Change Password',
                  style: kSubtext20.copyWith(fontWeight: FontWeight.bold),
                ),
                ProfileEditTextField(
                  controller: _currentPasswordController,
                  labelText: 'CURRENT PASSWORD',
                  obscureText: true,
                ),
                ProfileEditTextField(
                  controller: _newPasswordController,
                  labelText: 'NEW PASSWORD',
                  obscureText: true,
                ),
                ProfileEditTextField(
                  controller: _confirmPasswordController,
                  labelText: 'CONFIRM PASSWORD',
                  obscureText: true,
                ),
              ],
            ),
            RoundedRectangleButton(
              color: kOrangeColor600,
              onPressed: () async {
                if (_newPasswordController.text ==
                    _confirmPasswordController.text) {
                  await firebaseAuthService.reauthenticateAndChangePassword(
                    currentPassword: _currentPasswordController.text,
                    newPassword: _newPasswordController.text,
                  );
                } else {
                  // TODO: Let the user know that the new password and confirmed password do not match
                  print('Passwords do not match!');
                }
                FocusScope.of(context).unfocus();
                // Slight delay to avoid renderflex error with keyboard
                await Future.delayed(Duration(milliseconds: 1000));
                Navigator.pop(context);
              },
              child: const Center(
                child: Text(
                  'CONTINUE',
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

// Show Delete Account Interface
void showDeleteAccountInterface(BuildContext context) {
  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    builder: (context) {
      return const DeleteAccountInterface();
    },
  );
}

class DeleteAccountInterface extends StatefulWidget {
  const DeleteAccountInterface({
    super.key,
  });

  @override
  State<DeleteAccountInterface> createState() => _DeleteAccountInterfaceState();
}

class _DeleteAccountInterfaceState extends State<DeleteAccountInterface> {
  final FirebaseAuthenticationService firebaseAuthService =
      FirebaseAuthenticationService();

  final FirestoreService firestoreService = FirestoreService();

  final TextEditingController _passwordController = TextEditingController();

  Future<void> deleteAccount(BuildContext context, {String? email, String? password}) async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      print("No user is currently signed in.");
    } else {

      String? userID = user.uid;

      // Show loading indicator
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const FoxLoadingIndicator(),
      );

      try {
        // Re-authenticate the user
        AuthCredential credential = EmailAuthProvider.credential(email: email!, password: password!);
        await user.reauthenticateWithCredential(credential);

          await firebaseAuthService.reauthenticateAndDelete(password: password);
          await firestoreService.deleteUser(userID);

        // Hide loading indicator and navigate to the welcome screen
        Navigator.of(context).pop(); // Close the loading dialog
        print("Account deleted successfully.");
      } catch (e) {
        // Handle specific errors
        if (e is FirebaseAuthException && e.code == 'invalid-credential') {
          print('Invalid user credential!');
        } else {
          print("Error deleting account: $e");
          print('Failed to delete account. Please try again.');
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        height: 400,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Container(
                  width: 80,
                  height: 4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(90),
                    color: kGrayColor500,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Account Deletion',
                  style: kSubtext20.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Text(
              'Are you sure you want to\ndelete your account? Once you\ndelete it, you cannot get it back.\n\nEnter your password to confirm.',
              style: kSubtext20,
              textAlign: TextAlign.center,
            ),
            ProfileEditTextField(
              controller: _passwordController,
              labelText: 'PASSWORD',
              obscureText: true,
            ),
            RoundedRectangleButton(
              color: Colors.redAccent,
              onPressed: () async {
                FocusScope.of(context).unfocus();

                Navigator.pop(context);
                // Deletes current user's account and navigates them back to the welcome screen.
                String? userID = firebaseAuthService.getCurrentUserID();

                // deleteAccount(
                //     userID: userID, password: _passwordController.text);

                deleteAccount(context, email: FirebaseAuth.instance.currentUser!.email, password: _passwordController.text);

                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => AuthManager(),
                  ),
                  (Route<dynamic> route) => false,
                );
              },
              child: const Center(
                child: Text(
                  'DELETE',
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
