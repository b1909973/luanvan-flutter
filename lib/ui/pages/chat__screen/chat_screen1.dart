
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// import 'package:social_video/models/message.dart';
import 'package:social_video/services/chat.dart';
import 'package:social_video/ui/pages/login/auth_manager.dart';


import 'package:provider/provider.dart';

class ChatScreen1 extends StatefulWidget {
  final String conversationId;

  ChatScreen1({required this.conversationId});

  @override
  _ChatScreen1State createState() => _ChatScreen1State();
}

class _ChatScreen1State extends State<ChatScreen1> {
  final ChatService _chatService = ChatService();
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
        backgroundColor: Colors.red,
        actions: [
          IconButton(
            icon: Icon(Icons.info),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<Message>>(
              stream: _chatService.getMessages(widget.conversationId),
              builder: (context, snapshot) {
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(
                    child: Text('No messages'),
                  );
                }

                return ListView.builder(
                  reverse: true,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final message = snapshot.data![snapshot.data!.length - 1 - index];
                    return _buildMessageItem(message);
                  },
                );
              },
            ),
          ),
          _buildInputTextField(),
        ],
      ),
    );
  }
    String convertToAgo(DateTime input){
  Duration diff = DateTime.now().difference(input);
  
  if(diff.inDays >= 1){
    return '${diff.inDays} day ago';
  } else if(diff.inHours >= 1){
    return '${diff.inHours} hour ago';
  } else if(diff.inMinutes >= 1){
    return '${diff.inMinutes} minute ago';
  } else if (diff.inSeconds >= 1){
    return '${diff.inSeconds} second ago';
  } else {
    return 'just now';
  }}

  // Widget _buildMessageItem(Message message) {
  //   final isMe = message.senderId == 'me';
  //   final avatar =  CircleAvatar(
  //       backgroundImage: NetworkImage('https://i.pravatar.cc/50?u=${message.senderId}'),
  //     );
  //   final backgroundColor = isMe ? Colors.green[300] : Colors.grey[200];
  //   final textColor = isMe ? Colors.white : Colors.black;
  //   final alignment = isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start;
  //   final radius = isMe
  //       ? BorderRadius.only(
  //           topLeft: Radius.circular(12),
  //           topRight: Radius.circular(0),
  //           bottomLeft: Radius.circular(12),
  //           bottomRight: Radius.circular(12),
  //         )
  //       : BorderRadius.only(
  //           topLeft: Radius.circular(12),
  //           topRight: Radius.circular(0),
  //           bottomLeft: Radius.circular(12),
  //           bottomRight: Radius.circular(12),
  //         );

  //   final messageContent = Column(
  //     crossAxisAlignment: alignment,
  //     children: [
  //       Text(message.text, style: TextStyle(color: textColor)),
  //       SizedBox(height: 4),
  //       Text(
  //         DateFormat('HH:mm dd/MM/yyyy').format(DateTime.fromMillisecondsSinceEpoch(message.timestamp)),
  //         style: TextStyle(fontSize: 12, color: textColor.withOpacity(0.6)),
  //       ),
  //     ],
  //   );

  //   if(isMe) {
  //     return Container(
  //       margin: EdgeInsets.only(left: 80, right: 8, bottom: 8),
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.end,
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Container(
  //             padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
  //             decoration: BoxDecoration(
  //               color: backgroundColor,
  //               borderRadius: radius,
  //             ),
  //             child: messageContent,
  //           ),
  //           if (isMe) Padding(
  //             padding: EdgeInsets.only(left: 8),
  //             child: avatar,
  //           ),
  //         ],
  //       ),
  //     );
  //   } else {
  //     return Container(
  //       margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.start,
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Padding(
  //             padding: EdgeInsets.only(right: 8),
  //             child: avatar,
  //           ),
  //           Container(
  //             padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
  //             decoration: BoxDecoration(
  //               color: backgroundColor,
  //               borderRadius: radius,
  //             ),
  //             child: messageContent,
  //           ),
  //         ],
  //       ),
  //     );
  //   }
  // }

 Widget _buildMessageItem(Message message) {
    final isMe = message.senderId == (context.read<AuthManager>().authToken?.token)!;
    final avatar = isMe ? null : CircleAvatar(
        backgroundImage: NetworkImage('https://i.pravatar.cc/50?u=${message.senderId}'),
      );
    final backgroundColor = isMe ? Colors.green[300] : Colors.grey[200];
    final textColor = isMe ? Colors.white : Colors.black;
    final alignment = isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    int ts = message.timestamp;
var dt = DateTime.fromMillisecondsSinceEpoch(ts);
var date = DateFormat('MM/dd/yyyy, hh:mm a').format(dt);
    final radius = isMe
        ? BorderRadius.only(
            topLeft: Radius.circular(0),
            topRight: Radius.circular(12),
            bottomLeft: Radius.circular(12),
            bottomRight: Radius.circular(12),
          )
        : BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(0),
            bottomLeft: Radius.circular(12),
            bottomRight: Radius.circular(12),
          );

    final messageContent = Column(
      crossAxisAlignment: alignment,
      children: [
        Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.40, // set a message height limit
            maxWidth: MediaQuery.of(context).size.width * 0.60 // set a message width limit
          ),
          child: Text(
            message.text,
            style: TextStyle(color: textColor),
            softWrap: true, // enable text wrapping
            overflow: TextOverflow.visible, // enable overflow when text dimensions exceed constraints limits
          ),
        ), 
        SizedBox(height: 4),
        Text(
          // DateFormat('HH:mm dd/MM/yyyy').format(DateTime.fromMillisecondsSinceEpoch(message.timestamp)),,
          convertToAgo(dt)
          ,
          style: TextStyle(fontSize: 12, color: textColor.withOpacity(0.6)),
        ),
      ],
    );

    if(isMe) {
      return Container(
        margin: EdgeInsets.only(left: 80, right: 8, bottom: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.60, // set a max width for each message content
              ),
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: radius,
              ),
              child: messageContent,
            ),
            if (isMe) Padding(
              padding: EdgeInsets.only(left: 8),
              child: avatar,
            ),
          ],
        ),
      );
    } else {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(right: 8),
              child: avatar,
            ),
            Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.60, // set a max width for each message content
              ),
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: radius,
              ),
              child: messageContent,
            ),
          ],
        ),
      );
    }
  }


  // Widget _buildMessageItem(Message message) {
  //   final isMe = message.senderId == (context.read<AuthManager>().authToken?.token)!;
  //   final backgroundColor = isMe ? Colors.green[300] : Colors.grey[200];
  //   final textColor = isMe ? Colors.white : Colors.black;
  //   final alignment = isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start;
  //   final radius = isMe
  //       ? BorderRadius.only(
  //           topLeft: Radius.circular(12),
  //           topRight: Radius.circular(0),
  //           bottomLeft: Radius.circular(12),
  //           bottomRight: Radius.circular(12),
  //         )
  //       : BorderRadius.only(
  //           topLeft: Radius.circular(0),
  //           topRight: Radius.circular(12),
  //           bottomLeft: Radius.circular(12),
  //           bottomRight: Radius.circular(12),
  //         );

  //   return
  //    Align(
  //     alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
  //     child:
  //      Container(
  //       margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
  //       padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
  //       decoration: BoxDecoration(
  //         color: backgroundColor,
  //         borderRadius: radius,
  //       ),
  //       child: Column(
  //         crossAxisAlignment: alignment,
  //         children: [
  //           Text(message.text, style: TextStyle(color: textColor)),
  //           SizedBox(height: 4),
  //           Text(
  //             DateFormat('HH:mm dd/MM/yyyy').format(DateTime.fromMillisecondsSinceEpoch(message.timestamp)),
  //             style: TextStyle(fontSize: 12, color: textColor.withOpacity(0.6)),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget _buildInputTextField() {
    return Container(
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: _controller,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                hintText: 'Aa',
                border: InputBorder.none,
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: _sendMessage,
          ),
          SizedBox(width: 8),
        ],
      ),
    );
  }

  void _sendMessage() async {
    final text = _controller.text.trim();

    if (text.isEmpty) {
      return;
    }

    final message = Message(
      senderId:(context.read<AuthManager>().authToken?.token)!,
      text: text,
      timestamp: DateTime.now().millisecondsSinceEpoch,
    );

    try {
      await _chatService.sendMessage(message, widget.conversationId);
      _controller.clear();
    } catch (e) {
      print('Error sending message: $e');
    }
  }
}




