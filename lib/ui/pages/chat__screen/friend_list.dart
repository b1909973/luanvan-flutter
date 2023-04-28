import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:social_video/models/message.dart';
import 'package:social_video/ui/pages/chat__screen/chat_screen1.dart';
import 'package:social_video/ui/pages/login/auth_manager.dart';
import 'package:social_video/ui/widgets/showLogin.dart';

class FriendListScreen1 extends StatefulWidget {
  @override
  State<FriendListScreen1> createState() => _FriendListScreen1State();
}

class _FriendListScreen1State extends State<FriendListScreen1> {
    String searchText = '';
 Widget _buildSearchBar() {
    final borderColor = Theme.of(context).dividerColor.withOpacity(0.6);
    final fillColor = Colors.grey.shade100;
    final hintTextStyle = TextStyle(color: Colors.white,fontStyle: FontStyle.italic);
    final textStyle = TextStyle(color: Colors.white);
    
    return TextField(
      
      decoration: InputDecoration(
        
        hintText: 'Tìm kiếm bạn bè',
        border: InputBorder.none,
        prefixIconColor: Colors.white,     
        prefixIcon: const Icon(Icons.search,color: Colors.white,),
        filled: true,
          
        hintStyle: hintTextStyle,
      ),
      style: textStyle,
      onChanged: (value) {
        setState(() {
          searchText = value;
        });
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Padding(

            padding: const EdgeInsets.symmetric(horizontal: 1),
            child: _buildSearchBar(),
          ),
          
     ),
      body: !context.read<AuthManager>().isAuth ? showLogin()  :  StreamBuilder(
        stream: FirebaseFirestore.instance.collection('users').doc((context.read<AuthManager>().authToken?.token)).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
     final List<dynamic> friendIds = (snapshot.data!.data() as Map<String, dynamic>)['following'] as List<dynamic>;
     final List<dynamic> followers = (snapshot.data!.data() as Map<String, dynamic>)['followers'] as List<dynamic>;
    // friendIds.removeWhere((element) => !followers.contains(element));
      final all = [...friendIds,...followers];
    //  print(' f ${friendIds}');
    //  print('a ${followers}');
     
          return friendIds.length==0 ? Container(
                child: Align(
                  child: Text("Tìm kiếm thêm mối quan hệ nào!", style: TextStyle(fontStyle: FontStyle.italic),),
                ),

          ) : StreamBuilder(
            stream: FirebaseFirestore.instance.collection('users').where(FieldPath.documentId, whereIn: all).snapshots(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              

              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              final friends = snapshot.data!.docs.map((DocumentSnapshot document) {
                return Friend(
                  id: document.id,
                  name: document['name'],
                  avatarImageUrl: document['photoURL'],
                );
              }).toList();
            //  final friendList = snapshot.data ?? [];
          final filteredFriendList = friends.where((friend) {
            final name = (friend.name ?? '').toLowerCase();
            final search = searchText.toLowerCase();
            return searchText.isEmpty || name.contains(search);
          }).toList();




              return ListView.builder(
                itemCount: filteredFriendList.length,
                itemBuilder: (BuildContext context, int index) {
                String conversationId ='';

                  return Column(
                    children: [
                       
                            ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(filteredFriendList[index].avatarImageUrl),
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(filteredFriendList[index].name,style: TextStyle(fontWeight: FontWeight.bold),),
                        StreamBuilder<QuerySnapshot>(
     stream:  FirebaseFirestore.instance.collection('conversations').where('members',whereIn: [[filteredFriendList[index].id,context.read<AuthManager>().authToken?.token],[context.read<AuthManager>().authToken?.token,filteredFriendList[index].id]])
    .limit(1)
    .snapshots()
     
     
     ,
     builder: (context, snapshot) {
       if (snapshot.hasError) {
        return Text('error');
        //  return Text('Gửi lời chào đến ${filteredFriendList[index].name} nào!',style: TextStyle(color: Colors.grey, fontStyle:FontStyle.italic ),);
       }

       if (snapshot.connectionState == ConnectionState.waiting) {
         return CircularProgressIndicator();
       }
          try {
             if (snapshot.data!.docs.isNotEmpty) {
        conversationId= snapshot.data?.docs[0]['cid'];
        print('--------------------');
        print('--------------------');

        print(conversationId);

         final lastMessage = snapshot.data?.docs[0];
    
         final lastMessageText = (lastMessage?.data() as Map<String,dynamic>)['messages']  as List<dynamic> ;
         if(lastMessageText.length!=0) // nếu không có tin nhắn, hiển thị hello
         return Text(Message.fromMap(lastMessageText.last).text,style: TextStyle(color: Colors.grey, fontStyle:FontStyle.italic ),);
         return Text('Gửi lời chào đến ${filteredFriendList[index].name} nào!',style: TextStyle(color: Colors.grey, fontStyle:FontStyle.italic ),);
        
       } else {

                return Text('Gửi lời chào đến ${filteredFriendList[index].name} nào!',style: TextStyle(color: Colors.grey, fontStyle:FontStyle.italic ),);

       }
          } catch (e) {
              return CircularProgressIndicator();
          }
     
     },
   )
                      ],
                    ),

                     onTap:  ()async {await _onFriendTap(context, filteredFriendList[index],conversationId);},
                  ),
                  
                            
                            Divider()
                    ],
                  );
                },
              );
            },
          );
        

        },
      ),
    );
  }

  Future<void> _onFriendTap(BuildContext context, Friend friend,String cid)async{
      if(cid!='')
        Navigator.of(context).push(MaterialPageRoute(

              builder: (_) => ChatScreen1(conversationId: cid),
            ));
        else{
        await  FirebaseFirestore.instance.collection('conversations').add({
              'members':[
                context.read<AuthManager>().authToken?.token,
                friend.id
              ],
              'messages':[],
              'timstamp':DateTime.now(),
              'totalMessages':0
          }).then((value){
            value.update({'cid':value.id});
            cid=value.id;
          });
        print('rong');    
     Navigator.of(context).push(MaterialPageRoute(

              builder: (_) => ChatScreen1(conversationId: cid),
            ));
         
        }
        
        
      
   
  }
}

class Friend {
  final String id;
  final String name;
  final String avatarImageUrl;

  Friend({
    required this.id,
    required this.name,
    required this.avatarImageUrl,
  });
}
