import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_maps/business_logic_layer/cubits/phone_auth/auth_cubit.dart';
import 'package:flutter_maps/constants/strings.dart';
import 'package:flutter_maps/presentation_layer/screens/map_screen.dart';
import 'package:flutter_maps/presentation_layer/screens/verify_screen.dart';
import '../presentation_layer/screens/auth_screen.dart';

class AppRoute {
  AuthCubit? authCubit;

  AppRoute() {
    authCubit = AuthCubit();
  }

  Route? generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case authScreen:
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                  value: authCubit!,
                  child: AuthScreen(),
                ));

      case verifyScreen:
        final  phoneNumber = settings.arguments;
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
              value: authCubit!, child: VerifyScreen(phoneNumber:phoneNumber)),
        );

      case mapScreen :
        return MaterialPageRoute(builder: (_) =>  const MapScreen());
    }
  }
}
