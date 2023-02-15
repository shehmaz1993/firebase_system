import 'package:firebase_database/firebase_database.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add information'),
        centerTitle: true,
      ),
      body: Scaffold(
        body: Column(
          children: [
            const SizedBox(height: 30,),
             Padding(
               padding: const EdgeInsets.all(8.0),
               child: TextField(
                controller: idController,
                decoration: const InputDecoration(
                  hintText: 'Enter  Id',
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
                    data.child(DateTime.now().microsecondsSinceEpoch.toString()).set(
                       {
                         'id': idController.text.toString(),
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
}
