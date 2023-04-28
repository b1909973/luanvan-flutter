
import 'package:flutter/material.dart';
import 'package:social_video/ui/pages/feed_screen/video_grid_item.dart';
import 'package:social_video/ui/pages/profile_screen/profile_screen1.dart';
import 'package:social_video/ui/pages/video_manager.dart';
import 'package:video_player/video_player.dart';
import 'package:provider/provider.dart';

class VideoGridsDetail extends StatefulWidget{
      static const routeName ='/detail';
    final  int i;
        VideoGridsDetail({Key? key,required this.i});
  @override
  State<VideoGridsDetail> createState() => _VideoGridsDetailState();
}

class _VideoGridsDetailState extends State<VideoGridsDetail> {
   
  

  Widget build(BuildContext context){
    print('------------------------------------------------------');
  print('-------------------------${widget.i}');
    print('------------------------------------------------------');

   
       
         return  Scaffold(
       
          body:   Stack(children: [
            Scaffold(
               extendBodyBehindAppBar: true,
              backgroundColor: Colors.transparent,
            appBar: new AppBar(
             
              backgroundColor: Colors.transparent,
              elevation: 0.0,
            ),
              body: Consumer<VideosManager>(
              builder: (context, videosManager, child){
        
        return  Stack(
        children: [
          

          
            PageView.builder(

            controller: PageController(initialPage: widget.i),
          
        scrollDirection: Axis.vertical
        
        ,
        itemCount: videosManager.CountProductsOfUser
        ,itemBuilder: (context, index){
      
               return       VideoGridItem(videosManager.itemOfUser[index]);

                  
                        
                          
                          
                        


        }
      
            
            ),

      
          // _followingAndForYou(),
    
    


        ],
      );
        
      


              }
         ),
            )
          ],));
          



  }

  

}