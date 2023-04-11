import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_implementation/add_post.dart';
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
  final ref=FirebaseDatabase.instance.ref('info');
  var steamController=TextEditingController();
  var editController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    // Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddData()));
    return  Scaffold(
       floatingActionButton: ElevatedButton(
           onPressed: () {
             Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddData()));
           },
           style: ElevatedButton.styleFrom(
             fixedSize: const Size(20, 20),
             shape: const CircleBorder(),
           ),
           child:const Icon(Icons.add)
       ),
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
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: steamController,
              decoration: const InputDecoration(
                hintText: 'search',
                border: OutlineInputBorder()
              ),
              onChanged: (String value){
                setState(() {

                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 800,
              width: double.infinity,
              child: FirebaseAnimatedList(
                  query: ref,
                  defaultChild: const Text('loading'),
                  itemBuilder: (context,snapshot,animation,index){
                    String title=snapshot.child('designation').value.toString();
                    String  id=DateTime.now().microsecondsSinceEpoch.toString();
                    if(steamController.text.isEmpty){
                      return Card(
                        child: ListTile(
                          title:Text(snapshot.child('designation').value.toString()) ,
                          subtitle:Text(snapshot.child('salary').value.toString()),
                          leading: Text(snapshot.child('id').value.toString()),
                          trailing: PopupMenuButton(
                            icon: const Icon(Icons.more_vert),
                            itemBuilder: (BuildContext context)=>[
                               PopupMenuItem(
                                   value: 1,
                                  child: ListTile(
                                    onTap: (){
                                      Navigator.pop(context);
                                      showMyDialog(title, id);

                                    },
                                    leading: const Icon(Icons.edit),
                                    title: const Text('Edit'),
                                  )
                              ),
                               PopupMenuItem(
                                   value:1,
                                  child: ListTile(
                                    onTap: (){
                                      Navigator.pop(context);
                                      ref.child(snapshot.child('id').value.toString()).remove();
                                    },
                                    leading: const Icon(Icons.delete),
                                    title: const Text('Delete'),
                                  )
                              )
                            ] ),
                        ),
                      );

                    }else if(title.toLowerCase().contains(steamController.text.toLowerCase().toString())){
                      return Card(
                        child: ListTile(
                          title:Text(snapshot.child('designation').value.toString()) ,
                          subtitle:Text(snapshot.child('salary').value.toString()),
                          leading: Text(snapshot.child('id').value.toString()),
                        ),
                      );

                    }
                    else{
                         return Container();
                    }

                  }
              ),
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
                    ref.child(id).update({
                      'designation':editController.text

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
