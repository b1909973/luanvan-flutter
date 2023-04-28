import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:social_video/services/video.dart';
import '../../../models/comment.dart';

import '../../../models/video.dart';

class ProfileManager with ChangeNotifier{
 final VideosService _videosService;


  ProfileManager() : _videosService = VideosService();


      List<Video> _items =  [
      //  Video(id: '1',title:'Bai post moi' , id_user: '1', videoLink: 'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4' ,like:{'id_user':['u1','u2'],'numlike':'1'}, dateTime: '2002-12-1'),
      // Video(id: '2',title:'Bai post moi' , id_user: '1', videoLink: 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4' ,like:{'id_user':['u1','u2'],'numlike':'1'}, dateTime: '2002-12-1'),
      // Video(id: '3',title:'Bai post moi' , id_user: '1', videoLink: 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4' ,like:{'id_user':['u1','u2'],'numlike':'1'}, dateTime: '2002-12-1'),
      // Video(id: '4',title:'Bai post moi' , id_user: '1', videoLink: 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4' ,like:{'id_user':['u1','u2'],'numlike':'1'}, dateTime: '2002-12-1'),
      // Video(id: '5',title:'Bai post moi' , id_user: '1', videoLink: 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4' ,like:{'id_user':['u1','u2'],'numlike':'1'}, dateTime: '2002-12-1'),
    
    ];
  
    get items {
        return this._items;
    }
 
  Future<void> fetchProducts(int pagination) async{
        this._items = await _videosService.fetchProducts(pagination);
          //  print(_items);
          notifyListeners();
     

}

 
//   Future<void> fetchComments(int videoId) async{
//          _comment= await _videosService.fetchComment(videoId);
//          print('------------------------------');
//          print(_comment);
//          print('------------------------------');

//           notifyListeners();
     

// }
// get Count {
//   return this._items.length;
// }
}