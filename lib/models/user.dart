
class Users{
    final String? id;
    // final String phone;
    final String name;
    final String? email;
    final bool tick;
    final String? nickname;
    final List<dynamic>? like ;
    final List<dynamic>?  Follower ;
    final List<dynamic>? Following;
     String? PhotoURL;
    final List<dynamic>? favorites;
     Users({this.id,required this.name,required this.email,this.PhotoURL ,required this.nickname,required  this.like,required this.Follower,required this.Following, this.tick =false,this.favorites});

    
    Users coppyWith({String? id,String? phone,String? name, List<String>? like,String? nickname ,String? email ,List<String>? Follower,  List<String>? Following,bool? tick ,List<String>? favorites}){
      return  Users(id: id,name: name ?? this.name,PhotoURL: this.PhotoURL, Follower: Follower ?? this.Follower,Following: Following ?? this.Following, like:like ?? this.like ,nickname: nickname ?? this.nickname,email: email ?? this.email,tick:tick ?? this.tick ,favorites: favorites ?? this.favorites);
    }

   



}