import 'package:flutter/material.dart';
import 'package:diction_dash/constants.dart';

class StatCard extends StatelessWidget {
  const StatCard({
    super.key,
    this.text,
    this.image,
    this.onPressed,
    required this.progressValue, // Progress value between 0.0 and 1.0
  });

  final String? text;
  final ImageProvider<Object>? image;
  final void Function()? onPressed;
  final double progressValue;

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
                        // Use Stack to overlay text on the progress bar
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10.0),
                          width: double.infinity,
                          height: 20, // Set the height for the progress bar
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20), // Set the border radius
                            color: kGrayColor100, // Background color of the progress bar
                          ),
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20), // Clip for rounded corners
                                child: LinearProgressIndicator(
                                  value: progressValue,
                                  backgroundColor: Colors.transparent, // Make background transparent
                                  valueColor: AlwaysStoppedAnimation<Color>(kOrangeColor500),
                                  minHeight: 20,
                                ),
                              ),
                              Center(
                                child: Text(
                                  'Level 1', // Text inside the progress bar
                                  style: const TextStyle(color: Colors.black), // Adjust text color
                                ),
                              ),
                            ],
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


