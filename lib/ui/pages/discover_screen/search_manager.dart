import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:social_video/models/comment.dart';
import 'package:social_video/models/user.dart';
import 'package:social_video/services/user.dart';
import 'package:social_video/services/video.dart';


import '../../../models/video.dart';

class SearchManager with ChangeNotifier{
 final VideosService _videosService;
 final UsersService _userService;


  SearchManager() : _videosService = VideosService(),_userService=UsersService();
      List<Video> _items =  [
     
    
    ];
    List<Users>  _itemUser = [

    ];
    List<Comment> _comment=[];
    get items {
        return this._items;
    }

   get itemsUser {
        return this._itemUser;
    }
 get comment{
  return this._comment;
 }

List<Users> friend =[

];
 Future<void> fetchComments(String videoId) async{
         _comment= await _videosService.fetchComment(videoId);
         _comment.sort((a, b) => b.dateTime.compareTo(a.dateTime));
         print('------------------------------');
         print(_comment);
         print('------------------------------');

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
  Future<void> fetchProductsSearch(String search, int pagination) async{
    
        this._items = await _videosService.fetchProductsSearch(search,pagination);
           print(_items);
         _items.sort((a, b) => b.dateTime.compareTo(a.dateTime));

         await   this.fetchUser(search, pagination);
          notifyListeners();
     

}
Future<void> fetchUser(String search, int pagination) async{
    
        this._itemUser = await _userService.fetchAllUser(search,pagination);
        print('12222222222222222222222222222222222222222222222222211111111111111');
           print(_itemUser);
        print('12222222222222222222222222222222222222222222222222211111111111111');

          // notifyListeners();
     

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
Future<void> fetchFriend(List<dynamic> friendsId ,String id) async{
    
        this.friend = await _userService.fetchUsers(friendsId,id);
        // print('12222222222222222222222222222222222222222222222222211111111111111');
        //   //  print(_itemUser);
        // print('12222222222222222222222222222222222222222222222222211111111111111');

          notifyListeners();
     

}
get Count {
  return this._items.length;
}
get CountUser{
  return this._itemUser.length;
}

 
}