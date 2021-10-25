import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_maps/business_logic_layer/cubits/phone_auth/auth_cubit.dart';
import 'package:flutter_maps/constants/my_colors.dart';
import 'package:flutter_maps/constants/strings.dart';
import 'package:flutter_maps/presentation_layer/widgets/alert_dialog_widget.dart';
import 'package:flutter_maps/presentation_layer/widgets/build_intro_text_widget.dart';
import 'package:flutter_maps/presentation_layer/widgets/elevated_button_widget.dart';
import 'package:flutter_maps/presentation_layer/widgets/pin_code_text_widget.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerifyScreen extends StatelessWidget {
  final dynamic phoneNumber;
  late String otpCode;

  VerifyScreen({Key? key, required this.phoneNumber}) : super(key: key);

  void _login(context) {
    BlocProvider.of<AuthCubit>(context).sendOtp(otpCode);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 25.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const BuildIntroTextWidget(
                mainText: 'Verify your phone number',
                secondText: 'Enter your 6 digits code number sent to you at ',
              ),
              const SizedBox(
                height: 5.0,
              ),
              Text(
                '$phoneNumber',
                style: const TextStyle(
                  color: MyColors.myBlue,
                ),
              ),
              const SizedBox(
                height: 35.0,
              ),
              PinCodeTextWidget(
                onComplete: (submittedCode) {
                  otpCode = submittedCode!;
                },
              ),
              const SizedBox(
                height: 40.0,
              ),
              ElevatedButtonWidget(
                text: 'Verify',
                onPressed: () {
                  showMyDialog(context);
                  _login(context);
                },
              ),
              const SizedBox(
                height: 30.0,
              ),
              const Align(
                alignment: Alignment.center,
                child: Text(
                  'Did\'t receive a verification code ? ',
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    child: const Text('Resend Code'),
                    onPressed: () {},
                  ),
                  Container(
                    width: 2.0,
                    height: 20.0,
                    color: Colors.black,
                  ),
                  TextButton(
                    child: const Text('Change Number'),
                    onPressed: () {},
                  ),
                ],
              ),
              /// TODO : Bloc Listener
              BlocListener<AuthCubit, AuthState>(
                  listenWhen: (previous, current) {
                    return previous != current;
                  },
                  listener: (context, state) {
                    if (state is LoadingState) {
                      showMyDialog(context);
                    }
                    if (state is PhoneNumberVerified) {
                      Navigator.pop(context);
                      Navigator.pushReplacementNamed(context, mapScreen);
                    }
                    if (state is ErrorState) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            state.error,
                            style: const TextStyle(color: Colors.white),
                          ),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  child:Container(),
              ),
            ],
          ),
        ),


      ),
    );
  }
}
