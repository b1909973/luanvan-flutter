import 'package:flutter/material.dart';
import 'package:social_video/models/conversations.dart';
import 'package:social_video/models/user.dart';
import 'package:social_video/ui/pages/chat__screen/chat__detail__screen.dart';
import 'package:social_video/ui/pages/chat__screen/chat_manager.dart';
import 'package:provider/provider.dart';
import 'package:social_video/ui/pages/login/auth_manager.dart';


class ChatGrids extends StatelessWidget{

      ChatGrids();


    Widget build(BuildContext context){

        return Consumer<ChatManager>(
              builder: (context, chatManager, child) {
              return  Container(
          margin: EdgeInsets.only(left: 20)
          ,
            child: 
            buildListInboxFriends(chatManager)

              );
              },


        );

    }


    Widget buildListInboxFriends(ChatManager chatManager){
      print('11111111111111111111111111111111111111111111111111111111');
  
        return 
        
        
          ListView.separated(itemBuilder: (context, index) =>   GestureDetector(
                child: buildInboxFriend(chatManager.users[index]),
                onTap: ((){
                  print('aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa');
                 

                   Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ChatDetailScreen(conversations: chatManager.users[index],im:( context.read<AuthManager>().authToken?.user)!,)),
                    );
                }
                
                ),
               )
        , separatorBuilder: (context, index) => const SizedBox(height: 14,), itemCount: chatManager.users.length);
     
    }
Widget buildInboxFriend(Map<Users,Conversations> user){
  return    Row(
              children: [
                 CircleAvatar(
                  backgroundImage: NetworkImage(user.keys.toList()[0].PhotoURL!),
                  radius: 36,
                ),
                const SizedBox(width: 16,)
                ,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start  ,
                  children: [
                    Text(user.keys.toList()[0].name,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                    ),
                    ),
                    SizedBox(height: 8,
                    
                    ),
                    user.values.toList()[0]!=null ? 
                    Text(user.values.toList()[0].message.last.text,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                      fontStyle: FontStyle.italic
                    ),
                    )
                    
                    
                     : Text('Gửi lời chào đến ${user.keys.toList()[0].name} nào!',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                      fontStyle: FontStyle.italic
                    ),
                    )
                  ],
                )
              ],
            );
}

Widget buildListFriends(){
  return  Container(
                padding: EdgeInsets.only(top: 8),
                decoration: const BoxDecoration(
                  // color: Colors.amber
                )
                ,
                constraints:const BoxConstraints.expand(
                  height: 100,
                  width: double.infinity
                
                ),
                child:   ListView.separated(
              scrollDirection: Axis.horizontal,
             itemCount: 8,
             itemBuilder: (context, index) {
               return
               GestureDetector(
                child: buildFriend(),
                onTap: (() => print(index)),
               );
             },
             separatorBuilder: (context, index) {
               return const SizedBox(width: 20,);
             },
          
            ),
              );
}

Widget buildFriend(){
  return  Column(
              children:const [
                CircleAvatar(
                  backgroundImage: NetworkImage('https://picsum.photos/id/237/200/300'),
                  radius: 36,
                ),
                SizedBox(height: 4,)
                ,
                Text('Lena')
              ],
            );
}

}