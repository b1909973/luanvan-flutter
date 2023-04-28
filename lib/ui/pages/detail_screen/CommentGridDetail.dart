

import 'package:flutter/material.dart';
import '../../../models/comment.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:social_video/ui/pages/video_manager.dart';

class CommentGirdDetail extends StatelessWidget{


  Widget build(BuildContext context){
   
      return Consumer<VideosManager> (
          builder: (context, videosManager, child) {
           return  GestureDetector(
                child:  Icon(FontAwesomeIcons.comment,color: Colors.white,),
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Container(
                       
                        height: 1000,


                     
                          child: Stack(
                        children: [
                            ListView.builder(
                              itemCount: videosManager.comment.length,
                              itemBuilder: (context, index) {
                                print(videosManager.comment);
                              return CommentItem(videosManager.comment[index]);
                            },),

                 
                  Align(
                          alignment: Alignment.topCenter,
                          child:  Container(
                            padding: EdgeInsets.symmetric(vertical: 4),
                            decoration:   BoxDecoration(color: Colors.red,),
                            child: Text('4.8K comment'),
                          )
                        ),
                    
              Align(
                  alignment: AlignmentDirectional.bottomEnd,
                  child:CommentInput()

                 )
                        ],
                      ),
                      );
                    },
                  );
                }); 
          },
        ) ;
}
   
  
}

  Widget CommentItem(Comment comment){
        return ListTile(
                            leading:CustomCircleAvatar(40, ''),
                      
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                  Text('${comment.userid}' ,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12),),
                                  Text('${comment.content}',style: TextStyle(fontSize: 14)),

                              ],
                            ),
                            trailing: Icon(Icons.heart_broken),



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
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    border: Border.all(width: 2,color: Colors.white)
                  ),
                  child:       CircleAvatar(
                  backgroundImage: NetworkImage(avatar!),
                  radius: 36,
                ),
                );
      }
      
      Widget CommentInput(){
        return           Container(
          padding: EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white
          ),
          child:    Row(
                children: [
                  const SizedBox(width: 20,),
                
                 
                  Expanded(child: TextField(
                    
                    
                       decoration: InputDecoration(
                        filled: true,
                      fillColor: Color.fromARGB(255, 237, 236, 230), 
                      border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(60.0),
                    borderSide: BorderSide.none
                    
                  ),
                      hintText: 'Please enter a search term',
                      
  ),
                  ),
                  
                  ),
                  const SizedBox(width: 10,)
                  ,
                  Icon(Icons.play_arrow),
                  const SizedBox(width: 6,)

                ],
              ),
        );
      }