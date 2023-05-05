

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:social_video/models/user.dart';
import 'package:social_video/ui/pages/discover_screen/search_manager.dart';
import 'package:social_video/ui/pages/login/auth_manager.dart';
import '../../../models/comment.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:social_video/ui/pages/video_manager.dart';
import 'package:provider/provider.dart';

class CommentSearchGird extends StatefulWidget{
      final String videoId;
    CommentSearchGird({Key? key,required this.videoId});

  @override
  State<CommentSearchGird> createState() => _CommentSearchGirdState();
}

class _CommentSearchGirdState extends State<CommentSearchGird> {
         TextEditingController content = TextEditingController(text:'');

  Widget build(BuildContext context){
   print('build-------------------------------------------------------------------------------------------------------');
 
      return Consumer<SearchManager> (
          builder: (context, searchManager, child) {
           return  GestureDetector(
                child:  Icon(FontAwesomeIcons.comment,color: Colors.white,),
                onTap: () {
                  // _showCommentModal(context);
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Container(
                       
                        height: 1000,


                     
                          child: Column(
                        children: [
              CommentInput(widget.videoId,context.read<AuthManager>().isAuth ? context.read<AuthManager>().authToken!.token : '' ,context,context.read<AuthManager>().isAuth ?  context.read<AuthManager>().authToken!.user : null),
              
                Expanded(child: ListView.builder(
                              itemCount: searchManager.comment.length,
                              itemBuilder: (context, index) {
                                print(searchManager.comment);
                              return CommentItem(searchManager.comment[index]);
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
      
      
      Widget CommentInput(String videoId,String? id,BuildContext context,Users? user){
        return           Container(
          padding: EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white
          ),
          child:    Row(
                children: [
                  const SizedBox(width: 20,),
                
                 
                  Expanded(child: TextFormField(
                    
                      controller: content,
                       decoration:  InputDecoration(
                        filled: true,
                      fillColor: Color.fromARGB(255, 237, 236, 230), 
                      border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(60.0),
                    borderSide: BorderSide.none
                    
                  ),
                      hintText: 'Nhập bình luận',
                      
  ),
                  ),
                  
                  ),
                  const SizedBox(width: 10,)
                  ,
              
                  
                 
                   FloatingActionButton(
                    backgroundColor: Colors.red,
                    onPressed: () 
                    async {
                    print('tap');
                    print(content);
                    
                    if(id!=''){
                      print('1aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa');
                    await   context.read<SearchManager>().updateComment(videoId,id,content.text);
                    await context.read<SearchManager>().fetchComments(videoId);
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
                  
                  },child: Icon(Icons.send),),
                ]
              ),
        );
      }
      
  Widget CommentItem(Comment comment){  
        return ListTile(
                            leading:CustomCircleAvatar(40, comment.user?.PhotoURL),
                      
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                  Text('${comment.user?.name}' ,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12),),
                                  Text('${comment.content}',style: TextStyle(fontSize: 14)),

                              ],
                            ),
                             trailing: Text('${convertToAgo(comment.dateTime.toDate())}'),
                            


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
   

}

  