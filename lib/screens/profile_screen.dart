import 'package:flutter/material.dart';
import 'package:diction_dash/constants.dart';
import 'package:diction_dash/widgets/text_fields.dart';
import 'package:diction_dash/widgets/buttons.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          'Profile',
          style: kOswaldMedium,
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
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
                  backgroundImage: AssetImage('images/placeholder_profile.png'),
                  radius: 80,
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: kGrayColor600,
                      ),
                      child: Icon(Icons.edit, color: Colors.white, size: 28),
                    ),
                  ),
                ),
                ProfileEditTextField(
                  text: 'USERNAME',
                  labelText: 'Alice Guo',
                ),
                ProfileEditTextField(
                  text: 'PASSWORD',
                  labelText: '**********',
                ),
                RoundedRectangleButton(
                  text: 'ADJUST FLUENCY',
                  color: kGrayColor500,
                  onPressed: (){},
                ),
                RoundedRectangleButton(
                  text: 'DELETE ACCOUNT',
                  color: kGrayColor500,
                  onPressed: (){},
                ),
              ],
            ),
            RoundedRectangleButton(
              text: 'LOGOUT',
              color: kOrangeColor600,
              onPressed: (){},
            )
          ],
        ),
      ),
    );
  }
}