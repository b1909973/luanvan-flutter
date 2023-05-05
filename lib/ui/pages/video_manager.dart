import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:social_video/services/user.dart';
import 'package:social_video/services/video.dart';
import '../../models/comment.dart';

import '../../models/video.dart';

class VideosManager with ChangeNotifier{
 final VideosService _videosService;


  VideosManager() : _videosService = VideosService();
      List<Video> _items =  [
      //  Video(id: '1',title:'Bai post moi' , id_user: '1', videoLink: 'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4' ,like:{'id_user':['u1','u2'],'numlike':'1'}, dateTime: '2002-12-1'),
      // Video(id: '2',title:'Bai post moi' , id_user: '1', videoLink: 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4' ,like:{'id_user':['u1','u2'],'numlike':'1'}, dateTime: '2002-12-1'),
      // Video(id: '3',title:'Bai post moi' , id_user: '1', videoLink: 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4' ,like:{'id_user':['u1','u2'],'numlike':'1'}, dateTime: '2002-12-1'),
      // Video(id: '4',title:'Bai post moi' , id_user: '1', videoLink: 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4' ,like:{'id_user':['u1','u2'],'numlike':'1'}, dateTime: '2002-12-1'),
      // Video(id: '5',title:'Bai post moi' , id_user: '1', videoLink: 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4' ,like:{'id_user':['u1','u2'],'numlike':'1'}, dateTime: '2002-12-1'),
    
    ];

    List<Video> _itemsFollowing =[

    ];
    List<Video> _itemsOfUser = [

    ];
      List<Comment> _comment = [

      ];
    get items {
        return this._items;
    }
    get itemFollwing {
      return this._itemsFollowing;
    }

    get itemOfUser {
      return this._itemsOfUser;
    }
 get comment{
  return this._comment;
 }
  Future<void> fetchProducts(int pagination) async{
    
        this._items = await _videosService.fetchProducts(pagination);
         _items.sort((a, b) => b.dateTime.compareTo(a.dateTime));

           print(_items);
          
          notifyListeners();
     

}

  Future<void> fetchProductsFollowing(int pagination, List<dynamic> following) async{
    
        this._itemsFollowing = await _videosService.fetchProductsFollowing(pagination,following);
         _itemsFollowing.sort((a, b) => b.dateTime.compareTo(a.dateTime));

           print(_itemsFollowing);
          notifyListeners();
     

}




   Future<bool> delete(String id) async{
   
       bool isSuccess=  await _videosService.delete(id);
        Video v= this._itemsOfUser.firstWhere((element) => element.id==id);
      await  this._itemsOfUser.remove(v);
          notifyListeners();
        return isSuccess;

}

 
 
 Future<void> updateLike(String id,String token) async{
    Video video = this._items.singleWhere((element) => element.id==id);
       int index = 0;
      // for (var i = 0; i < this._items.length; i++) {
      //       if(this._items[i].id==id){
      //         index=i;
      //       }
      // }
    List<dynamic> like = video.like!;
 bool isLike = false;  
  like.forEach((element) {
      if(element==token){
        isLike=true;
      
      }
  });
  switch (isLike) {
    case true:
      like.remove(token);
      
      break;
    default:
    like.add(token);



  }
  


    print('99999999999999999999999999999999999999999999999999');
    print(video.like.toString());

      await _videosService.updateLike(id,token,like);
     
          notifyListeners();
     

}


Future<void> updateUserLike(String id,String token) async{
    Video video = this._itemsOfUser.singleWhere((element) => element.id==id);
       int index = 0;
      // for (var i = 0; i < this._items.length; i++) {
      //       if(this._items[i].id==id){
      //         index=i;
      //       }
      // }
    List<dynamic> like = video.like!;
 bool isLike = false;  
  like.forEach((element) {
      if(element==token){
        isLike=true;
      
      }
  });
  switch (isLike) {
    case true:
      like.remove(token);
      
      break;
    default:
    like.add(token);



  }
  


    print('99999999999999999999999999999999999999999999999999');
    print(video.like.toString());

      await _videosService.updateLike(id,token,like);
     
          notifyListeners();
     

}
Future<void> updateComment(String id,String? token,String content) async{

   bool isSuccess=  await _videosService.updateComment(id,token!,content,this._comment.length);
  Video a= this._items.firstWhere((element) {
    return element.id==id;
   },);
   a.comment++;
   print(a);
           notifyListeners();
      //  await   this.fetchComments(id);
     

}
Future<void> updateUserComment(String id,String? token,String content) async{

   bool isSuccess=  await _videosService.updateComment(id,token!,content,this._comment.length);
  Video a= this._itemsOfUser.firstWhere((element) {
    return element.id==id;
   },);
   a.comment++;
   print(a);
           notifyListeners();
      //  await   this.fetchComments(id);
     

}



 
  Future<void> fetchComments(String videoId) async{
         _comment= await _videosService.fetchComment(videoId);
         _comment.sort((a, b) => b.dateTime.compareTo(a.dateTime));
         print('------------------------------');
         print(_comment);
         print('------------------------------');

          notifyListeners();
     

}
get Count {
  return this._items.length;
}
get CountFollowing {
  return this._itemsFollowing.length;
}
get CountProductsOfUser {
  return this._itemsOfUser.length;
}

  Future<void> fetchProductsOfUser(String uid) async{
    
        this._itemsOfUser = await _videosService.fetchProductsOfUser(uid);
         _itemsOfUser.sort((a, b) => b.dateTime.compareTo(a.dateTime));

           print(_itemsOfUser);
          notifyListeners();
     

}

 
}