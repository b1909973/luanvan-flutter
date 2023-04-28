import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_video/models/user.dart';

import '../models/auth.dart';


class AuthService{


  Future<bool> fetchUser(String id) async {
      bool isTrue= false;
      try {
           CollectionReference users = FirebaseFirestore.instance.collection('users');
  await users.where('uid',isEqualTo: id).get().then((QuerySnapshot querySnapshot) {
      print('===================================================================');
        if(querySnapshot.docs[0].data().toString().contains('name')){
            isTrue=true;
      }
     print(  querySnapshot.docs[0].data().toString()) ;
      print('===================================================================');
    
    });
    return isTrue;
    
      } catch (e) {
        print('Errr0==================== ${e}');
        return false;
      }
   


    }

  Future<AuthToken>  login(String uid) async {

 try {
           CollectionReference users = FirebaseFirestore.instance.collection('users');

 AuthToken a =  await users.where('uid',isEqualTo: uid).get().then((QuerySnapshot querySnapshot) {
      Users u = Users(
          name:querySnapshot.docs[0].data().toString().contains('name') ?querySnapshot.docs[0]['name'] : '',
         email:querySnapshot.docs[0].data().toString().contains('email') ? querySnapshot.docs[0].get('email') :  '', 
         nickname:querySnapshot.docs[0].data().toString().contains('nickname') ? querySnapshot.docs[0]['nickname'] : '',
          like: querySnapshot.docs[0].data().toString().contains('likes') ? querySnapshot.docs[0].get('likes') :  [] ,
           Follower: querySnapshot.docs[0].data().toString().contains('followers') ? querySnapshot.docs[0].get('followers') :   [],
         Following:querySnapshot.docs[0].data().toString().contains('following') ? querySnapshot.docs[0].get('following') :   [],
         PhotoURL: querySnapshot.docs[0].data().toString().contains('photoURL') ?querySnapshot.docs[0]['photoURL'] : '',
         id: querySnapshot.docs[0]['uid']  ,
          tick:  querySnapshot.docs[0]['tick'],
          favorites: querySnapshot.docs[0].data().toString().contains('favorites') ? querySnapshot.docs[0].get('favorites') :   []
           );
      return AuthToken(token: uid, user: u);


    
    });
    print('7777777777777777777777777777777777777777777777777777777777777777777777');
    print(a.token);
    print(a.user.id);
    print('7777777777777777777777777777777777777777777777777777777777777777777777');

      return a;
      } catch (e) {
        print('Errr0==================== ${e}');
      return AuthToken(token: null);

      }
   

     }

  



}