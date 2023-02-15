import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_implementation/sign_in/verifycode.dart';
import 'package:firebase_implementation/utils/utils.dart';
import 'package:flutter/services.dart';

import 'package:flutter/material.dart';

import '../HomePage.dart';
import '../sign_up/signup.dart';

class SignInWithPhone extends StatefulWidget {
  const SignInWithPhone({Key? key}) : super(key: key);

  @override
  State<SignInWithPhone> createState() => _SignInWithPhoneState();
}

class _SignInWithPhoneState extends State<SignInWithPhone> {
  final List<Icon> iconsImage = [
    Icon(Icons.person),
    Icon(Icons.mail),
    Icon(Icons.phone_android),
    Icon(Icons.password_sharp)
  ];
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();
  bool showPassword=false;
  final _auth=FirebaseAuth.instance;
  // Repository repo=Repository();
  void verifyPhoneNumber(){
    _auth.verifyPhoneNumber(
        phoneNumber:'+88${phoneController.text.toString()}' ,
        verificationCompleted:(_){

        },
        verificationFailed: (message){
          Utils().toastMessage(message.toString());
        },
        codeSent: (String code,int? token){
          Navigator.push(context, MaterialPageRoute(builder:(context)=>VerifyCode(code:code)));

        },
        codeAutoRetrievalTimeout: (e){
          Utils().toastMessage(e.toString());
        }
    );

  }

  @override
  void initState() {
    //  final SignInInfo infoOfSignIn = Provider.of<SignInInfo>(context, listen: false);
    // TODO: implement initState
    super.initState();
    // phoneNumberController=TextEditingController(text: infoOfSignIn.phoneNumber);
    // passwordController=TextEditingController(text: infoOfSignIn.password);

  }
  @override
  void dispose() {
    phoneController.dispose();
   // passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      body: ListView(
        children: [
          const SizedBox(
            width: double.infinity,
            height: 150,
            // color: Colors.blue,

          ),

          phoneNumberTextBox(),
          Padding(
            padding: const EdgeInsets.only(
                left: 22.0, top: 38.0, bottom: 0.0, right: 22.0),
            child: Container(
              width: 266, //266.0,
              height: 48.0, //48.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24.0),
                color: Colors.lightBlue.shade500,
              ),
              child:  MaterialButton(
                onPressed: ()  {
                   verifyPhoneNumber();
                },
                child:const FittedBox(
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        'Verify', style: TextStyle(color: Colors.white),),
                    )),
              ),
            ),
          ),








        ],
      ),

    );
  }
  Widget phoneNumberTextBox() {
    //final infoOfSignIn  = Provider.of<SignInInfo>(context);
    return Padding(
      padding: const EdgeInsets.only(
          left: 22.0, top: 18.0, bottom: 0.0, right: 22.0),
      child: Container(
        width: 266, //266.0,
        height: 48.0, //48.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24.0),
          // color: const Color(0xffe7ebee),
          border: Border.all(
              width: 2.0,
              color:Colors.lightBlue.shade300
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 18.0),
          child: TextField(
            //style:TextStyle(color: Colors.white)  ,
            controller: phoneController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(

                icon: iconsImage[2],
                //iconColor: Colors.white,
                hintText: '019XXXX...',
                // hintStyle:TextStyle(color: Colors.white) ,

                border: InputBorder.none
              // labelText: hint,
            ),

            //   onChanged: infoOfSignIn.setPhoneNumber,
            //  onSubmitted: infoOfSignIn.setPhoneNumber

          ),
        ),
      ),
    );
  }

}
