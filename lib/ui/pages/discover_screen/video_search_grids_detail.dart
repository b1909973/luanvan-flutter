
import 'package:flutter/material.dart';
import 'package:social_video/ui/pages/discover_screen/search_manager.dart';
import 'package:social_video/ui/pages/discover_screen/video_search_grid_item.dart';
import 'package:social_video/ui/pages/profile_screen/profile_screen1.dart';
import 'package:social_video/ui/pages/video_manager.dart';
import 'package:video_player/video_player.dart';
import 'package:provider/provider.dart';

class VideoSearchGridsDetail extends StatefulWidget{
      // static const routeName ='/detail';
    final  int i;
        VideoSearchGridsDetail({Key? key,required this.i});
  @override
  State<VideoSearchGridsDetail> createState() => _VideoSearchGridsDetailState();
}

class _VideoSearchGridsDetailState extends State<VideoSearchGridsDetail> {
   
  

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
              body: Consumer<SearchManager>(
              builder: (context, searchManager, child){
        
        return  Stack(
        children: [
          

          
            PageView.builder(

            controller: PageController(initialPage: widget.i),
          
        scrollDirection: Axis.vertical
        
        ,
        itemCount: searchManager.Count
        ,itemBuilder: (context, index){
      
               return       VideoSearchGridItem(searchManager.items[index]);

                  
                        
                          
                          
                        


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