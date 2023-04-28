
import 'package:social_video/models/message.dart';

class Conversations{
    final String cid;
    // final String phone;
    final List<dynamic> members;
    final String timestamp;
    final  List<Message> message;
      final totalMessages;

    const Conversations( {required this.cid,required this.members, required this.timestamp, required this.totalMessages, required this.message});

    
    



}