import 'dart:async';


import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_implementation/HomePage.dart';
import 'package:firebase_implementation/sign_in/signin.dart';
import 'package:flutter/material.dart';

class SplashService{


  void isLogIn(BuildContext context){
    final auth=FirebaseAuth.instance;
    final user= auth.currentUser;
    if(user!=null){
      print(user.email);

      Timer(const Duration(seconds: 3),
              ()=>Navigator.push(context,MaterialPageRoute(builder: (context)=>HomeScreen()))
      );
    }
    else{
      Timer(const Duration(seconds: 3),
              ()=>Navigator.push(context,MaterialPageRoute(builder: (context)=>SignInPage()))
      );
    }
  }
}