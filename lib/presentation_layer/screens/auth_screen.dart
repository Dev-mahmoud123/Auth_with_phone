import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_maps/business_logic_layer/cubits/phone_auth/auth_cubit.dart';
import 'package:flutter_maps/constants/strings.dart';
import 'package:flutter_maps/presentation_layer/widgets/alert_dialog_widget.dart';
import 'package:flutter_maps/presentation_layer/widgets/elevated_button_widget.dart';
import 'package:flutter_maps/presentation_layer/widgets/build_intro_text_widget.dart';
import 'package:flutter_maps/presentation_layer/widgets/select_country_and_enter_phone_widget.dart';

class AuthScreen extends StatelessWidget {
  AuthScreen({Key? key}) : super(key: key);
  late String phoneNumber;
  final _formKey = GlobalKey<FormState>();

  /// TODO : Register function
  Future<void> _register(context) async {
    if (!_formKey.currentState!.validate()) {
      Navigator.pop(context);
      return;
    } else {
      Navigator.pop(context);
      _formKey.currentState!.save();
      BlocProvider.of<AuthCubit>(context).sendPhoneNumber(phoneNumber);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child:Container(
          margin:
          const EdgeInsets.symmetric(horizontal: 20.0, vertical: 50.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// TODO : Intro text
                const BuildIntroTextWidget(
                  mainText: 'What is your phone number ? ',
                  secondText:
                  'please enter your phone number to verify \nyour account .',
                ),
                const SizedBox(height: 77.0),

                /// TODO : Selected Country and enter phone No.
                SelectCountryAndEnterPhoneWidget(
                  onSaved: (value) {
                    phoneNumber = value!;
                  },
                ),
                const SizedBox(height: 60.0),
                ElevatedButtonWidget(
                  text: 'Next',
                  onPressed: () {
                    showMyDialog(context);
                    _register(context);
                  },
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
                      if (state is PhoneNumberSubmitted) {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, verifyScreen,
                            arguments: phoneNumber);
                      }
                      if (state is ErrorState) {
                        Navigator.pop(context);
                        log('Error'+state.error);
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
      ),
    );
  }
}
