import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:social_video/ui/pages/login/auth_manager.dart';
import 'package:provider/provider.dart';

class NotificationScreen extends StatefulWidget {
      static const routeName ='/notification';

  // final String userId;
  // NotificationScreen({@required this.userId});

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  // late Stream<QuerySnapshot> _notificationStream;

  // @override
  // void initState() {
  //   super.initState();
  //   _notificationStream = FirebaseFirestore.instance
  //       .collection('notifications')
  //        .where('receiverId', isEqualTo: context.read<AuthManager>)
  //       // .orderBy('timestamp', descending: true)
  //       .snapshots();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('Thông báo'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
        .collection('notifications')
         .where('receiverId', isEqualTo: context.read<AuthManager>().authToken!.token).where('type',isEqualTo: 'follow')
      
        .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error'));
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No notifications.'));
          }else{
            print('11111111111111111111111');
            // print(snapshot.data!.docs[1]['receiverId']);
            // print('11111111111111111111111');
               return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder:  (BuildContext context, int index)  {
                final document = snapshot.data!.docs[index];
                final senderId = document['senderId'];
                final id = document['nid'];
                
                print('11111111111111111111111111111111111111111111111111');
                   print('length ${snapshot.data!.docs.length}');  
                print('11111111111111111111111111111111111111111111111111');
    // return FutureBuilder(builder:
              // getUser(senderId);
    
    //  )
      return Column(
        children: [
          FutureBuilder(
          future: FirebaseFirestore.instance.collection('users').where('uid',isEqualTo: senderId).get(),

          builder: (context, snapshot1) {
            print('aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa');
            if (snapshot1.hasError) return Text('Error = ${snapshot1.error}');
          if (snapshot1.connectionState == ConnectionState.waiting) {
            return const Text("Loading");
          }else
          print('aaa ${ snapshot1.data!.docs[0]['name']}');
         
             return ListTile(
              title: Row(
                children: [
                  Text('${ snapshot1.data!.docs[0]['name']} ',style: TextStyle(fontWeight: FontWeight.bold),),
                  Text('is folowing you',style: TextStyle(fontStyle: FontStyle.italic),),

                  
                ],
              ),
              leading: CustomCircleAvatar(60, snapshot1.data!.docs[0]['photoURL']),
              subtitle: Text('${(document['timestamp'] as Timestamp).toDate()}'),
                );
          },


       ),
            Divider()
        ],
      );

              
              },
            );
          }

          //  else {
       
          // }
        },
      ),
    );
  }
Widget CustomCircleAvatar(double size,String? avatar){
       
        return   Container(
                    constraints: BoxConstraints.expand(
                      height: size,
                      width: size
                    )
                  ,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.all(Radius.circular(size)),
                    border: Border.all(width: 2,color: Colors.white)
                  ),
                  child:       CircleAvatar(
                  backgroundImage: NetworkImage(avatar!),
                  radius: size,
                ),
                );
      }
  Future getUser(String senderId) async{
   return  await  FirebaseFirestore.instance.collection('users').where('uid',isEqualTo:senderId).get().then((QuerySnapshot querySnapshot) {
                    print(querySnapshot.docs);
                        //  return querySnapshot.docs[0];
                  })
                  ;
  }




}
