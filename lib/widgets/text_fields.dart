import 'package:flutter/material.dart';
import 'package:diction_dash/constants.dart';

class ProfileTextField extends StatelessWidget {
  ProfileTextField(
      {this.icon, this.hintText, this.keyboardType, this.obscureText = false});

  final IconData? icon;
  final String? hintText;
  final TextInputType? keyboardType;
  final bool? obscureText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: kGrayColor100,
        child: TextField(
          keyboardType: keyboardType,
          obscureText: obscureText!,
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

class ProfileTextFormField extends StatelessWidget {
  ProfileTextFormField({
    this.icon,
    this.hintText,
    this.keyboardType,
    this.obscureText = false,
    this.validator,
    this.onSaved,
  });

  final IconData? icon;
  final String? hintText;
  final FormFieldValidator<String>? validator;
  final FormFieldSetter<String>? onSaved;
  final TextInputType? keyboardType;
  final bool? obscureText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: kGrayColor100,
        child: TextFormField(
          validator: validator,
          onSaved: onSaved,
          keyboardType: keyboardType,
          obscureText: obscureText!,
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

class ProfileEditTextField extends StatefulWidget {
  const ProfileEditTextField(
      {super.key,
      this.controller,
      this.labelText,
      this.initialValue = '',
      this.keyboardType,
      this.obscureText = false});

  final TextEditingController? controller;
  final String? labelText;
  final String? initialValue;
  final TextInputType? keyboardType;
  final bool? obscureText;

  @override
  State<ProfileEditTextField> createState() => _ProfileEditTextFieldState();
}

class _ProfileEditTextFieldState extends State<ProfileEditTextField> {
  // late TextEditingController _controller;
  //
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.controller!.text = widget.initialValue!;
    // _controller = TextEditingController(text: widget.initialValue);
  }

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
              widget.labelText!,
              style: const TextStyle(
                fontSize: 13,
                color: kGrayColor600,
              ),
            ),
          ),
          Container(
            color: kGrayColor100,
            child: TextField(
              controller: widget.controller,
              keyboardType: widget.keyboardType,
              obscureText: widget.obscureText!,
              cursorColor: kOrangeColor500,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              decoration: const InputDecoration(
                suffixIcon: Icon(
                  Icons.edit,
                  size: 30,
                  color: kGrayColor500,
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 1,
                    color: kGrayColor300,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
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
