import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_video/models/auth.dart';
import 'package:social_video/services/auth.dart';
import 'package:social_video/services/user.dart';



class AuthManager with ChangeNotifier {
  AuthToken? _authToken;
 

  final AuthService _authService = AuthService();

  bool get isAuth {
    return authToken != null && authToken!.isValid;
  }

  AuthToken? get authToken {
    return _authToken;
  }

   void set authToken(AuthToken? auth) {
      _authToken=auth;
  }
   Future<void> follow(String? id,String? uid) async{
      this._authToken!.user.Following!.add(uid);
    await UsersService().follow(uid, id);
  

  notifyListeners();

 }
 Future<void> unfollow(String? id,String? uid) async{
      this._authToken!.user.Following!.remove(uid);

    await UsersService().unfollow(uid, id);
  
  // notifyListeners();

 }





  void _setAuthToken(AuthToken token) {
    _authToken = token;
    print('he hai 88888888888888888888888888888888888888888888888888888888888888888888888 ${token.token}');
    // _autoLogout();
    notifyListeners();
  }

  login(String uid) async{
      _setAuthToken(await _authService.login(uid));
      notifyListeners();
  }


  Future<void> logout() async {
    _authToken = null;
  final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    notifyListeners();
   
  }
 


}
