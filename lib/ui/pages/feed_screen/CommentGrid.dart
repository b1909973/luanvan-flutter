

import 'package:flutter/material.dart';
import 'package:social_video/ui/pages/login/auth_manager.dart';
import '../../../models/comment.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:social_video/ui/pages/video_manager.dart';
import 'package:provider/provider.dart';

class CommentGird extends StatefulWidget{
      final String videoId;
    CommentGird({Key? key,required this.videoId});

  @override
  State<CommentGird> createState() => _CommentGirdState();
}

class _CommentGirdState extends State<CommentGird> {
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


                     
                          child: Column(
                        children: [
              CommentInput(widget.videoId,context.read<AuthManager>().isAuth ? context.read<AuthManager>().authToken!.token : '' ,context),
                Expanded(child: ListView.builder(
                              itemCount: videosManager.comment.length,
                              itemBuilder: (context, index) {
                                print(videosManager.comment);
                              return CommentItem(videosManager.comment[index]);
                            },),

                
                
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
      
      Widget CommentInput(String videoId,String? id,BuildContext context){
         TextEditingController content = TextEditingController(text:'');
        return           Container(
          padding: EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white
          ),
          child:    Row(
                children: [
                  const SizedBox(width: 20,),
                
                 
                  Expanded(child: TextField(
                    
                      controller: content,
                       decoration:  InputDecoration(
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
                GestureDetector(
                  onTap: ()async {
                    print('tap');
                    print(content);
                    
                    if(id!=''){
                    await   context.read<VideosManager>().updateComment(videoId,id,content.text);
                          setState(() {
                            
                          });
                    }
                      
                    else
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
                  },
                  child:   Icon(Icons.play_arrow),
                ),
                  const SizedBox(width: 6,)

                ],
              ),
        );
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

}

  