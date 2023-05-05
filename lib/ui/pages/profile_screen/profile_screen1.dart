

import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:social_video/models/user.dart';
import 'package:social_video/services/video.dart';
import 'package:social_video/ui/pages/detail_screen/video_grids_detail.dart';
import 'package:social_video/ui/pages/login/auth_manager.dart';
import 'package:social_video/ui/pages/login/login_number.dart';
import 'package:social_video/ui/pages/video_manager.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:provider/provider.dart';

class ProfileScreenPeople extends StatefulWidget{
final Users user;

    const ProfileScreenPeople({super.key,required this.user});

  @override
  State<ProfileScreenPeople> createState() => _ProfileScreenPeopleState();
}

class _ProfileScreenPeopleState extends State<ProfileScreenPeople> {
      late Future<void> _fetchProducts;


   List<String> tags=[];
List<String> options = [
  'cafe', 'food', 'walk',
  'football', 'travel', 'music',
  'movie', 'camping'
];
  //  var a = widget.users;
  void initState(){
    print('llllllllllllllllllllllllllllllllllllllllllllllllllllll');
    print('llllllllllllllllllllllllllllllllllllllllllllllllllllll');
    print('aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa');
    print('llllllllllllllllllllllllllllllllllllllllllllllllllllll');
    print('llllllllllllllllllllllllllllllllllllllllllllllllllllll');
    print('llllllllllllllllllllllllllllllllllllllllllllllllllllll');
    print('llllllllllllllllllllllllllllllllllllllllllllllllllllll');

 tags = List<String>.from(widget.user.favorites!);
 
options =  List<String>.from(widget.user.favorites!);
      super.initState();
      print('aaaaaaa');
      _fetchProducts = context.read<VideosManager>().fetchProductsOfUser(widget.user.id!);
    }

