import 'package:flutter/material.dart';
import 'package:diction_dash/constants.dart';

class ProfileTextField extends StatelessWidget {

  ProfileTextField({this.icon, this.hintText});

  final IconData? icon;
  final String? hintText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: kGrayColor100,
        child: TextField(
          cursorColor: kOrangeColor500,
          decoration: InputDecoration(
            prefixIcon: Icon(
              icon,
              size: 35,
              color: kOrangeColor400,
            ),
            hintText: hintText,
            border: const OutlineInputBorder(
              borderSide: BorderSide(
                width: 1,
                color: kGrayColor300,
              ),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                width: 2,
                color: kOrangeColor300,
              ),
            ),
          ),
        ),
      ),
    );
  }
}