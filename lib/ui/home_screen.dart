import 'package:flutter/material.dart';
import 'package:social_video/ui/pages/chat__screen/chat__detail__screen.dart';
import 'package:social_video/ui/pages/chat__screen/chat__screen.dart';
import 'package:social_video/ui/pages/chat__screen/chat_screen1.dart';
import 'package:social_video/ui/pages/chat__screen/friend_list.dart';
import 'package:social_video/ui/pages/discover_screen/discover_screen.dart';
import 'package:social_video/ui/pages/feed_screen/feed_screen.dart';
import 'package:social_video/ui/pages/inbox_screen.dart';
import 'package:social_video/ui/pages/notification/notification_screen.dart';
import 'package:social_video/ui/pages/post_video/post_video_screen.dart';
import 'package:social_video/ui/pages/profile_screen/profile_screen.dart';
import 'package:social_video/ui/pages/profile_screen/profile_screen1.dart';
import 'pages/friends__screen/friends_screen.dart';


class HomeScreen extends StatefulWidget{
  static const routeName ='/home';

    const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  
    int _i=0;

     List<Widget> pages = [
         FeedScreen(),
DiscoverScreen()
,        PostVideoScreen(),
FriendListScreen1(),
// ChatScreen(),
        // ChatScreen1(conversationId: 'e7bb57d4-5082-cbf1-420f-6b33e95e1ab6'),
      // NotificationScreen(),

        ProfileScreen(),

      ];

      void _onIconTapped(int index){
        setState(() {
          _i = index;
        });
      }
    @override
  Widget build(BuildContext context) {
    print(_i);
    
      return Scaffold(

            body: SafeArea(child: Container(
              child:pages[_i]
            ),),

            bottomNavigationBar: getFooter()


      );
    
  }

   Widget getFooter() {
    return BottomNavigationBar(
      backgroundColor: Colors.black
      ,
      type: BottomNavigationBarType.fixed,

      // backgroundColor: Colors.red

      showUnselectedLabels: false,
      currentIndex: _i,
      onTap: (value) => setState(() {
        _i = value;
      }),
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home,color:Colors.white), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.search,color:Colors.white), label: 'Discover'),
        BottomNavigationBarItem(
          icon:getIconSocial(),
          label: ''
        ),
        BottomNavigationBarItem(icon: Icon(Icons.chat,color:Colors.white), label: 'Chat'),

        BottomNavigationBarItem(icon: Icon(Icons.person,color:Colors.white), label: 'Profile'),
      ],
    );
  }

  Widget getIconSocial(){
    return Container(
            height: 40,
          width: 52
            ,
            child: Stack(children: [

              
              Positioned(child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft:Radius.circular(20)
                    ,bottomLeft: Radius.circular(20),
                    
                     ),
                color: Colors.blue,

                )
                ,
                constraints: BoxConstraints.expand(
                  height: 36,
                  width: 10
                ),
                
              ),
              left: 0,
              )
              ,
         
            
               Positioned(child: Container(
                 decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight:Radius.circular(20)
                    ,bottomRight: Radius.circular(20) ),
                color: Colors.red,

                ),
                constraints: BoxConstraints.expand(
                  height: 36,
                  width: 10
                ),
                
              ),
              right: 0,
              ),
                 Positioned(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                color: Colors.white,

                  ),
                constraints: BoxConstraints.expand(
                  height: 36,
                  width: 44
                ),

              child:Icon(Icons.add,color: Colors.black,size: 30,) ,
                
              ),
              left: 4,
              )
              
              ,
            ],
            )

          );
  }
}