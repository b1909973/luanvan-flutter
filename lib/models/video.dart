import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_video/models/user.dart';

class Video{
    final String? id;
    final String title;
    
    final String videoLink;
    
    final String userid;
    
    final List<dynamic>? like;
    final List<dynamic>? views;

    
    final bool isLike;
    
    final Timestamp dateTime;  

     int comment;
     Users? user;
    


     Video({this.id,required this.title,required this.videoLink,required this.userid,required this.like,required this.isLike,required this.dateTime,required this.comment,this.user,this.views});


    Video coppyWith({String? id,String? title,String? videoLink,String? userid,List<dynamic>? like,bool? isLike,Timestamp? dateTime,int? comment,List<dynamic>? views}){

      return Video(id: id,title: title ?? this.title,videoLink: videoLink ?? this.videoLink,userid: userid ?? this.userid,like: like ?? this.like, isLike:isLike ?? this.isLike,dateTime:dateTime ?? this.dateTime,comment:comment ?? this.comment,views: views ?? this.views);
    }

   



}