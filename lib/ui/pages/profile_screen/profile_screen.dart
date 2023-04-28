

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social_video/models/auth.dart';
import 'package:social_video/models/user.dart';
import 'package:social_video/services/video.dart';
import 'package:social_video/ui/pages/login/auth_manager.dart';
import 'package:social_video/ui/pages/login/login_number.dart';
import 'package:social_video/ui/pages/profile_screen/setting_profile.dart';
import 'package:social_video/ui/pages/video_manager.dart';
import 'package:social_video/ui/widgets/showLogin.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;
class ProfileScreen extends StatelessWidget{

    const ProfileScreen({super.key});

    
    @override
    Widget build(BuildContext context) {
     
      // print(user);
      return  Scaffold(
        appBar: AppBar(
        actions: [
      !context.read<AuthManager>().isAuth ?  Text(''):   IconButton(onPressed: ()async {

                Navigator.of(context).pushNamed('/notification');
           await   FirebaseFirestore.instance.collection('notifications').where('isRead',isEqualTo: false)
               .where('receiverId',isEqualTo: context.read<AuthManager>().authToken!.token).get().then((QuerySnapshot querySnapshot) {
                querySnapshot.docs.forEach((element) {
                  FirebaseFirestore.instance.collection('notifications').doc(element['nid']).update({
                    'isRead':true
                  });
                  // print(element['isRead']);
                });
               });
          
                
          }, icon: FutureBuilder(builder: (context, snapshot) {
                if(snapshot.hasError) return Text('Error');
              if(snapshot.connectionState==ConnectionState.waiting){
                return CircularProgressIndicator();
              }else{
            int sl= snapshot.data!.docs.length;

              return sl==0 ?  Icon(Icons.notifications,color: Colors.red,):  badges.Badge(
                  badgeContent: Text('${sl}') ,
                  child:   Icon(Icons.notifications,color: Colors.red,),
                );}
          },future: FirebaseFirestore.instance.collection('notifications').where('isRead',isEqualTo: false).where('receiverId',isEqualTo: context.read<AuthManager>().authToken!.token).get(),)
            
            
          ) 
        ],
        backgroundColor: Colors.white,),
        body: context.read<AuthManager>().isAuth ? Profile(context) : showLogin(),
     






      );
    }


Widget Profile(BuildContext context){
  AuthToken auth = context.read<AuthManager>().authToken!;
  return SingleChildScrollView(
            
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start
              ,
              children: [
                SizedBox(height: 8,),
                  buildAvatarProfile(auth.user),
                  SizedBox(height: 14,),
               
             Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                    
                          FollowAndLikeButton('${auth.user.Following?.length}','Following'),
                          FollowAndLikeButton('${auth.user.Follower?.length}','Follower',mar: 10.0),
                          FollowAndLikeButton('${auth.user.like?.length}','Like',mar: 30.0)


                       
                    ],
                  
                 ),
                  SizedBox(height: 12,)
                  ,
                  OutlinedButton(onPressed: () {
          Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SettingProfile(favorites: context.read<AuthManager>().authToken!.user.favorites!),
                                ),
                              );
                      // Navigator.of(context).pushNamed('/setting');
                    
                  }, child: Text('Sửa hồ sơ',style: TextStyle(color: Colors.black),)
                  ,

                  style: ButtonStyle(padding: MaterialStateProperty.all(
                    EdgeInsets.symmetric(vertical: 14 , horizontal: 28)
                  )),
                  )
                ,
                
                    SizedBox(height: 12,),
                  
                                // Text('Follow me to teah u fishing'),
                                // Text('Thx for your follow'),
                  SizedBox(height: 24,)

                  
                  ,
                       


                    Container(constraints: BoxConstraints(minHeight: 360,maxHeight: 360),

                    child:  FutureBuilder(
                      
                  future:VideosService().fetchProductsOfUser(auth.user.id!),
                  builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                       
                   return      GridView.builder(
                            itemCount: snapshot.data?.length,
                            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                                          maxCrossAxisExtent: 300,
                                          childAspectRatio: 3/4,
                                          crossAxisSpacing: 4,
                                          mainAxisSpacing: 4,
                                          

                            ),
              
              // 'https://via.placeholder.com/150/92c952'
              // Image(image:  NetworkImage(getThumnail(snapshot.data![index].videoLink)),fit: BoxFit.cover,)
                             itemBuilder: (context, index) {
            Future<void> _initializeVideoPlayerFuture;
                           var _videoPlayerController=  VideoPlayerController.network(
                           snapshot.data![index].videoLink);
        _initializeVideoPlayerFuture= _videoPlayerController.initialize();
                               return Container(
                               decoration: BoxDecoration(color: Colors.yellow),
                              child:Stack(
                                children: [
                               

                                  VideoPlayer(_videoPlayerController),
                                   Positioned(child:   PopupMenuButton(
                                        onSelected: (value) {
                                            if(value=='delete'){
                                              print('delete');
                                              showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Xác nhận'),
        content: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Text('Bạn có chắc chắn muốn xoá video này?'),
              // Text('Would you like to confirm this message?'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Xoá'),
            onPressed: () async{

            
             bool isSuccess=await  context.read<VideosManager>().delete( snapshot.data![index].id!);
             if(isSuccess)
                  ScaffoldMessenger.of(context).showSnackBar(
                   SnackBar(content: Text('Success'),duration: Duration(seconds: 2),),
                  );
               else
                ScaffoldMessenger.of(context).showSnackBar(
                   SnackBar(content: Text('falled'),duration: Duration(seconds: 2),),
                  );

              print('Confirmed');
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text('Quay lại'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
                                            }

                                    },
                                    icon: Icon(Icons.more_horiz_outlined,color: Colors.red,),
                                    itemBuilder: (context) => [
                                    const PopupMenuItem(
                                      value: 'delete'
                                      ,
                                      child: Text('Xoá video'))
                                   ],)
                                  ,
                               
                                    right: 0,
                                  )
                                ],
                              ),  
                               );
                             });
                  
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
                  ) 
                    
                    )

             
                
              ],
              
            ),
            
      );
}

  Widget FollowAndLikeButton(String num,String label,{double mar=0}){
    return    Container(
      margin:EdgeInsets.only(right: mar) ,
      child:  Column(
                        children: [Text('$num',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                          SizedBox(height: 3,),
                          Text(label,style: TextStyle(color: Colors.grey,fontSize: 16))
                        ]),
    )  ;

  }
    Widget buildAvatarProfile(Users user){

      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
           Column(
                 
                    children: [ 
                       CircleAvatar(
                      backgroundImage: NetworkImage(user.PhotoURL ?? 'https://picsum.photos/id/237/200/300'),
                      radius: 60,
                    ),
                    SizedBox(height: 8,)
                      ,


                      Text(user.name,style: TextStyle(fontSize: 18),),
                    ],
                   ),
                   
                      
                      ]);
        
      

  }



}