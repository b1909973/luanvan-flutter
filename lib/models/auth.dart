import 'package:social_video/models/user.dart';

class AuthToken {
  final String? _token;
  final Users? _user;
 

  AuthToken({
    token,
    user
   
 
  })  : _token = token,_user=user;
        
     

  bool get isValid {
    return token != null;
  }

  String? get token {
   return _token;
  }
  Users get user{
    return _user!;
  }


  Map<String, dynamic> toJson() {
    return {
      'authToken': _token,
      // 'userId': _userId,
   
    };
  }

  static AuthToken fromJson(Map<String, dynamic> json) {
    return AuthToken(
      token: json['authToken'],
      // userId: json['userId'],
   
    );
  }
}
