import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_implementation/sign_in/signin.dart';
import 'package:firebase_implementation/utils/utils.dart';
import 'package:flutter/material.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final auth=FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: (){

                auth.signOut().then((value){
                  Navigator.push(context,MaterialPageRoute(builder: (context)=>SignInPage()));
                }).onError((error, stackTrace) {
                  Utils().toastMessage(error.toString());
                });
              },
              icon: Icon(Icons.logout_rounded)
          )
        ],
      ),
      body: Center(
        child: Text('Welcome to home screen'),
      ),
    );
  }
}
