import 'package:flutter/material.dart';
import 'package:social_video/ui/pages/feed_screen/video_grid_item.dart';
import 'package:social_video/ui/pages/profile_screen/profile_screen1.dart';
import 'package:social_video/ui/pages/video_manager.dart';
import 'package:video_player/video_player.dart';
import 'package:provider/provider.dart';

class VideoGrids extends StatefulWidget{

  const  VideoGrids({Key? key});

  @override
  State<VideoGrids> createState() => _VideoGridsState();
}

class _VideoGridsState extends State<VideoGrids> {
   
  
     int _isWidgetFollowing = 0;

  Widget build(BuildContext context){

   
       
         return   Consumer<VideosManager>(
              builder: (context, videosManager, child){
        
        return  Stack(
        children: [
          

          
            PageView.builder(
                onPageChanged: (value) {
                  print(value);
                  if(value ==videosManager.Count-1){
                    print('load them');
                    context.read<VideosManager>().fetchProducts(videosManager.Count/2 +1);
                  }
                },
          
        scrollDirection: Axis.vertical
        
        ,
        itemCount: videosManager.Count
        ,itemBuilder: (context, index){
          print('-----------------------------------22222222222222222');
          print(videosManager.items[index].user);
          print('----------------------------------2222222222222222');
               return    PageView(
                  children: [
                     VideoGridItem(videosManager.items[index]),

                  ProfileScreenPeople(user: videosManager.items[index].user,),

                  ],
               );
                          
                        
                          
                          
                        


        }
      
            
            ),

      
          // _followingAndForYou(),
    
    


        ],
      );
        
      


              });



  }
   Widget _followingAndForYou(){

      return Align(
        alignment: Alignment.topCenter,
        child: Container(
            margin: EdgeInsets.symmetric(vertical: 40)
          ,
          child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  _isWidgetFollowing=0;
                });
              },
           child:Text('For you',style:_followingForYouStyle(_isWidgetFollowing==1 ?Colors.white :Colors.grey) ),
              
            ),
            SizedBox(width: 15)
            ,
                     GestureDetector(
              onTap: () {
                setState(() {
                  _isWidgetFollowing=1;
                });
              },
           child:Text('Following',style:_followingForYouStyle(_isWidgetFollowing==0 ?Colors.white :Colors.grey) ),
              
            ),

          ],
        ),
        )
      );
    }
     TextStyle _followingForYouStyle(Color color){
     return TextStyle(color: color,fontSize: 18,fontWeight: FontWeight.w500);
     }
  

}