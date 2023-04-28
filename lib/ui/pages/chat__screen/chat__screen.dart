import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:social_video/ui/pages/chat__screen/chat__detail__screen.dart';
import 'package:social_video/ui/pages/chat__screen/chat_grids.dart';
import 'package:social_video/ui/pages/chat__screen/chat_manager.dart';
import 'package:provider/provider.dart';
import 'package:social_video/ui/pages/login/auth_manager.dart';
import 'package:social_video/ui/widgets/showLogin.dart';

class ChatScreen extends StatefulWidget{

    const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

       late Future<void> _fetchUsers;

    void initState(){
      super.initState();
      print('aaaaaaa');
      if(context.read<AuthManager>().isAuth)
       _fetchUsers = context.read<ChatManager>().fetchUserss((context.read<AuthManager>().authToken?.user.Following)!,(context.read<AuthManager>().authToken?.token)!);
    }



    Widget build(BuildContext context){
           return  Scaffold(
        appBar: AppBar(title:Row(
            mainAxisAlignment: MainAxisAlignment.center,
children: [
  Text('Chat',style: TextStyle(color: Colors.blueAccent))
],

        )
        
        ,backgroundColor: Colors.white,),


        body: context.read<AuthManager>().isAuth ? FutureBuilder(
                  future: _fetchUsers,
                  builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                
                  return   ChatGrids();
                  
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                
                  return  const Center(
                  child: CircularProgressIndicator(),
                  );
                  
                  }
                  return const Center(
                  child: CircularProgressIndicator(),
                  );
                  },
                  ) : showLogin()
           ) ;
        


    }
}