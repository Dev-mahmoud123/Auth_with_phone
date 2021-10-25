
import 'package:flutter/material.dart';

class BuildIntroTextWidget extends StatelessWidget {
  final String mainText;
  final String secondText;
  const BuildIntroTextWidget({Key? key,required this.mainText,required this.secondText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:  [
        Text(
         mainText,
          style: const TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 24.0),
        Text(
          secondText,
          style: const TextStyle(fontSize: 16.0),
        )
      ],
    );
  }
}
