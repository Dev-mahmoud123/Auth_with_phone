
import 'package:flutter/material.dart';
import 'package:flutter_maps/constants/my_colors.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class PinCodeTextWidget  extends StatelessWidget {
  final void Function(String?) onComplete;
  const PinCodeTextWidget ({Key? key,required this.onComplete}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  PinCodeTextField(
      appContext: context,
      length: 6,
      onChanged: (v) {},
      keyboardType: TextInputType.number,
      cursorColor: MyColors.myBlue,
      autoFocus: true,
      autoDismissKeyboard: true,
      animationType: AnimationType.fade,
      obscureText: false,
      blinkWhenObscuring: true,
      enableActiveFill: true,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(5.0),
        fieldHeight: 50.0,
        fieldWidth: 40.0,
        borderWidth: 1.0,
        activeColor: MyColors.myBlue,
        inactiveColor: MyColors.myBlue,
        activeFillColor: MyColors.lightWhite,
        selectedColor: MyColors.myBlue,
        selectedFillColor: Colors.white,
        inactiveFillColor: Colors.white,
      ),
      onCompleted:onComplete ,
    );
  }
}
