import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_implementation/HomePage.dart';
import 'package:firebase_implementation/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class AddData extends StatefulWidget {
  const AddData({Key? key}) : super(key: key);

  @override
  State<AddData> createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  final data=FirebaseDatabase.instance.ref('info');
  var idController = TextEditingController();
  var designationController = TextEditingController();
  var salaryController = TextEditingController();
  var editController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: ElevatedButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeScreen()));
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
             /*Padding(
               padding: const EdgeInsets.all(8.0),
               child: TextField(
                controller: idController,
                decoration: const InputDecoration(
                  hintText: 'Enter  Id',
                  border: OutlineInputBorder()
                ),
            ),
             ),*/
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
                    data.child(id).set(
                       {
                         'id': id,
                         'designation':designationController.text.toString(),
                         'salary':salaryController.text.toString(),
                       }
                    ).then((value){
                      Utils().toastMessage('information added');
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
                    data.child(id).update({
                      'designation':editController.text.toLowerCase()
                    }).then((value){
                      Utils().toastMessage('designation changed');
                    }).onError((error, stackTrace){
                        Utils().toastMessage(error.toString());
                    });
                  },
                  child:const Text('update')
              ),
            ],
          );
        }
    );
  }
}
