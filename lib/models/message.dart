import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_video/models/user.dart';

class Message{
    final String senderId;
    final String text;
    final int timestamp;
   

    const Message({required this.senderId,required this.text,required this.timestamp});


    factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      text: map['text'] as String,
      senderId: map['senderId'] as String,
      timestamp: map['timestamp'] as int,
    );
  }
   

  factory Message.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
  
    return Message(
      senderId: data['senderId'],
      text: data['text'],
      timestamp: data['timestamp'],
    );
  }

}