    @override
    Widget build(BuildContext context) {
     
      // print(user);
      return  Scaffold(
        appBar: AppBar(
        title: Text(widget.user.name,style: TextStyle(color: Colors.black)),
        centerTitle: true,

        
        backgroundColor: Colors.white,),

        body: SingleChildScrollView(
            
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start
              ,
              children: [
                SizedBox(height: 8,),
                  buildAvatarProfile(),
                  SizedBox(height: 14,),
               
             Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                    
                          FollowAndLikeButton('${widget.user.Following?.length}','Following'),
                          FollowAndLikeButton('${widget.user.Follower?.length}','Follower',mar: 10.0),
                          FollowAndLikeButton('${widget.user.like?.length}','Like',mar: 30.0)


                       
                    ],
                  
                 ),
                  SizedBox(height: 12,)
                  ,
               (context.read<AuthManager>().isAuth && (context.read<AuthManager>().authToken?.user.Following)!.contains(widget.user.id) )   ? UnFollow(): Follow(), 
                    SizedBox(height: 12,),
                if(options.isNotEmpty)      ChipsChoice<String>.multiple(
        wrapped: true,
    value: tags.toList(),
    onChanged: (val) => setState(() => tags = val),
    choiceItems: C2Choice.listFrom<String, String>(
      source: options,
      value: (i, v) => v,
      label: (i, v) => v,
    ),
  ),
                                // Text('Follow me to teah u fishing'),
                                // Text('Thx for your follow'),
                  SizedBox(height: 24,),

                 
                  
                      


                    Container(constraints: BoxConstraints(minHeight: 360,maxHeight: 360),

                    child:  FutureBuilder(
                  future:_fetchProducts,
                  builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                       
                      return VideoList();
                  
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
            
      )
      );
    }


Widget Follow() {

  
  return   (  context.read<AuthManager>().isAuth  &&   context.read<AuthManager>().authToken?.token==widget.user.id) ? Text('') :   ElevatedButton(onPressed: ()async {
                        var isAuth =  context.read<AuthManager>().isAuth;
                          if (isAuth) {
                                print('da dang nhap');
                      await       context.read<AuthManager>().follow(context.read<AuthManager>().authToken!.token,widget.user.id);
                         setState(() {
                           
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
                                       child:  Padding(padding: EdgeInsets.symmetric(horizontal: 30,vertical: 10),child:Text('Follow')),
                                        style:  ElevatedButton.styleFrom(backgroundColor: Colors.red),);
}

Widget UnFollow(){
  return   ElevatedButton(onPressed: () async {
               await     context.read<AuthManager>().unfollow(context.read<AuthManager>().authToken!.token,widget.user.id);
                 setState(() {
                      
                    });
                     },
                                       child:  Padding(padding: EdgeInsets.symmetric(horizontal: 30,vertical: 10),child:Text('Following',style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold),)),
                                        style:  ElevatedButton.styleFrom(backgroundColor: Colors.white),);
                  

}

Widget VideoList(){

  return      Consumer<VideosManager>(builder: (context, videosManager, child){

    return  GridView.builder(
                               
                            itemCount: videosManager.CountProductsOfUser,
                            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                                          maxCrossAxisExtent: 160,
                                          childAspectRatio: 3/4,
                                          crossAxisSpacing: 4,
                                          mainAxisSpacing: 4

                            ),
              
              // 'https://via.placeholder.com/150/92c952'
              // Image(image:  NetworkImage(getThumnail(snapshot.data![index].videoLink)),fit: BoxFit.cover,)
                             itemBuilder: (context, index) {
            Future<void> _initializeVideoPlayerFuture;
                           var _videoPlayerController=  VideoPlayerController.network(
                           videosManager.itemOfUser[index].videoLink);
        _initializeVideoPlayerFuture= _videoPlayerController.initialize();
                               return Container(
                               decoration: BoxDecoration(color: Colors.yellow),
                              child:GestureDetector(
                                onTap: () {
                                  print('detail');
                                                        Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => VideoGridsDetail(i: index),
                                ),
                              );
                                },
                                child: Stack(
                                  children: [
                                 VideoPlayer(_videoPlayerController),

                                        Positioned(
                                  top: 20,
                                  left: 5,
                                  child: 

                                 Column(
                                  
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  
                                  children: [
                                     Text('${videosManager.itemOfUser[index].title}', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,fontSize: 9),),
                                     Text('${convertToAgo(videosManager.itemOfUser[index].dateTime.toDate())}', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,fontSize: 8),)

                                  ],
                                 )
                                  ),
             Positioned(
                                  bottom: 20,
                                  right: 5,
                                  child: 
                                 Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                     Text('${videosManager.itemOfUser[index].views!.length.toString()} lượt xem', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                                 

                                  ],
                                 )
                                  ),

                                  ],
                              ),  
                               ));
                             });
  }
  
  
  
  
  ,
  
  
  );

  
  
  
  
  
       

}
 String convertToAgo(DateTime input){
  Duration diff = DateTime.now().difference(input);
  
  if(diff.inDays >= 1){
    return '${diff.inDays} day ago';
  } else if(diff.inHours >= 1){
    return '${diff.inHours} hour ago';
  } else if(diff.inMinutes >= 1){
    return '${diff.inMinutes} minute ago';
  } else if (diff.inSeconds >= 1){
    return '${diff.inSeconds} second ago';
  } else {
    return 'just now';
  }}


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

    Widget buildAvatarProfile(){

      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
           Column(
                 
                    children: [ 
                       CircleAvatar(
                      backgroundImage: NetworkImage(widget.user.PhotoURL ?? 'https://picsum.photos/id/237/200/300'),
                      radius: 60,
                    ),
                    SizedBox(height: 8,)
                      ,

                    Row(children: [
                      Text(widget.user.name,style: TextStyle(fontSize: 18),),

                        widget.user.tick?   Icon(Icons.check_circle,color: Colors.green,) : Text('')
                    ],)
                    ],
                   ),
                   
                      
                      ]);
        
      

  }
}