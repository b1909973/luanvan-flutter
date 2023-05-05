
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:social_video/ui/pages/discover_screen/CommentSearchGrid.dart';
import 'package:social_video/ui/pages/discover_screen/search_manager.dart';
import 'package:social_video/ui/pages/feed_screen/CommentGrid.dart';
import 'package:social_video/ui/pages/video_manager.dart';
import '../../../models/comment.dart';
class CommentSearchScreen extends StatefulWidget{
      final String videoId;
    CommentSearchScreen({Key? key,required this.videoId});

  @override
  State<CommentSearchScreen> createState() => _CommentSearchScreenState();
}

class _CommentSearchScreenState extends State<CommentSearchScreen> {
  late Future<void> _fetchComment;
    void initState(){
      super.initState();
      _fetchComment = context.read<SearchManager>().fetchComments(widget.videoId);
    }
  Widget build(BuildContext context){
    print(_fetchComment);
        return  FutureBuilder(
                  future: _fetchComment,
                  builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                
                  return   CommentSearchGird(videoId: widget.videoId);
                  
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
 
  