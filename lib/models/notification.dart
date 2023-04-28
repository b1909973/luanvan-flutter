import 'package:cloud_firestore/cloud_firestore.dart';

class Notification {
  final String id;
  final String title;
  final String message;
  final DateTime time;

  Notification({
    required this.id,
    required this.title,
    required this.message,
    required this.time,
  });

  factory Notification.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String,dynamic>;
    return Notification(
      id: snapshot.id,
      title: data['title'],
      message: data['message'],
      time: (data['time'] as Timestamp).toDate(),
    );
  }
}