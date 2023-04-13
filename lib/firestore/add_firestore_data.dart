import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_implementation/HomePage.dart';
import 'package:firebase_implementation/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'firestore_list_screen.dart';
class AddDataToFireStore extends StatefulWidget {
  const AddDataToFireStore({Key? key}) : super(key: key);

  @override
  State<AddDataToFireStore> createState() => _AddDataToFireStoreState();
}

class _AddDataToFireStoreState extends State<AddDataToFireStore> {
  final firestore=FirebaseFirestore.instance.collection('users');
  var nameController = TextEditingController();
  var designationController = TextEditingController();
  var salaryController = TextEditingController();
  var editController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => FireBaseStoreScreen()));
          },
          style: ElevatedButton.styleFrom(
            fixedSize: const Size(20, 20),
            shape: const CircleBorder(),
          ),
          child:const Icon(Icons.arrow_circle_down_rounded)
      ),

      appBar: AppBar(
        title: const Text('Add information'),
        centerTitle: true,
      ),
      body: Scaffold(
        body: Column(
          children: [
            // const SizedBox(height: 30,),
            Padding(
               padding: const EdgeInsets.all(8.0),
               child: TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  hintText: 'Enter name',
                  border: OutlineInputBorder()
                ),
            ),
             ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: designationController,
                decoration: const InputDecoration(
                    hintText: 'Enter designation',
                    border: OutlineInputBorder()
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: salaryController,
                decoration: const InputDecoration(
                    hintText: 'current salary',
                    border: OutlineInputBorder()
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: CupertinoButton(
                  color: Colors.red,
                  child: const Text('Add to Database'),
                  onPressed:(){
                    String id=DateTime.now().microsecondsSinceEpoch.toString();
                    firestore.doc(id).set({
                      'id': id,
                      'name':nameController.text.toString(),
                      'designation':designationController.text.toString(),
                      'salary' : salaryController.text.toString()


                    }).then((value){
                      Utils().toastMessage('${nameController.text.toString()} has been added');
                    }).onError((error, stackTrace){
                       Utils().toastMessage(error.toString());
                    });

                  }),
            )


          ],
        ),

      ),
    );
  }
  Future showMyDialog(String title,String id){
    editController.text=title;
    return showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title: const Text('Update'),
            content: Container(
              child: TextField(
                controller: editController,
                decoration: InputDecoration(
                    hintText: 'Edit'
                ),
              ),
            ),
            actions: [
              TextButton(
                  onPressed:(){
                    Navigator.pop(context);
                  },
                  child:const Text('cancel')
              ),
              TextButton(
                  onPressed:(){
                    Navigator.pop(context);

                  },
                  child:const Text('update')
              ),
            ],
          );
        }
    );
  }
}
