import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:social_video/services/video.dart';
import 'package:social_video/ui/pages/login/auth_manager.dart';
import 'package:video_player/video_player.dart'; 
import 'package:firebase_storage/firebase_storage.dart';
import 'package:provider/provider.dart';

class PostVideoScreen extends StatefulWidget{

    PostVideoScreen({Key? key});

  @override
  State<PostVideoScreen> createState() => _PostVideoScreenState();
}

class _PostVideoScreenState extends State<PostVideoScreen> {
    XFile? i;
  String? image;
 List<String> list = ['cafe', 'food', 'walk', 'football','travel','music','movie','camping'];
  String dropdownValue = 'cafe';

  File? tmp;
  VideosService videosService = VideosService();
var _videoPlayerController;
   late  Future<void> _initializeVideoPlayerFuture;
 final _titleController = TextEditingController();
 final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  final String _bucketUrl = 'gs://ct550-project.appspot.com';

  Future<void> uploadVideo(File file,String id,String title, String tag) async {
    try {
      // Lấy định danh tệp tin trên Firebase Storage
      String fileName = basename(file.path);
      String firebasePath = 'videos/${tag}/${id}/$fileName';
      Reference reference = _firebaseStorage.ref().child(firebasePath);

      // Tải tệp tin lên Firebase Storage
      UploadTask task = reference.putFile(file);
      TaskSnapshot snapshot = await task;
      String downloadUrl = await snapshot.ref.getDownloadURL();

      print('File $fileName has been uploaded. Url: $downloadUrl');

      videosService.postVideo(title,downloadUrl,id);
    } on FirebaseException catch (e) {
      print('Error uploading file: $e');
    }
  }


Future<int> postVideo(String? id) async{
 

  // THONG TIN
    // String day = '${DateTime.now()}';
    print(dropdownValue);
    var title= _titleController.text;
      print('title $title');
      
    if(title==''){
      
      return 0;
    }
  
      if(tmp!=null){
      uploadVideo(tmp!,id!,title,dropdownValue);

      }
    return 1;

   
 
    }
  





     Future pickImage() async{
      
           i = await ImagePicker().pickVideo(source: ImageSource.camera);

            if(i!= null){
            
                image=i!.path;
                print('999999999999999999999999999999999999999999999999999 ${image}');
                tmp =File(i!.path);
               
                setState(() {
                  
                });
            }
        }
      Future pickImageGallery() async{
      
         i = await ImagePicker().pickVideo(source: ImageSource.gallery);
          print(i);
            if(i!= null){
              
               tmp =File(i!.path);
                image=i!.path;
                print('-------------------------------------------${image}');
                setState(() {
                  
                });
            }
        }
 
        void initState(){
          
   

    
        }
          void dispose() {
    super.dispose();
    this.image=null;
    _videoPlayerController.dispose();
  }

    Widget build(BuildContext context){

      return Scaffold(
        appBar: AppBar(
          title: Text('Đăng bài viết'),
          centerTitle: true,
            backgroundColor: Colors.red,

        ),
        body: SingleChildScrollView(
          child: Center(
              child: Column(
                children: [
                  SizedBox(height: 12,),
                  Row(
                    children: [
                     Padding(padding: EdgeInsets.only(left: 38),
                     child:   DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
        });
      },
      items: list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    ),
                     
                     ),
        Expanded(child: 
         Padding(
          padding: const EdgeInsets.only(right: 38,top: 8,bottom: 8,left: 8),
          child: TextFormField(
          controller: _titleController,
            decoration: const InputDecoration(
              
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8))
              ),
              labelText: 'Mô tả video',
            ),
          ),
        ),
        )
        
                    ],
                  )
                  ,
                  

                VideoFrame(),
                SizedBox(height: 1,),
     Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FloatingActionButton(
      backgroundColor: Colors.red,
      onPressed: () async {
        if(image!=null){
   await  _videoPlayerController.dispose();

        }

                                pickImage();
     },
     child:  Icon(Icons.camera_alt ,size: 38,color: Colors.white,),
                      
     ),
    SizedBox(width: 8,)
     ,
     FloatingActionButton(
      backgroundColor: Colors.red,
      onPressed: () async{
       if(image!=null){
   await  _videoPlayerController.dispose();

        }
                                pickImageGallery();
     },
     child:  Icon(Icons.image ,size: 38,color: Colors.white,),
                      
     )
      ],
     )
          ,
                SizedBox(height: 1,),


                
                ElevatedButton(onPressed: () async {
                        print('dang');
                    int isSuccess=  await    postVideo(context.read<AuthManager>().authToken?.token);
                    if(isSuccess==0){
                        ScaffoldMessenger.of(context).showSnackBar(
                   SnackBar(content: Text('Falled'),duration: Duration(seconds: 2),),
            

        );
                    }else{
                          ScaffoldMessenger.of(context).showSnackBar(
                   SnackBar(content: Text('Success'),duration: Duration(seconds: 2),),
            

        );
                    }

                            },
                                       child:  Padding(padding: EdgeInsets.symmetric(horizontal: 30,vertical: 16),child:Text('Đăng bài viết',style: TextStyle(fontSize: 16),)),
                                        style:  ElevatedButton.styleFrom(backgroundColor: Colors.red),),
                ],
              ),
        ),
        )
      );
    }

  Widget VideoFrame(){
   if(image!=null){

  _videoPlayerController=  VideoPlayerController.file(tmp!);
  // _videoPlayerController.play();
          // _videoPlayerController.setLooping(true);
  _initializeVideoPlayerFuture= _videoPlayerController.initialize();


   }
      return       Container(
                      decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.9),
                        borderRadius: BorderRadius.all(Radius.circular(12))
                      )
                      ,
                      constraints: BoxConstraints.expand(
                      height: 360,
                      width: 280
                      ),
                      child: image==null ? Text('')  :  VideoPlayer(_videoPlayerController)
                    ) ;
  }
}