// class ChatScreen1 extends StatefulWidget {
//   final String conversationId;

//   ChatScreen1({required this.conversationId});

//   @override
//   _ChatScreen1State createState() => _ChatScreen1State();
// }

// class _ChatScreen1State extends State<ChatScreen1> {
//   final ChatService _chatService = ChatService();
//   final TextEditingController _controller = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Chat Screen'),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: StreamBuilder<List<Message>>(
//               stream: _chatService.getMessages(widget.conversationId),
//               builder: (context, snapshot) {
//                 if (!snapshot.hasData || snapshot.data!.isEmpty) {
//                   return Center(
//                     child: Text('No messages'),
//                   );
//                 }

//                 return ListView.builder(
//                   itemCount: snapshot.data!.length,
//                   itemBuilder: (context, index) {
//                     final message = snapshot.data![index];
//                     return ListTile(
//                       title: Text(message.text),
//                       subtitle:
//                           Text(DateFormat('HH:mm dd/MM/yyyy').format(DateTime.fromMillisecondsSinceEpoch(message.timestamp))),
//                     );
//                   },
//                 );
//               },
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: _controller,
//                     decoration: InputDecoration(
//                       border: OutlineInputBorder(),
//                       hintText: 'Enter a message',
//                     ),
//                   ),
//                 ),
//                 SizedBox(width: 8),
//                 ElevatedButton(
//                   onPressed: _sendMessage,
//                   child: Text('Send'),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   void _sendMessage() async {
//     final text = _controller.text.trim();

//     if (text.isEmpty) {
//       return;
//     }

//     final message = Message(
//       senderId: (context.read<AuthManager>().authToken?.token)!,
//       text: text,
//       timestamp: DateTime.now().millisecondsSinceEpoch,
//     );

//     try {
//       await _chatService.sendMessage(message, widget.conversationId);
//       _controller.clear();
//     } catch (e) {
//       print('Error sending message: $e');
//     }
//   }
// }
