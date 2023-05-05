


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_video/ui/pages/discover_screen/search_manager.dart';
import 'package:social_video/ui/pages/video_manager.dart';
import 'package:video_player/video_player.dart';

class SearchContent extends StatefulWidget{
   SearchContent({super.key});

  @override
  State<SearchContent> createState() => _SearchContentState();
}

class _SearchContentState extends State<SearchContent> {
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

                          
                          
  SizedBox(
      height: MediaQuery.of(context).size.height,
      child:     Expanded(
              
              child:                
           GridView.builder(
                               
                            itemCount:searchManager.Count,
                            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                                          maxCrossAxisExtent: 200,
                                          childAspectRatio: 3/4,
                                          crossAxisSpacing: 2,
                                          mainAxisSpacing: 2,


                            ),
              
              // 'https://via.placeholder.com/150/92c952'
              // Image(image:  NetworkImage(getThumnail(snapshot.data![index].videoLink)),fit: BoxFit.cover,)
                             itemBuilder: (context, index) {
            Future<void> _initializeVideoPlayerFuture;
                           var _videoPlayerController=  VideoPlayerController.network(
                           searchManager.items[index].videoLink);
        _initializeVideoPlayerFuture= _videoPlayerController.initialize();
                               return Stack(
                                children: [
                                    VideoPlayer(_videoPlayerController)
                                ],
                               );
                             })



              
              
              

            
            
            ),
     )
   

              
          ],
        );





         



              })
              
              

     
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
                 await   context.read<SearchManager>().fetchProductsSearch(this.value.text,1);
                      print(this.value.text);
                    
          }, child: Text('Tìm kiếm' ,style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),)),
          
                ],
              );
    }
}