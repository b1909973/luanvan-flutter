

import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:social_video/services/video.dart';
import 'package:social_video/ui/pages/detail_screen/comment_detail_screen.dart';
// import 'package:social_video/ui/pages/feed_screen/comment_screen.dart';
import 'package:social_video/ui/pages/login/auth_manager.dart';
import 'package:social_video/ui/pages/login/login_number.dart';
import 'package:social_video/ui/pages/profile_screen/profile_screen1.dart';
import 'package:social_video/ui/pages/video_manager.dart';
import 'package:video_player/video_player.dart';
import '../../../models/video.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class VideoGridDetailItem extends StatefulWidget{
    Video _video;

     VideoGridDetailItem(this._video,{super.key});
 
  @override
  State<VideoGridDetailItem> createState() => _VideoGridDetailItemState();
}

class _VideoGridDetailItemState extends State<VideoGridDetailItem> {
    bool isPlay =  false;
    // bool isLike =false;
   late Future<void> _initializeVideoPlayerFuture;
    late VideoPlayerController _videoPlayerController;
    double valueLoaded = 1;
   void initState() {
    _videoPlayerController= VideoPlayerController.network(
       widget._video.videoLink);
        
          _videoPlayerController.play();
          _videoPlayerController.setLooping(true);
        _initializeVideoPlayerFuture= _videoPlayerController.initialize();
     
          super.initState();

  }
     void dispose() {
    super.dispose();
    _videoPlayerController.dispose();
  }


    Widget build(BuildContext context){
      print('${widget._video.user} -----------------');
          // VideosService().fetchComment('b4747de9-847e-064e-7a27-98977e776ad8');
      
           return  VideoItem();
              
            
      
    }

    Widget VideoItem(){

      return Stack(
        
        children: [

              FutureBuilder(
  future:_initializeVideoPlayerFuture,
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.done) {
      print('chay');
       

      // If the VideoPlayerController has finished initialization, use
      // the data it provides to limit the aspect ratio of the video.
      return  Container(          
        color: Colors.black,     
       child:  VideoPlayer(_videoPlayerController),    
       
    
      );
      
     
      
    } else {
      // If the VideoPlayerController is still initializing, show a
      // loading spinner.
      return Container(
          decoration: BoxDecoration(
            color:Colors.black
          ),
        child: Align(child: CircularProgressIndicator()),
      );
    }
  },
),
    
         
            
       isPlay?Container(
         
            child: Align(
          
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
              decoration: BoxDecoration(
                color:Colors.black.withOpacity(0.4),
                borderRadius: BorderRadius.all(Radius.circular(10))
              ),
 
            child: GestureDetector( child:Icon(Icons.play_arrow,color: Colors.white,size:80 ),onTap: () {
              setState(() {
              isPlay=false;
                  _videoPlayerController.play();
                 Duration currentPosition =_videoPlayerController.value.position;
          Duration targetPosition = currentPosition + const Duration(seconds: 10);
         _videoPlayerController.seekTo(targetPosition);
                
              });
            },
        
        ),
            )
        )): GestureDetector(

           
              child: Container(
                decoration: BoxDecoration(
               
                ),
                child:Align()),

              onTap: () {
                setState(() {
                  isPlay=true;
                  _videoPlayerController.pause();
                });
              },
          ),
             _barLoadVideo(),
          _rightSideButtons(),

