
import 'package:flutter/material.dart';
import 'package:social_video/models/conversations.dart';
import 'package:social_video/models/user.dart';

import 'package:provider/provider.dart';
import 'package:social_video/ui/pages/login/auth_manager.dart';


class ChatDetailScreen extends StatefulWidget{
      Map<Users,Conversations> conversations;
       Users you ;
   Users im ;

   ChatDetailScreen({super.key,required this.conversations,required this.im}): you=conversations.keys.toList()[0];

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
 
  @override
  void initState() {
  

    super.initState();
  }
    @override
  Widget build(BuildContext context) {
    
    return Scaffold(
         appBar: AppBar(
        
          actions: [
            GestureDetector(
              child: Icon(Icons.call),
              onTap: () {
                print('Call');
              },
            )
            ,
            Icon(Icons.video_call_outlined),
            SizedBox(width: 14,),
            Icon(Icons.more_horiz),
            SizedBox(width: 10,)
          ],
          title:Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:const <Widget> [
                  Text('London chat',
                  style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                )
            
            ,)],
          )
          
          
        ),

        body: Container(
            padding: const EdgeInsets.all(16),
                constraints:const BoxConstraints.expand(
                  width: double.infinity
                ),
            child: Column(
              children: [
               Expanded(child: ListView.builder(itemBuilder: (context, index) {
                if( widget.conversations.values.toList()[0].message[index].senderId== widget.im.id )
                  return chatContent(widget.conversations.values.toList()[0].message[index].text);
                  return chatMyContent(widget.conversations.values.toList()[0].message[index].text);
                  
               } ,

            itemCount: widget.conversations.values.toList()[0].message.length)),

                   Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              constraints: BoxConstraints.expand( 
                  height: 50,
                  width: double.infinity
              ),
              decoration: BoxDecoration(
                // color: Colors.amber
              ),
              child: Row(
                children: [
                  Icon(Icons.camera_alt),
                   const SizedBox(width: 6,),
                   Icon(Icons.keyboard_voice_outlined)
                  ,
                  Expanded(child: TextField(
                    
                    
                       decoration: InputDecoration(
                        filled: true,
                      fillColor: Color.fromARGB(255, 237, 236, 230), 
                      border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(60.0),
                    borderSide: BorderSide.none
                    
                  ),
                      hintText: 'Please enter a search term',
                      
  ),
                  ),
                  
                  ),
                  const SizedBox(width: 20,)
                  ,
                  Icon(Icons.play_arrow),
                  const SizedBox(width: 6,)

                ],
              ),
            )

              ],
            ),
        ),
    );
    
  }

   Widget chatContent(String text){
    return   Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
      margin: EdgeInsets.only(bottom: 8),
      child: Row(
                        children: [
                          
                         const  CircleAvatar(
                                  backgroundImage: NetworkImage('https://picsum.photos/id/237/200/300'),
                                    radius: 20,
                                    
                                ),
                                SizedBox(width: 20,)
                                ,
                                Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(10)
                                  ),
                                  constraints: const BoxConstraints(
                                    minHeight: 40,
                                    
                                    maxWidth: 200

                                   
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                    
                                        Text('${text}',
                                          style: TextStyle(
                                           
                                              fontSize: 14
                                          ),
                                        )
                                    ],
                                  )
                                )
                        ],
                      )
    );
  }

  Widget chatMyContent(String text){
    return   Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
      margin: EdgeInsets.only(bottom: 8),
      child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
        
                        children: [
                           Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(

                                    color: Color.fromARGB(255, 72, 167, 245),
                                    borderRadius: BorderRadius.circular(10)
                                  ),
                                  constraints: const BoxConstraints(
                                    minHeight: 40,
                                    
                                    maxWidth: 200

                                   
                                  ),

                                  
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                    
                                        Text('${text}',
                                          style: TextStyle(
                                           
                                              fontSize: 14,
                                              color: Colors.white
                                          ),
                                        )
                                    ],
                                  )
                                ),SizedBox(width: 20,)
                                
                          ,
                         const  CircleAvatar(
                                  backgroundImage: NetworkImage('https://picsum.photos/id/237/200/300'),
                                    radius: 20,
                                    
                                ),
                                
                               
                        ],
                      )
    );
  }
}