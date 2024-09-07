import 'package:flutter/material.dart';
import 'package:diction_dash/constants.dart';

class RoundedRectangleButton extends StatelessWidget {
  final String? text;
  final Color? color;
  final void Function()? onPressed;

  const RoundedRectangleButton({this.text, this.onPressed, this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 16),
          width: double.infinity,
          child: Center(
            child: Text(
              text!,
              style: kButtonTextStyleWhite,
            ),
          ),
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

// class OvalButton extends StatelessWidget {
//   final String? text;
//   final TextStyle? textStyle;
//   final Color? color;
//   final Color? borderColor;
//   final void Function()? onPressed;
//
//   const OvalButton(
//       {this.text,
//       this.textStyle,
//       this.onPressed,
//       this.color,
//       this.borderColor});
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
//       child: TextButton(
//         onPressed: onPressed,
//         child: Container(
//           width: double.infinity,
//           padding: EdgeInsets.symmetric(vertical: 16),
//           decoration: BoxDecoration(
//             color: color,
//             borderRadius: BorderRadius.circular(90),
//             border: Border.all(
//               width: 5,
//               color: (borderColor == null) ? color! : borderColor!,
//             ),
//           ),
//           child: Center(
//             child: Text(
//               text!,
//               style: textStyle!,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

class OvalInfoButton extends StatelessWidget {
  final String? text;
  final TextStyle? textStyle;
  final Color? color;
  final void Function()? onPressed;

  const OvalInfoButton({this.text, this.textStyle, this.onPressed, this.color});

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
                const Icon(
                  Icons.info,
                  size: 35,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
