import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
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
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      bottomSheet: MaterialButton(
                     onPressed: () {

                     },
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
      body: Column(
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
              height: 300,
              width: double.infinity,
              child: FirebaseAnimatedList(
                  query: ref,
                  defaultChild: const Text('loading'),
                  itemBuilder: (context,snapshot,animation,index){
                    String title=snapshot.child('designation').value.toString();
                    if(steamController.text.isEmpty){
                      return Card(
                        child: ListTile(
                          title:Text(snapshot.child('designation').value.toString()) ,
                          subtitle:Text(snapshot.child('salary').value.toString()),
                          leading: Text(snapshot.child('id').value.toString()),
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
}
