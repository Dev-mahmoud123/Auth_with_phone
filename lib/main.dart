import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_maps/constants/app_routes.dart';

import 'constants/strings.dart';


late String initRoute;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.white,
    statusBarIconBrightness: Brightness.dark,
  ));
  /// TODO : Check if User is exist or not
  FirebaseAuth.instance.authStateChanges().listen((user) {
    if(user == null){
      initRoute = authScreen;
    }else{
      initRoute = mapScreen;
    }
  });

  runApp( MyApp(appRoute: AppRoute(),));
}

class MyApp extends StatelessWidget {
  final AppRoute appRoute ;
  const MyApp({Key? key,required this.appRoute}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute:appRoute.generateRoutes,
      initialRoute: initRoute,
    );
  }
}

