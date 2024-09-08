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

class ProfileEditTextField extends StatelessWidget {
  ProfileEditTextField({this.text, this.labelText});

  final String? text;
  final String? labelText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 5, bottom: 5),
            child: Text(
              text!,
              style: TextStyle(
                fontSize: 13,
                color: kGrayColor600,
              ),
            ),
          ),
          Container(
            color: kGrayColor100,
            child: TextField(
              cursorColor: kOrangeColor500,
              decoration: InputDecoration(
                suffixIcon: Icon(
                  Icons.edit,
                  size: 30,
                  color: kGrayColor500,
                ),
                labelText: labelText,
                labelStyle: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                border: const OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 1,
                    color: kGrayColor300,
                  ),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 1,
                    color: kGrayColor300,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
