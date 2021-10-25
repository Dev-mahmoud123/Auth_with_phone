
import 'package:flutter/material.dart';

class ElevatedButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  const ElevatedButtonWidget({Key? key, required this.text,required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: ElevatedButton(
        onPressed: onPressed,
        child:  Text(
          text,
          style: const TextStyle(color: Colors.white , fontSize: 16.0),
        ),
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            primary: Colors.black,
            padding: const EdgeInsets.symmetric(horizontal: 40.0 , vertical: 15.0)
        ),
      ),
    );
  }
}
