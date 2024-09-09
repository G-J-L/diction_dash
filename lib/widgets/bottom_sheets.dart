import 'package:flutter/material.dart';
import 'package:diction_dash/constants.dart';
import 'package:diction_dash/widgets/buttons.dart';
import 'package:diction_dash/widgets/text_fields.dart';

void showGameDescription(BuildContext context,
    {String? title, String? description}) {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
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
            SizedBox(height: 20),
            Text(
              title!,
              style: kSubtext32.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Text(
              description!,
              style: kSubtext20,
              textAlign: TextAlign.center,
            )
          ],
        ),
      );
    },
  );
}

void showChangeUsernameInterface(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        height: 600,
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
                SizedBox(height: 10),
                Text(
                  'Change Username',
                  style: kSubtext20.copyWith(fontWeight: FontWeight.bold),
                ),
                ProfileEditTextField(
                  text: 'NEW USERNAME',
                  labelText: 'New Username',
                ),
              ],
            ),
            RoundedRectangleButton(
              text: 'CONTINUE',
              color: kOrangeColor600,
              onPressed: () {},
            ),
          ],
        ),
      );
    },
  );
}

void showChangePasswordInterface(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        height: 600,
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
                SizedBox(height: 10),
                Text(
                  'Change Password',
                  style: kSubtext20.copyWith(fontWeight: FontWeight.bold),
                ),
                ProfileEditTextField(
                  text: 'CURRENT PASSWORD',
                  labelText: '*********',
                ),
                ProfileEditTextField(
                  text: 'NEW PASSWORD',
                  labelText: '*********',
                ),
                ProfileEditTextField(
                  text: 'CONFIRM PASSWORD',
                  labelText: '*********',
                ),
              ],
            ),
            RoundedRectangleButton(
              text: 'CONTINUE',
              color: kOrangeColor600,
              onPressed: () {},
            ),
          ],
        ),
      );
    },
  );
}

void showDeleteAccountInterface(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        height: 600,
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
                SizedBox(height: 10),
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
              text: 'PASSWORD',
              labelText: '*********',
            ),
            RoundedRectangleButton(
              text: 'DELETE',
              color: Colors.redAccent,
              onPressed: () {},
            ),
          ],
        ),
      );
    },
  );
}