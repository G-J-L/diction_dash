import 'package:flutter/material.dart';
import 'package:diction_dash/constants.dart';

class StatCard extends StatelessWidget {
  const StatCard({super.key, this.text, this.image, this.onPressed});

  final String? text;
  final ImageProvider<Object>? image;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        child: GestureDetector(
          onTap: onPressed,
          child: Container(
            decoration: BoxDecoration(
              color: kGrayColor200,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Expanded(
                    child: CircleAvatar(
                      backgroundImage: image!,
                      radius: 40,
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(text!, style: kOswaldSmall),
                        Container(
                          margin:
                          const EdgeInsets.symmetric(horizontal: 10.0),
                          width: double.infinity,
                          height: 20,
                          decoration: BoxDecoration(
                            color: kGrayColor100,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Center(
                            child: Text('Level 1'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}