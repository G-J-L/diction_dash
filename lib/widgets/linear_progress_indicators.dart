import 'package:flutter/material.dart';
import 'package:diction_dash/services/constants.dart';

class UserLevelBar extends StatelessWidget {
  const UserLevelBar({
    super.key,
    required this.level,
    required this.currentExp,
    required this.maxExp,
  });

  final int level;
  final int currentExp;
  final int maxExp;

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
              value: currentExp / maxExp,
              backgroundColor: kGrayColor200,
              valueColor: AlwaysStoppedAnimation<Color>(kOrangeColor500),
              minHeight: 30,
            ),
          ),
        ),

        Center(
          child: Text('Level $level', style: kSubtext20),
        ),
      ],
    );
  }
}

class MinigameLevelBar extends StatelessWidget {
  const MinigameLevelBar({
    super.key,
    required this.level,
    required this.currentExp,
    required this.maxExp,
  });

  final int level;
  final int currentExp;
  final int maxExp;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20), // Clip for rounded corners
          child: LinearProgressIndicator(
            value: currentExp / maxExp,
            backgroundColor: kGrayColor100, // Make background transparent
            valueColor: const AlwaysStoppedAnimation<Color>(kOrangeColor300),
            minHeight: 20,
          ),
        ),
        Center(
          child: Text(
            'Level $level', // Text inside the progress bar
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

class CountdownProgressIndicator extends StatefulWidget {
  final int durationInSeconds;
  final bool isStopped;
  final void Function()? onTimerComplete;

  const CountdownProgressIndicator({
    Key? key,
    required this.durationInSeconds,
    required this.isStopped,
    this.onTimerComplete,
  }) : super(key: key);

  @override
  _CountdownProgressIndicatorState createState() => _CountdownProgressIndicatorState();
}

class _CountdownProgressIndicatorState extends State<CountdownProgressIndicator>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();
    _initController();
    _startTimer();
  }

  void _initController() {
    // Initialize the AnimationController without starting it automatically
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: widget.durationInSeconds),
    );

    // Define the color transitions from green to orange to red
    _colorAnimation = TweenSequence<Color?>([
      TweenSequenceItem(
        tween: ColorTween(begin: Colors.red, end: Colors.orange.shade100),
        weight: 50,
      ),
      TweenSequenceItem(
        tween: ColorTween(begin: Colors.orange.shade100, end: Colors.green),
        weight: 50,
      ),
    ]).animate(_controller);

    // Add a listener to trigger the callback when the timer finishes
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.dismissed && widget.onTimerComplete != null) {
        widget.onTimerComplete!();
      }
    });
  }

  @override
  void didUpdateWidget(covariant CountdownProgressIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Check if the isStopped value has changed
    if (widget.isStopped != oldWidget.isStopped) {
      if (widget.isStopped) {
        _controller.stop();
        _resetTimer();
      } else {
        // Start the timer again (from where it left off)
        _startTimer();
      }
    }
  }

  void _startTimer() {
    // Explicitly start the countdown when called
    _controller.reverse(from: 1.0);
  }

  void _resetTimer() {
    // Dispose of the old controller and reinitialize the timer
    _controller.dispose();
    _initController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return LinearProgressIndicator(
          value: _controller.value,
          valueColor: _colorAnimation,
          backgroundColor: Colors.green.shade100,
        );
      },
    );
  }
}