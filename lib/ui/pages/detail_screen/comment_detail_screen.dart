
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:social_video/ui/pages/feed_screen/CommentGrid.dart';
import 'package:social_video/ui/pages/video_manager.dart';
import '../../../models/comment.dart';
class CommentDetailScreen extends StatefulWidget{
      final String videoId;
    CommentDetailScreen({Key? key,required this.videoId});

  @override
  State<CommentDetailScreen> createState() => _CommentDetailScreenState();
}

class _CommentDetailScreenState extends State<CommentDetailScreen> {
  late Future<void> _fetchComment;
    void initState(){
      super.initState();
      _fetchComment = context.read<VideosManager>().fetchComments(widget.videoId);
    }
  Widget build(BuildContext context){
    print(_fetchComment);
        return  FutureBuilder(
                  future: _fetchComment,
                  builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                
                  return   CommentGird(videoId: widget.videoId,);
                  
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                
                  return  const Center(
                  child: CircularProgressIndicator(),
                  );
                  
                  }
                  return const Center(
                  child: CircularProgressIndicator(),
                  );
                  },
                  ) ;
    
      }
}
 
  