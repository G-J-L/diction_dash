import 'package:flutter/material.dart';
import 'package:diction_dash/constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FeedbackScreen(),
      debugShowCheckedModeBanner: false, // Optional: Hide the debug banner
    );
  }
}

class FeedbackScreen extends StatelessWidget {
  const FeedbackScreen({super.key}); // Added key for consistency

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kOrangeColor200, // Make sure kOrangeColor200 is defined in constants
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context); // Navigate back when back arrow is clicked
          },
        ),
        title: Image.asset('diction_dash/images/diction_dash.png'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('diction_dash/images/logo.png',
              height: 100),
              SizedBox(height: 20),
              // Thank you message
              Text(
                'THANK YOU\nFOR YOUR FEEDBACK!',
                textAlign: TextAlign.center,
                style: fontOsw,
              ),
              SizedBox(height: 20),
              // Proficiency level adjustment message
              Text(
                'Your proficiency level will be adjusted accordingly, to '
                    'provide a better learning interactivity. You can adjust '
                    'the difficulty level in the settings later.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 40),
              // Proceed button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    print("Proceed button clicked!"); // Action for the Proceed button
                  },
                  child: Text(
                    'PROCEED',
                    style: TextStyle(fontSize: 18),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: kOrangeColor500, // Updated color property
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
