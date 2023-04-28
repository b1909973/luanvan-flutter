import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
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
 
    get items {
        return this._items;
    }

   get itemsUser {
        return this._itemUser;
    }


  Future<void> fetchProductsSearch(String search) async{
    
        this._items = await _videosService.fetchProductsSearch(search);
           print(_items);
         await   this.fetchUser(search);
          notifyListeners();
     

}
Future<void> fetchUser(String search) async{
    
        this._itemUser = await _userService.fetchAllUser(search);
        print('12222222222222222222222222222222222222222222222222211111111111111');
           print(_itemUser);
        print('12222222222222222222222222222222222222222222222222211111111111111');

          // notifyListeners();
     

}

get Count {
  return this._items.length;
}
get CountUser{
  return this._itemUser.length;
}

 
}