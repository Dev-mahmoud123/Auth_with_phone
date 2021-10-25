
import 'package:flutter/material.dart';


 void showMyDialog(BuildContext context)  {
   showDialog(
    context: context,
    barrierColor: Colors.white.withOpacity(0),
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return const AlertDialog(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        content:Center(child: CircularProgressIndicator(),),
      );
    },
  );
}

