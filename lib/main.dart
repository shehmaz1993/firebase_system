import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_implementation/HomePage.dart';
import 'package:firebase_implementation/add_post.dart';
import 'package:firebase_implementation/firestore/add_firestore_data.dart';
import 'package:firebase_implementation/sign_in/signin.dart';
import 'package:firebase_implementation/sign_in/signin_phone.dart';
import 'package:firebase_implementation/sign_up/signup.dart';
import 'package:firebase_implementation/user_collection.dart';
import 'package:firebase_implementation/welcomeScreen.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home:AddDataToFireStore(),
    );
  }
}

