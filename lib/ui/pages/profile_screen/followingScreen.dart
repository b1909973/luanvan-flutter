


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_video/models/user.dart';
import 'package:social_video/ui/pages/detail_screen/video_grids_detail.dart';
import 'package:social_video/ui/pages/discover_screen/search_manager.dart';
import 'package:social_video/ui/pages/discover_screen/video_search_grids_detail.dart';
import 'package:social_video/ui/pages/login/auth_manager.dart';
import 'package:social_video/ui/pages/profile_screen/profile_screen1.dart';
import 'package:social_video/ui/pages/video_manager.dart';
import 'package:video_player/video_player.dart';

class FollowingScreen extends StatefulWidget{
   FollowingScreen({super.key});

  @override
  State<FollowingScreen> createState() => _FollowingScreenState();
}

class _FollowingScreenState extends State<FollowingScreen> {
       late Future<void> _fetchFollower;

    void initState(){
      super.initState();
      print('aaaaaaa');
      _fetchFollower = context.read<SearchManager>().fetchFriend(context.read<AuthManager>().authToken!.user.Following!,context.read<AuthManager>().authToken!.token!);
    }

    @override
    Widget build(BuildContext context) {


      return  Scaffold(

        appBar: AppBar(title: Text('Following'),
        backgroundColor: Colors.red,
        ),
        body: SafeArea(child: FutureBuilder(
                  future: _fetchFollower,
                  builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                
                  return   buildList();
                  
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
                  ) )
      ,
      );
      
      
    
    }
    Widget buildList(){
      return   
      SingleChildScrollView(
       
              
              child:  Consumer<SearchManager>(
              builder: (context, searchManager, child){
                
                  return    Column(
          children: [

           

              SizedBox(height: 6,),

          
                          
                          // Divider(color: Colors.black26,),
          SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Container(padding: EdgeInsets.symmetric(horizontal: 12),
      child: buildListSearchUser(searchManager)
      ),
     ),
  
   

              
          ],
        );





         



              })
              
              

     
      );
    }


       Widget buildListSearchUser( SearchManager searchManager){
        return  Expanded(child: ListView.separated(itemBuilder: (context, index) =>   GestureDetector(
                child: buildUser(searchManager.friend[index]),
                onTap: (() =>{
                    Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>   ProfileScreenPeople(user: searchManager.friend[index]),
                                ),
                              )
                    
             
                }
                
                ),
               )
        , separatorBuilder: (context, index) => const SizedBox(height: 14,), itemCount: searchManager.friend.length));
     
    }


    Widget buildUser(Users user){
  return    Row(
              children: [
                  CircleAvatar(
                  backgroundImage: NetworkImage(user.PhotoURL!),
                  radius: 36,
                ),
                const SizedBox(width: 16,)
                ,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start  ,
                  children: [
                    Text('${user.name}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                    ),
                    ),
                  
                    Text(user.nickname!,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey
                    ),
                    ),
                     Text('${user.Follower?.length} Follower',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey
                    ),
                    )
                  ],
                )
              ],
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
                  radius: 36,
                ),
                );
      }
   
}