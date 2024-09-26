import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:diction_dash/constants.dart';
import 'package:diction_dash/widgets/buttons.dart';
import 'package:diction_dash/widgets/text_fields.dart';

void showGameDescription(BuildContext context, {String? title, String? description}) {
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

void showChangeUsernameInterface(BuildContext context) {
  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    builder: (context) {
      return const ChangeUsernameInterface();
    },
  );
}

class ChangeUsernameInterface extends StatefulWidget {
  const ChangeUsernameInterface({
    super.key,
  });

  @override
  State<ChangeUsernameInterface> createState() => _ChangeUsernameInterfaceState();
}

class _ChangeUsernameInterfaceState extends State<ChangeUsernameInterface> {
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
                  initialValue: 'Alice Guo',
                ),
              ],
            ),
            RoundedRectangleButton(
              color: kOrangeColor600,
              onPressed: () {
                // TODO: ADD CHANGE USERNAME USING CLOUD FIRESTORE
                print(_newUsernameController.text);
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
  State<ChangePasswordInterface> createState() => _ChangePasswordInterfaceState();
}

class _ChangePasswordInterfaceState extends State<ChangePasswordInterface> {
  final TextEditingController _currentPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

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
                  initialValue: '*********',
                ),
                ProfileEditTextField(
                  controller: _newPasswordController,
                  labelText: 'NEW PASSWORD',
                  initialValue: '*********',
                ),
                ProfileEditTextField(
                  controller: _confirmPasswordController,
                  labelText: 'CONFIRM PASSWORD',
                  initialValue: '*********',
                ),
              ],
            ),
            RoundedRectangleButton(
              color: kOrangeColor600,
              onPressed: () {
                // TODO: CREATE CHANGE PASSWORD WITH FIREBASE AUTH
                print(_currentPasswordController.text);
                print(_newPasswordController.text);
                print(_confirmPasswordController.text);
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
  final TextEditingController _passwordController = TextEditingController();

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
              initialValue: '*********',
            ),
            RoundedRectangleButton(
              color: Colors.redAccent,
              onPressed: () async {
                // TODO: CREATE DELETE ACCOUTN WITH FIREBASE AUTH
                print(_passwordController.text);
                // try {
                //   User? user = FirebaseAuth.instance.currentUser;
                //   AuthCredential credential = EmailAuthProvider.credential(email: user!.email!, password: password)
                // } on FirebaseAuthException catch (e) {
                //
                // }
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
