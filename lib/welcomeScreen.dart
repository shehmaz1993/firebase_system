import 'dart:async';
import 'dart:io';
import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:firebase_implementation/sign_in/signin.dart';
import 'package:firebase_implementation/splashservice.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  String devicename='';
  String deviceversion='';
  String identifier='';
  String? res;

  SplashService splash=SplashService();
  startTime() async {
    var duration =  const Duration(seconds: 4);
    return  Timer(duration, navigationPage);
  }

  Future<bool> isInternet() async {
    bool result = await InternetConnectionChecker().hasConnection;
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      // I am connected to a mobile network, make sure there is actually a net connection.
      if (result==true) {
        Flushbar(message: 'You are connected to Internet!',backgroundColor: Colors.green,flushbarPosition: FlushbarPosition.TOP,
          flushbarStyle: FlushbarStyle.FLOATING,isDismissible: false, duration: Duration(seconds: 5),reverseAnimationCurve: Curves.decelerate,
          forwardAnimationCurve: Curves.elasticOut,)..show(context);
        // Mobile data detected & internet connection confirmed.
       /* ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('you are connected to internet!'),
        ),);*/
        return true;
      } else {
        // Mobile data detected but no internet connection found.
        Flushbar(message: 'You do not have Internet connection',backgroundColor: Colors.redAccent,flushbarPosition: FlushbarPosition.TOP,
          flushbarStyle: FlushbarStyle.FLOATING,isDismissible: false, duration: Duration(seconds: 5),reverseAnimationCurve: Curves.decelerate,
          forwardAnimationCurve: Curves.elasticOut,)..show(context);
        return false;
      }
    } else if (connectivityResult == ConnectivityResult.wifi) {
      // I am connected to a WIFI network, make sure there is actually a net connection.
      if ( result==true) {
        // Wifi detected & internet connection confirmed.
        Flushbar(message: 'You are  connected to Internet!',backgroundColor: Colors.green,flushbarPosition: FlushbarPosition.TOP,
          flushbarStyle: FlushbarStyle.FLOATING,isDismissible: false, duration: Duration(seconds: 5),reverseAnimationCurve: Curves.decelerate,
          forwardAnimationCurve: Curves.elasticOut,).show(context);
        return true;
      } else {
        // Wifi detected but no internet connection found.
        Flushbar(message: 'You do not have Internet connection',backgroundColor: Colors.redAccent,flushbarPosition: FlushbarPosition.TOP,
          flushbarStyle: FlushbarStyle.FLOATING,isDismissible: false, duration: Duration(seconds: 5),reverseAnimationCurve: Curves.decelerate,
          forwardAnimationCurve: Curves.elasticOut,).show(context);
        return false;
      }
    } else {
      // Neither mobile data or WIFI detected, not internet connection found.
      Flushbar(message: 'You do not have Internet connection',backgroundColor: Colors.redAccent,flushbarPosition: FlushbarPosition.TOP,
        flushbarStyle: FlushbarStyle.FLOATING,isDismissible: false, duration: Duration(seconds: 5),reverseAnimationCurve: Curves.decelerate,
        forwardAnimationCurve: Curves.elasticOut,).show(context);
      return false;
    }
  }
  void navigationPage()async {
    var v=await isInternet();


    if(v==true ){
       splash.isLogIn(context);

    }
    else{
      SystemNavigator.pop();
    }
  }

  @override
  void initState() {
    super.initState();
   // startTime();
    navigationPage();
    // SystemChrome.setEnabledSystemUIOverlays([]);

  }

  @override
  Widget build(BuildContext context) {

    return  const Scaffold(
      backgroundColor: Colors.white,
        body: Center(
          child: SizedBox(
            height: 100,
            width: 100,
            child: CircularProgressIndicator(),

          ),
        )


    );

  }
}
