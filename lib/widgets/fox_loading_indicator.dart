import 'package:flutter/material.dart';
import 'package:diction_dash/services/constants.dart';

class FoxLoadingIndicator extends StatelessWidget {
  const FoxLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('images/fox_loading.gif', width: 150),
            const Text(
              'Loading...',
              style: kOswaldSmall,
            ),
          ],
        ),
      ),
    );
  }
}
