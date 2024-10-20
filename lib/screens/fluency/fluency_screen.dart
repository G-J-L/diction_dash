import 'package:flutter/material.dart';
import 'package:diction_dash/services/constants.dart';
import 'package:diction_dash/screens/fluency/feedback_screen.dart';
import 'package:diction_dash/widgets/buttons.dart';
import 'package:diction_dash/services/firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FluencyScreen extends StatelessWidget {

  final FirestoreService firestoreService = FirestoreService();
  final String? userID = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context); // Navigate back when back arrow is clicked
          },
        ),
        title: Image.asset(
          'images/diction_dash.png',
          width: 220,
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const Image(
            image: AssetImage('images/logo.png'),
            width: 250,
          ),
          const Text('HOW FLUENT ARE\nYOU IN ENGLISH?', style: kOswaldMedium),
          const SizedBox(height: 15),

          // Beginner Button
          OvalInfoButton(
            text: 'BEGINNER',
            textStyle: kButtonTextStyleWhite,
            color: kOrangeColor600,
            onPressed: (){
              // Assign user's CEFR Level to A1
              firestoreService.updateCEFR(userID: userID, newLevel: 'A1');

              // Navigate user to the feedback screen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FeedbackScreen(),
                ),
              );
            },
            infoTitle: 'BEGINNER',
            infoDescription: 'I know a few words and phrases but struggle with basic sentences.',
          ),

          // Elementary Button
          OvalInfoButton(
            text: 'ELEMENTARY',
            textStyle: kButtonTextStyleWhite,
            color: kOrangeColor600,
            onPressed: (){
              // Assign user's CEFR Level to A1
              firestoreService.updateCEFR(userID: userID, newLevel: 'A2');

              // Navigate user to the feedback screen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FeedbackScreen(),
                ),
              );
            },
            infoTitle: 'ELEMENTARY',
            infoDescription: 'I can understand simple spoken English and basic written texts.',
          ),

          // Intermediate Button
          OvalInfoButton(
            text: 'INTERMEDIATE',
            textStyle: kButtonTextStyleWhite,
            color: kOrangeColor600,
            onPressed: (){
              // Assign user's CEFR Level to B1
              firestoreService.updateCEFR(userID: userID, newLevel: 'B1');

              // Navigate user to the feedback screen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FeedbackScreen(),
                ),
              );
            },
            infoTitle: 'INTERMEDIATE',
            infoDescription: 'I can hold basic conversations, read, and write with some errors.',
          ),

          // Advanced Button
          OvalInfoButton(
            text: 'ADVANCED',
            textStyle: kButtonTextStyleWhite,
            color: kOrangeColor600,
            onPressed: (){
              // Assign user's CEFR Level to B2
              firestoreService.updateCEFR(userID: userID, newLevel: 'B2');

              // Navigate user to the feedback screen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FeedbackScreen(),
                ),
              );
            },
            infoTitle: 'ADVANCED',
            infoDescription: 'I can understand and engage in various topics, and read and write effectively with minimal errors.',
          ),

          // Expert Button
          OvalInfoButton(
            text: 'EXPERT',
            textStyle: kButtonTextStyleWhite,
            color: kOrangeColor600,
            onPressed: (){
              // Assign user's CEFR Level to C1
              firestoreService.updateCEFR(userID: userID, newLevel: 'C1');

              // Navigate user to the feedback screen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FeedbackScreen(),
                ),
              );
            },
            infoTitle: 'EXPERT',
            infoDescription: 'I am fluent in English, capable of understanding complex texts and engaging in advanced conversations effortlessly.',
          ),
        ],
      ),
    );
  }
}
