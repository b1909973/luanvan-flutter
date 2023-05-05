


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_video/models/user.dart';
import 'package:social_video/ui/pages/detail_screen/video_grids_detail.dart';
import 'package:social_video/ui/pages/discover_screen/search_manager.dart';
import 'package:social_video/ui/pages/discover_screen/video_search_grids_detail.dart';
import 'package:social_video/ui/pages/profile_screen/profile_screen1.dart';
import 'package:social_video/ui/pages/video_manager.dart';
import 'package:video_player/video_player.dart';

class SearchContent extends StatefulWidget{
   SearchContent({super.key});

  @override
  State<SearchContent> createState() => _SearchContentState();
}

class _SearchContentState extends State<SearchContent> {
      bool isVideo =true;
    TextEditingController value = TextEditingController(text: '');

    @override
    Widget build(BuildContext context) {
      return SingleChildScrollView(
       
              
              child:  Consumer<SearchManager>(
              builder: (context, searchManager, child){
                
                  return    Column(
          children: [

           

              SizedBox(height: 6,),

            SearchBar(context)
                          ,
                          Divider(color: Colors.black26,),

                          Row(
                            children: [
                              TextButton(onPressed: () async  {    
                                if(!isVideo)
                                     setState(() {
                                       isVideo =true;
                                     });
          }, child: Text('Video' ,style: TextStyle(color: isVideo ? Colors.red :Colors.grey ,fontWeight: FontWeight.bold),)),
            TextButton(onPressed: () async  {   
              setState(() {
                if(isVideo)
                isVideo=false;
              });     
          }, child: Text('Người dùng' ,style: TextStyle(color: !isVideo ? Colors.red :Colors.grey ,fontWeight: FontWeight.bold),)),
                            ],
                          )
                          ,
  isVideo ? SizedBox(
      height: MediaQuery.of(context).size.height-220,
      child:     Expanded(
              
              child:                
          ListView.builder(
                           
                            itemCount:searchManager.Count +1,
                        
              // 'https://via.placeholder.com/150/92c952'
              // Image(image:  NetworkImage(getThumnail(snapshot.data![index].videoLink)),fit: BoxFit.cover,)
                             itemBuilder: (context, index) {
                        
            Future<void> _initializeVideoPlayerFuture;
                           var _videoPlayerController= searchManager.Count!=index ?  VideoPlayerController.network(
                           searchManager.items[index].videoLink) : VideoPlayerController.network('');
        _initializeVideoPlayerFuture= _videoPlayerController.initialize();

                               return searchManager.Count==index  ? 
                                 ElevatedButton(onPressed: () async {
                                                  
                 await   context.read<SearchManager>().fetchProductsSearch(this.value.text,searchManager.CountUser+6);


                            },
                                       child:  Padding(padding: EdgeInsets.symmetric(horizontal: 30,vertical: 10),child:Text('Xem thêm')),
                                        style:  ElevatedButton.styleFrom(backgroundColor: Colors.red),)
                                
                                 : 
                               
                               SizedBox(
                                  height: MediaQuery.of(context).size.height-260,
                                child: Stack(
                                children: [
                                
                                   GestureDetector(
                                onTap: () {
                                  print('detail');
                                                        Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => VideoSearchGridsDetail(i: index),
                                ),
                              );
                                },
                                child: VideoPlayer(_videoPlayerController),
                              ),  

                              Positioned(child: 
                                 Row(
                                  children: [
                                     CustomCircleAvatar(20, searchManager.items[index].user.PhotoURL),
                                     SizedBox(width: 4,)
                                     ,
                                     Text(searchManager.items[index].user.name,  style: TextStyle(color: Colors.white))
                                  ],
                                 )
                                  )
                                    ,

                                Positioned(
                                  top: 20,
                                  left: 5,
                                  child: 
                                  Text('${searchManager.items[index].title}', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),)
                                  ),
                                     Positioned(
                                  bottom: 20,
                                  right: 5,
                                  child: 
                                 Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                     Text('${searchManager.items[index].views!.length.toString()} lượt xem', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                                 

                                  ],
                                 )
                                  ),

                                  
                                ],
                               )     
                               ) ;
                             })



              
              
              

            
            
            ),
     ) :
       SizedBox(
      height: MediaQuery.of(context).size.height-260,
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
                child: index==searchManager.CountUser+1-1 ? 
                 ElevatedButton(onPressed: () async {
                                                  
                 await   context.read<SearchManager>().fetchProductsSearch(this.value.text,searchManager.CountUser+6);


                            },
                                       child:  Padding(padding: EdgeInsets.symmetric(horizontal: 30,vertical: 10),child:Text('Xem thêm')),
                                        style:  ElevatedButton.styleFrom(backgroundColor: Colors.red),)
                
                : buildUser(searchManager.itemsUser[index]),
                onTap: (() =>{
                      print('aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa---'),
                  print(searchManager.itemsUser[index]),
                      print('aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa---'),

                    Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>   ProfileScreenPeople(user: searchManager.itemsUser[index]),
                                ),
                              )
                    
                  //  Navigator.push(
                  //     context,
                  //     MaterialPageRoute(builder: (context) => ChatDetailScreen()),
                  //   )
                }
                
                ),
               )
        , separatorBuilder: (context, index) => const SizedBox(height: 14,), itemCount: searchManager.CountUser+1));
     
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
    Widget SearchBar(BuildContext context){
      return   Row(
                children: [
            Expanded(child:        Padding(
          
          padding: const EdgeInsets.symmetric(horizontal: 16),
          
           child:  SizedBox(
            height: 50,
            child: TextFormField( 
                controller: value,
            cursorColor: Colors.red,
            
          
            decoration: const InputDecoration(
                fillColor: Colors.black12,
                filled: true,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.black12
                  )
                ),
                enabledBorder: OutlineInputBorder(
                     borderSide: BorderSide(
                    color: Colors.black12
                  )
                ),
           
            hintText: 'Tìm kiếm'
            ),
          
         
            
          ),
           )
        ),),
                    TextButton(onPressed: () async  {
                 await   context.read<SearchManager>().fetchProductsSearch(this.value.text,6);
                      print(this.value.text);
          }, child: Text('Tìm kiếm' ,style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),)),
          
                ],
              );
    }
}