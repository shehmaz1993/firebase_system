import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_implementation/firestore/add_firestore_data.dart';
import 'package:flutter/material.dart';

import '../add_post.dart';
import '../sign_in/signin.dart';
import '../utils/utils.dart';
class FireBaseStoreScreen extends StatefulWidget {
  const FireBaseStoreScreen({Key? key}) : super(key: key);

  @override
  State<FireBaseStoreScreen> createState() => _FireBaseStoreScreenState();
}

class _FireBaseStoreScreenState extends State<FireBaseStoreScreen> {
  final firestore=FirebaseFirestore.instance.collection('users').snapshots();
  var steamController=TextEditingController();
  var editController=TextEditingController();
  CollectionReference ref =FirebaseFirestore.instance.collection('users');
  @override
  Widget build(BuildContext context) {
    // Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddData()));
    return  Scaffold(
      floatingActionButton: ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddDataToFireStore()));
          },
          style: ElevatedButton.styleFrom(
            fixedSize: const Size(20, 20),
            shape: const CircleBorder(),
          ),
          child:const Icon(Icons.add)
      ),
      appBar: AppBar(
        title: const Text('Firestore User list Screen'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: (){
                //AddDataToFireStore
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddDataToFireStore()));

              },
              icon: const Icon(Icons.logout_rounded)
          )
        ],
      ),
      body: ListView(
        children: [
          /*StreamBuilder<QuerySnapshot>(
              stream: firestore,
              builder: (BuildContext context ,AsyncSnapshot<QuerySnapshot> snapshot){
                if(snapshot.connectionState==ConnectionState.waiting)
                  return CircularProgressIndicator();
                if(snapshot.hasError)
                  return Text('Something is error');
                return Expanded(
                  child:ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context,index){
                        return ListTile(
                          title:Text(snapshot.data!.docs[index]['name'].toString()) ,
                          subtitle:Text(snapshot.data!.docs[index]['designation'].toString()),
                          leading: Text(snapshot.data!.docs[index]['id'].toString()),
                        );
                      }),
                );


              }),*/


          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 800,
              width: double.infinity,
              child:StreamBuilder<QuerySnapshot>(
                  stream: firestore,
                  builder: (BuildContext context ,AsyncSnapshot<QuerySnapshot> snapshot){
                    if(snapshot.connectionState==ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    }
                    if(snapshot.hasError) {
                      return Text('Something is error');
                    }
                    return Expanded(
                      child:ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context,index){
                            return SizedBox(
                              height: 70,
                              width: 150,
                              child: ListTile(
                                onTap: (){
                                 /* ref.doc(snapshot.data!.docs[index]['id'].toString()).update({
                                    'salary':'30000/-'
                                  });*/
                                  ref.doc(snapshot.data!.docs[index]['id'].toString()).delete();
                                },
                                title:Text(snapshot.data!.docs[index]['name'].toString()) ,
                                subtitle:Text(snapshot.data!.docs[index]['designation'].toString()),
                               // leading: Text(snapshot.data!.docs[index]['id'].toString()),
                                trailing: Text(snapshot.data!.docs[index]['salary'].toString())
                              ),
                            );
                          }),
                    );


                  }),
            ),
          ),
          const SizedBox(height: 10,),

          //using stream builder
          /* Expanded(
              child:StreamBuilder(
                stream: ref.onValue!,
                builder: (BuildContext context, AsyncSnapshot<DatabaseEvent> snapshot) {

                  return ListView.builder(
                      itemCount: snapshot.data!.snapshot.children.length,
                      itemBuilder: (context,index){
                        if(snapshot.hasData){
                          Map<dynamic,dynamic> map=snapshot.data!.snapshot.value as dynamic;
                          List<dynamic> list=[];
                          list.clear();
                          list=map.values.toList();
                          return Card(
                            child: ListTile(
                              title: Text(list[index]['designation']),
                              subtitle: Text(list[index]['salary']),
                              leading: Text(list[index]['id']),
                            ),
                          );
                        }
                        else{
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      }
                  );
                },

              )
          )*/
        ],
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
            content: TextField(
              controller: editController,
              decoration: const InputDecoration(
                  hintText: 'Edit'
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
