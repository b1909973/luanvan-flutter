import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:social_video/models/conversations.dart';
import 'package:social_video/models/user.dart';
import 'package:social_video/services/user.dart';
import 'package:social_video/services/video.dart';


class ChatManager with ChangeNotifier{
 final UsersService _userService;

  ChatManager() : _userService = UsersService();

  
      List<Users> _items =  [

    
    ];

 List<Map<Users,Conversations>>  _users =[];

      
   
     
    get items {
        return this._items;
    }
    get users {
      return this._users;
    }
    

//   Future<void> fetchUsers(List<dynamic> followingId,String id) async{
    
//          this._items = await _userService.fetchUserss(followingId,id);
//            print(_items);
//           notifyListeners();
     

// }
  Future<void> fetchUserss(List<dynamic> followingId,String id) async{
    
         this._users = await _userService.fetchUserss(followingId,id);
           print(_items);
          notifyListeners();
     

}

 

get Count {
  return this._items.length;
}



 
}