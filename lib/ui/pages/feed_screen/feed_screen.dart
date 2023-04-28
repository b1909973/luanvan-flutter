

import 'package:flutter/material.dart';
import 'package:social_video/ui/pages/feed_screen/video_grids.dart';
import 'package:social_video/ui/pages/profile_screen/profile_screen1.dart';
import 'package:social_video/ui/pages/video_manager.dart';
import 'package:video_player/video_player.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

// const datas  =[ 
//       'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
//       'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
//       'https://assets.json2video.com/assets/videos/beach-01.mp4',
//       'https://assets.json2video.com/assets/videos/beach-02.mp4',
//       'https://assets.json2video.com/assets/videos/beach-03.mp4',
//       'https://assets.json2video.com/assets/videos/beach-04.mp4',
//       'https://assets.json2video.com/assets/videos/beach-05.mp4',


    
// ];
class FeedScreen extends StatefulWidget{
    const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
        // final videosManager = VideosManager();
      late Future<void> _fetchProducts;

    void initState(){
      super.initState();
      print('aaaaaaa');
      _fetchProducts = context.read<VideosManager>().fetchProducts(1);
    }





    @override
    Widget build(BuildContext context) {
      print('render 1');
      return FutureBuilder(
                  future: _fetchProducts,
                  builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                
                  return   VideoGrids();
                  
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
                  ) ;
      
      
      
    
    }
   

}