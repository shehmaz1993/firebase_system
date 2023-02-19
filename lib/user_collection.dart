import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
class UserModules extends StatefulWidget {
  const UserModules({Key? key}) : super(key: key);

  @override
  State<UserModules> createState() => _UserModulesState();
}

class _UserModulesState extends State<UserModules> {
  final ref=FirebaseDatabase.instance.ref('info');
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ref.onValue.listen((event) { 
      //print(event.snapshot.value.toString());
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: Column(
         children: [
             SizedBox(
               height: 300,
               width: double.infinity,
               child: FirebaseAnimatedList(
                   query: ref,
                   defaultChild: const Text('loading'),
                   itemBuilder: (context,snapshot,animation,index){
                        return Card(
                          child: ListTile(
                            title:Text(snapshot.child('designation').value.toString()) ,
                            subtitle:Text(snapshot.child('salary').value.toString()),
                            leading: Text(snapshot.child('id').value.toString()),
                          ),
                        );
                   }
               ),
             ),
             const SizedBox(height: 10,),
           //using stream builder
           Expanded(
               child:StreamBuilder(
                 stream: ref.onValue,
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
           )
         ],
       ),
    );
  }
}
