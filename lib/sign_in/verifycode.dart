import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_implementation/HomePage.dart';
import 'package:firebase_implementation/utils/utils.dart';
import 'package:flutter/material.dart';
class VerifyCode extends StatefulWidget {
  final String code;
  const VerifyCode({Key? key,required this.code}) : super(key: key);

  @override
  State<VerifyCode> createState() => _VerifyCodeState();
}

class _VerifyCodeState extends State<VerifyCode> {
  var codeController = TextEditingController();
  final _auth=FirebaseAuth.instance;
  Future<void> verifyWithCode() async {

    final credential=PhoneAuthProvider.credential(
        verificationId:widget.code,
        smsCode: codeController.text
    );
    try{
      await _auth.signInWithCredential(credential);
      Navigator.push(context, MaterialPageRoute(builder:(context)=>HomeScreen()));
    }
    catch(e){
      Utils().toastMessage(e.toString());
    }

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
    codeController.dispose();
    // passwordController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: ListView(
        children: [
          const SizedBox(
            width: double.infinity,
            height: 150,
            // color: Colors.blue,

          ),

          codeNumberTextBox(),
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
                   verifyWithCode();
                },
                child:const FittedBox(
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        'Log in', style: TextStyle(color: Colors.white),),
                    )),
              ),
            ),
          ),

        ],
      ),

    );
  }

  Widget codeNumberTextBox() {
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
            controller: codeController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(

                hintText: 'Enter code',
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