           _textDataBottom(),

          

        ]
        
        
      );
    }
    Widget _barLoadVideo(){
      return     Positioned(
         
            
              child:   Container(
                      child: VideoProgressIndicator(
                        _videoPlayerController, 
                        allowScrubbing: true,
                        colors:VideoProgressColors(
                            backgroundColor: Colors.black38,
                            playedColor: Colors.yellow,
                            bufferedColor: Colors.grey,
                        )
                      ))
                  );
            
    }
    Widget _textDataBottom(){
        return Positioned(
          bottom:20 ,
          left:10
          ,
          child:Column(
              crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                Text('${widget._video.title}',overflow: TextOverflow.ellipsis,style: TextStyle(color: Colors.white,fontSize: 20)),
                SizedBox(height: 10,),
                Container(
                  width: MediaQuery.of(context).size.width-100,
                  
                child: Text('${widget._video.user?.name}',style: TextStyle(color: Colors.white,fontSize: 14)),
                  
                ),

                SizedBox(height: 10,),
              
                Container(
                  width: MediaQuery.of(context).size.width-100,
                child: Text('',style: TextStyle(color: Colors.white,fontSize: 14)),
                )
               
            ],
          )
        
        );


    }

    Widget _rightSideButtons(){
      return Positioned
      
      (
        right: 10,
        bottom: 50
        ,
        child: 
      
      Column(
        children: [
           Container(

            height: 60,
            child:  Stack(
              children: [
               CustomCircleAvatar(50, widget._video.user?.PhotoURL ?? 'https://vapa.vn/wp-content/uploads/2022/12/anh-den-dep-002.jpg'),
              
              // Follow()

              ],
            ),
           ),
              SizedBox(height: 15,)

          ,
            SendHeart(context),
          
              SizedBox(height: 15,)
            ,
            Container(
              child: Column(children: [
                 CommentDetailScreen(videoId:widget._video.id!),
                Text('${widget._video.comment}',style: TextStyle(color: Colors.white),)
              ]),

            ),
              SizedBox(height: 15.0,)
            
            ,
              // Container(child: Icon(Icons.forward,color:Colors.white,size: 34,),),
              SizedBox(height: 30.0,),

              // CustomCircleAvatar(30,'')

        ],
      )
      );
    }
Widget SendHeart(BuildContext ctx){
              var token = ctx.read<AuthManager>().isAuth!=null ?  (ctx.read<AuthManager>().authToken?.token): null;

  return   GestureDetector(
            onTap: () {
              var isAuth =  ctx.read<AuthManager>().isAuth;

              print(isAuth);
              print('heart3333333333333333333333333333333333333333333333333333333333333');
              print('heart3333333333333333333333333333333333333333333333333333333333322');


              if(isAuth){
              setState(() {
                  print('aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa');

            // isLike=!isLike;
             ctx.read<VideosManager>().updateUserLike(widget._video.id!,token!);
                
              });
              }else{


                 showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Container(
                          padding: EdgeInsets.symmetric(horizontal: 40),
                        height: 1000,


                     
                          child:   Stack(
                            children: [
                             Positioned(
                               child:Align(child: Text('Đăng nhập để làm nhiều thứ hơn!',style: TextStyle(fontSize: 18,fontStyle: FontStyle.italic),),),
                              top: 140,
                              ),

                              
                           Align(
                            child:     ElevatedButton(onPressed: () {
                                                         Navigator.of(context).popAndPushNamed('/login');


                            },
                                       child:  Padding(padding: EdgeInsets.symmetric(horizontal: 30,vertical: 10),child:Text('Đăng nhập')),
                                        style:  ElevatedButton.styleFrom(backgroundColor: Colors.red),),
                           )
                            ],
                          )
                      );
                    },
                  );
              }

            },
          child:   Container(
              child: Column(children: [
                
           ( (widget._video.like?.contains(token))! ) ?  Icon(FontAwesomeIcons.solidHeart,color: Colors.red,) :Icon(FontAwesomeIcons.heart,color: Colors.white,),

                Text('${widget._video.like?.length}',style: TextStyle(color: Colors.white),)
              ]),
            ),
         );
}
    Widget Follow(){
      return       
               Positioned(
                right: 15,
                bottom: 4,
                child:  Container(
                    constraints: BoxConstraints.expand(
                      height: 20,
                      width: 20
                    )
                  ,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.all(Radius.circular(30))
                  ),
                  child:Align(child:  Icon(Icons.add,size: 12,color: Colors.white,)),
                ),);
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
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    border: Border.all(width: 2,color: Colors.white)
                  ),
                  child:       CircleAvatar(
                  backgroundImage: NetworkImage(avatar!),
                  radius: 36,
                ),
                );
      }
}





