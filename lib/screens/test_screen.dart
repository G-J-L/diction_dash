import 'package:flutter/material.dart';

class TestScreen extends StatelessWidget {
  void _showModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 200,
          child: Center(
            child: Text('This is a modal bottom sheet'),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bottom Sheet Example'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _showModalBottomSheet(context),
          child: Text('Show Modal Bottom Sheet'),
        ),
      ),
    );
  }
}