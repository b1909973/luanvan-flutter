import 'package:cloud_firestore/cloud_firestore.dart';

class ChatService {
  final CollectionReference _conversationsCollection =
      FirebaseFirestore.instance.collection('conversations');

  Future<void> sendMessage(Message message, String conversationId) async {
    await _conversationsCollection.doc(conversationId).update({
      'messages': FieldValue.arrayUnion([
        {
          'senderId': message.senderId,
          'text': message.text,
          'timestamp': message.timestamp,
        }
      ])
    });
  }

  Stream<List<Message>> getMessages(String conversationId) {
    return _conversationsCollection
        .doc(conversationId)
        .snapshots()
        .map((DocumentSnapshot snapshot) {
      List<Message> messages = [];
      if (snapshot.exists) {
        Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
        if (data['messages'] != null) {
          for (var msg in data['messages']) {
            Message message = Message.fromJson(msg as Map<String, dynamic>);
            messages.add(message);
          }
        }
        messages.sort((a, b) => a.timestamp.compareTo(b.timestamp));
      }
      return messages;
    });
  }

  Future<void> deleteMessage(Message message, String conversationId) async {
    await _conversationsCollection.doc(conversationId).update({
      'messages': FieldValue.arrayRemove([
        {
          'senderId': message.senderId,
          'text': message.text,
          'timestamp': message.timestamp,
        }
      ])
    });
  }
}

class Message {
  final String senderId;
  final String text;
  final int timestamp;

  Message({
    required this.senderId,
    required this.text,
    required this.timestamp,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      senderId: json['senderId'],
      text: json['text'],
      timestamp: json['timestamp'],
    );
  }

  Map<String, dynamic> toJson() =>
      {'senderId': senderId, 'text': text, 'timestamp': timestamp};
}
