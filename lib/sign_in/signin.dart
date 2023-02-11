import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_implementation/utils/utils.dart';
import 'package:flutter/services.dart';

import 'package:flutter/material.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final List<Icon> iconsImage = [
    Icon(Icons.person),
    Icon(Icons.mail),
    Icon(Icons.phone_android),
    Icon(Icons.password_sharp)
  ];
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  bool showPassword=false;
  final _auth=FirebaseAuth.instance;
 // Repository repo=Repository();
  void logIn(){
   _auth.signInWithEmailAndPassword(
       email:emailController.text.toString() ,
       password:passwordController.text.toString()
   ).then((value) {
     print('user logging in');
   }).onError((error, stackTrace) {
     Utils().toastMessage(error.toString());
   });
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
    emailController.dispose();
    passwordController.dispose();
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

          passwordTextBox(),


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
                onPressed: () {
                     logIn();
                },
                child:const FittedBox(
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        'Sign In', style: TextStyle(color: Colors.white),),
                    )),
              ),
            ),
          ),
          const SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.only(left:68.0,right: 68.0,top: 20.0),
            child: Row(
              children: [
                GestureDetector(
                    onTap: (){},
                    child: Text('Forgot password?',style: TextStyle(color: Colors.lightBlue),)

                ),
                SizedBox(width: 10,),
                GestureDetector(
                    onTap:(){
                    //  Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignUpPage()));
                    },
                    child: Text('create account!',style: TextStyle(color: Colors.lightBlue),))
              ],
            ),
          )



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
              controller: emailController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(

                  icon: iconsImage[2],
                  //iconColor: Colors.white,
                  hintText: 'Email....',
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
  Widget passwordTextBox(){
    //final infoOfSignIn  = Provider.of<SignInInfo>(context);
    return  Padding(
      padding: const EdgeInsets.only(left:22.0,top:18.0,bottom: 0.0,right: 22.0),
      child: Container(
        width:266, //266.0,
        height:48.0, //48.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24.0),
          // color: const Color(0xffe7ebee),
          border: Border.all(
              width: 2.0,
              color:  Colors.lightBlue.shade300
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left:18.0),
          child: TextField(
            controller: passwordController,
            obscureText: showPassword==false?true:false,
            decoration:  InputDecoration(
                icon: iconsImage[3],
                hintText:'password....',

                suffixIcon: IconButton(
                  onPressed: (){
                    if(showPassword==false){
                      setState(() {
                        showPassword=true;
                      });
                    }
                    else{
                      setState(() {
                        showPassword=false;
                      });
                    }

                  },
                  icon:showPassword==true? Icon(Icons.visibility,color: Colors.grey,):Icon(Icons.visibility_off,color: Colors.grey,),
                ),
                border: InputBorder.none


              // labelText: hint,
            ),

          //  onChanged:infoOfSignIn.setPassword,
           // onSubmitted:infoOfSignIn.setPassword,

          ),
        ),
      ),
    );
  }
}
