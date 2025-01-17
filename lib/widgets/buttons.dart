import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:diction_dash/services/constants.dart';

class RoundedRectangleButton extends StatelessWidget {
  final Widget? child;
  final Color? color;
  final void Function()? onPressed;

  const RoundedRectangleButton({super.key, this.child, this.onPressed, this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 16),
          width: double.infinity,
          child: child,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}

class OvalButton extends StatelessWidget {
  final Widget? child;
  final Color? color;
  final Color? borderColor;
  final void Function()? onPressed;

  const OvalButton({this.child, this.onPressed, this.color, this.borderColor});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(90),
          border: Border.all(
            width: 5,
            color: (borderColor == null) ? color! : borderColor!,
          ),
        ),
        child: child,
      ),
    );
  }
}

class OvalInfoButton extends StatelessWidget {
  const OvalInfoButton(
      {this.text,
      this.textStyle,
      this.onPressed,
      this.color,
      this.infoTitle,
      this.infoDescription});

  final String? text;
  final TextStyle? textStyle;
  final Color? color;
  final void Function()? onPressed;
  final String? infoTitle;
  final String? infoDescription;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: color,
          padding: EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(90),
          ),
        ),
        child: Container(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  text!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Alert(
                      context: context,
                      title: infoTitle,
                      desc: infoDescription,
                      style: AlertStyle(
                        titleStyle: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        descStyle: TextStyle(
                          fontSize: 18,
                        ),
                        backgroundColor: kGrayColor200,
                        overlayColor: Colors.black26,
                        alertBorder: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      buttons: [
                        DialogButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text('CANCEL', style: kButtonTextStyleWhite),
                          color: kOrangeColor600,
                        ),
                      ]
                    ).show();
                  },
                  child: const Icon(
                    Icons.info,
                    size: 35,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProfileEditButton extends StatelessWidget {
  const ProfileEditButton({this.text, this.labelText, this.onPressed});

  final String? text;
  final String? labelText;
  final void Function()? onPressed;

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
              style: const TextStyle(
                fontSize: 13,
                color: kGrayColor600,
              ),
            ),
          ),
          GestureDetector(
            onTap: onPressed,
            child: Container(
              width: double.infinity,
              height: 60,
              decoration: BoxDecoration(
                color: kGrayColor100,
                border: Border.all(
                  color: kGrayColor300,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: ListTile(
                title: Text(
                  labelText!,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: const Icon(
                  Icons.edit,
                  size: 30,
                  color: kGrayColor500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ChoiceButton extends StatelessWidget {

  const ChoiceButton({super.key, this.text, this.color, this.onPressed});

  final String? text;
  final void Function()? onPressed;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return OvalButton(
      color: color,
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.only(left: 18.0),
        child: Text(
          text!,
          style: kButtonTextStyleWhite20,
        ),
      ),
    );
  }
}
