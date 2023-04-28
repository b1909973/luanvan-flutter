import 'package:social_video/models/user.dart';

class Comment{
    final String? id;
    final String content;
    final String userid;
    final String dateTime;
    final String videoid;
    final List<dynamic> likes;
    final List<dynamic>? children; 

    const Comment({this.id,required this.content,required this.userid, required this.likes, required this.videoid, required this.dateTime, this.children});


    Comment coppyWith({String?  id,String? content,String? userid, List<String>? likes,String? videoid, String? dateTime, List<String>? children}){

      return  Comment(id: id ?? this.id, content: content ?? this.content, dateTime: dateTime ?? this.dateTime, likes: likes ?? this.likes,userid: userid ?? this.userid, videoid: videoid ?? this.videoid , children: children ?? this.children );
    }

   



}