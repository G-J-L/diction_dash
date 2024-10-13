import 'package:flutter/material.dart';
import 'package:diction_dash/services/constants.dart';

class UserLevelBar extends StatelessWidget {
  const UserLevelBar({
    super.key,
    required this.progressValue,
  });

  final double progressValue;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background container
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10.0),
          width: double.infinity,
          height: 30,
          decoration: BoxDecoration(
            color: Colors.white, // Background color for the container
            borderRadius: BorderRadius.circular(30), // Rounded corners
            border: Border.all(
              color: Colors.white, // Border color
              width: 1, // Border width
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30), // Match the rounded corners
            child: LinearProgressIndicator(
              value: progressValue,
              backgroundColor: kGrayColor200,
              valueColor: AlwaysStoppedAnimation<Color>(kOrangeColor500),
              minHeight: 30,
            ),
          ),
        ),

        const Center(
          child: Text('Level 1', style: kSubtext20),
        ),
      ],
    );
  }
}

class MinigameLevelBar extends StatelessWidget {
  const MinigameLevelBar({
    super.key,
    required this.progressValue,
  });

  final double progressValue;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20), // Clip for rounded corners
          child: LinearProgressIndicator(
            value: progressValue,
            backgroundColor: kGrayColor100, // Make background transparent
            valueColor: const AlwaysStoppedAnimation<Color>(kOrangeColor300),
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
    );
  }
}

class QuestionBar extends StatelessWidget {
  QuestionBar({
    super.key,
    this.questionNumber,
  });

  final int? questionNumber;

  @override
  Widget build(BuildContext context) {

    final displayNumber = questionNumber ?? 0;

    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(90.0),
          child: LinearProgressIndicator(
            value: displayNumber / 10.0,
            backgroundColor: Colors.transparent,
            valueColor: AlwaysStoppedAnimation<Color>(kOrangeColor600),
            minHeight: 30,
          ),
        ),
        // Centered Text
        Center(
          child: Text(
            '${displayNumber.toString()} / 10',
            style: const TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}


