
import 'package:chips_choice/chips_choice.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_video/models/auth.dart';
import 'package:social_video/services/user.dart';
import 'package:social_video/services/video.dart';
import 'package:social_video/ui/pages/login/auth_manager.dart';
import 'dart:io'; 



class SettingProfile extends StatefulWidget{
      static const routeName ='/setting';
      List<dynamic> favorites;
    SettingProfile({super.key,required this.favorites});

  @override
  State<SettingProfile> createState() => _SettingProfileState();
}

class _SettingProfileState extends State<SettingProfile> {
    String? image;

  XFile? i;

  File? tmp;
   List<String> tags=[];
      @override
      void initState() {
        super.initState();
 tags = List<String>.from(widget.favorites);
        
      }
List<String> options = [
  'cafe', 'food', 'walk',
  'football', 'travel', 'music',
  'movie', 'camping'
];
 final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  final String _bucketUrl = 'gs://ct550-project.appspot.com';

Future<bool> uploadAvatar(File file,String id,String name,BuildContext context)async {

    try {
      // Lấy định danh tệp tin trên Firebase Storage
      String fileName = basename(file.path);  
      String firebasePath = 'images/avatar/${name}/$fileName';
      Reference reference = _firebaseStorage.ref().child(firebasePath);

      // Tải tệp tin lên Firebase Storage
      UploadTask task = reference.putFile(file);
      TaskSnapshot snapshot = await task;
      String downloadUrl = await snapshot.ref.getDownloadURL();

      print('File $fileName has been uploaded. Url: $downloadUrl');
VideosService videosService =VideosService();

    bool a=  await videosService.updateAvatar(downloadUrl,id); 
     context.read<AuthManager>().authToken!.user.PhotoURL=downloadUrl;
         return a;
    } on FirebaseException catch (e) {
      print('Error uploading file: $e');
      return false;
    }
  }

  Future<bool> postAvatar(String? id,String name,BuildContext context) async{
 

  // THONG TIN
    // String day = '${DateTime.now()}';
   
  
    
      return await uploadAvatar(tmp!,id!,name,context);

      }
   
  

    Widget build(BuildContext context){
        
        return Scaffold(
            appBar: AppBar(
            title: Text('Sửa hồ sơ' ,style: TextStyle(color: Colors.black, fontSize: 16),) ,
            centerTitle:true,
            
        backgroundColor: Colors.white,),
        body: SettingWidget(context)
        );


    }


      Future pickImage(BuildContext context) async{
      
          i = await ImagePicker().pickImage(source: ImageSource.camera);

            if(i!= null){
            
                image=i!.path;
                print(image);
                tmp =File(i!.path);
               
              bool a= await postAvatar(context.read<AuthManager>().authToken?.token,context.read<AuthManager>().authToken!.user.name,context);
                if(a){
                    
                                   ScaffoldMessenger.of(context).showSnackBar(
                               SnackBar(content: Text('Cập nhật thành công'),duration: Duration(seconds: 2),),
                                   );

                }
                setState(() {
                  
                });
            }
        }
         Future pickImageGallery(BuildContext context) async{
      
          i = await ImagePicker().pickImage(source: ImageSource.gallery);

            if(i!= null){
              
               tmp =File(i!.path);
                image=i!.path;
                print('11111111111111111111111111111111111111111111111111111111111111');
                print(image);
            bool a= await     postAvatar(context.read<AuthManager>().authToken?.token,context.read<AuthManager>().authToken!.user.name,context);

                if(a){
                    
                                   ScaffoldMessenger.of(context).showSnackBar(
                               SnackBar(content: Text('Cập nhật thành công'),duration: Duration(seconds: 2),),
                                   );

                }
                setState(() {
                  
                });
            }
        }

Widget SettingWidget(BuildContext context){


  AuthToken auth = context.read<AuthManager>().authToken!;

    TextEditingController name = TextEditingController(text: auth.isValid ? auth.user.name : '');
      TextEditingController nickName = TextEditingController(text: auth.isValid ? auth.user.nickname : '');
        TextEditingController email = TextEditingController(text: auth.isValid ? auth.user.email: '');

  return SingleChildScrollView(
            
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start
              ,
              children: [
                SizedBox(height: 30,),
                 GestureDetector(
                 
                  child:  CustomCircleAvatar(auth.user.PhotoURL),
                  onTap: () {
                    print('a');
            
            showDialog (
    context : context ,
    builder : (ctx) => AlertDialog (
      title : const Text( 'Are you sure? ' ) ,
   
      content : SizedBox(
        height: 120,
        child: Column(
        children: [
          Row(
   
      children: [
        FloatingActionButton(
      backgroundColor: Colors.red,
      onPressed: () async {
     

                                pickImage(context);
                                 Navigator.of(ctx).pop(false) ;

     },
     child:  Icon(Icons.camera_alt ,size: 38,color: Colors.white,),
                      
     ),
    SizedBox(width: 8,)
     ,
      Text('Camera')
      ],
     ) ,

     SizedBox(height: 8,),
     Row(
   
      children: [
        FloatingActionButton(
      backgroundColor: Colors.red,
      onPressed: () async {
     

                                pickImageGallery(context);
                                 Navigator.of(ctx).pop(false) ;

     },
     child:  Icon(Icons.picture_in_picture_alt_outlined ,size: 38,color: Colors.white,),
                      
     ),
    SizedBox(width: 8,)
     ,
      Text('Thư viện')
      ],
     ) ,
        ],
      ),
      ),
      actions : <Widget>[
        TextButton (
          child : const Text('No') ,
          onPressed : ( ) {
             Navigator.of(ctx).pop(false) ;
          }
       ) ,
        
       TextButton (
          child : const Text('Yes') ,
          onPressed : () {
             Navigator.of(ctx).pop(true);
    
         } ,
       ) ,
      ],
    ),
  );


            
            }),
                  SizedBox(height: 14,),
               
           
                  SizedBox(height: 12,)
                  ,
               
                  
                                // Text('Follow me to teah u fishing'),
                                // Text('Thx for your follow'),
                
                  
                  
                   Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        
          ChipsChoice<String>.multiple(
        wrapped: true,
    value: tags.toList(),
    onChanged: (val) => setState(() => tags = val),
    choiceItems: C2Choice.listFrom<String, String>(
      source: options,
      value: (i, v) => v,
      label: (i, v) => v,
    ),
  )
        


      ,
         Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: TextFormField(
            controller:name ,
            decoration: const InputDecoration(
              
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(32))
              ),
              labelText: 'Tên của bạn',
            ),
          ),
        ),
         Padding(
          
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: TextFormField(
            controller: nickName,
            cursorColor: Colors.red,
          
            
            decoration: const InputDecoration(
           
              border: OutlineInputBorder(
                
                borderRadius: BorderRadius.all(Radius.circular(32))
              ),
              labelText: 'Biệt danh của bạn',
            ),
          ),
        ),

          Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: TextFormField(
            controller: email,
            cursorColor: Colors.red,
          
            
            decoration: const InputDecoration(
           
              border: OutlineInputBorder(
                
                borderRadius: BorderRadius.all(Radius.circular(32))
              ),
              labelText: 'Email',
            ),
          ),
        ),
        SizedBox(height: 24,)
        ,
         Center(
        
          child: ElevatedButton(onPressed: () {
                           updateInfo(name,nickName,email,context,tags);
                              
                            },
                                       child:  Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 30,vertical: 20),
                                        child:Text('Cập nhật'),
                                        
                                        ),
                                        style: ButtonStyle(
                                          backgroundColor:MaterialStateProperty.all(
                                            Colors.red
                                          ),
                                          
  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(32.0),
     
      
    )
  )
),
          ))
         
                           
      ],
    )
                       


                   
                

             
                
              ],
              
            ),
            
      );
}

}

updateInfo(TextEditingController name,TextEditingController nickName, TextEditingController email,BuildContext context, List<String> tags)async {
      UsersService usersService = UsersService();

     print(name.text);
                              print(nickName.text);
                              print(email.text);
                            if(name.text=='' || nickName.text=='' || email.text==''){
                          
                                   ScaffoldMessenger.of(context).showSnackBar(
                               SnackBar(content: Text('Thông tin không hợp lệ!'),duration: Duration(seconds: 2),),
                               
        );
        return;
                            }
                        bool isSuccess=     await  usersService.updateUser((context.read<AuthManager>().authToken?.token)!, name.text, nickName.text, email.text,tags);
                    await    context.read<AuthManager>().login((context.read<AuthManager>().authToken?.token)!);

                        switch (isSuccess) {
                          case true:
                                ScaffoldMessenger.of(context).showSnackBar(
                               SnackBar(content: Text('Cập nhật thành công!'),duration: Duration(seconds: 2),),
                               );
        
                            
                            break;
                          default:
                           ScaffoldMessenger.of(context).showSnackBar(
                               SnackBar(content: Text('Thông tin không hợp lệ!'),duration: Duration(seconds: 2),),
                               
        );
                        }


}




   Widget CustomCircleAvatar(String? PhotoURL){
       
        return  Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [

                PhotoURL==null ? 
                   Container(
                    constraints: BoxConstraints.expand(
                      height: 100.0,
                      width: 100.0
                    )
                  ,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.all(Radius.circular(100)),
                    border: Border.all(width: 2,color: Colors.white)
                  ),
                  child:  Icon(Icons.camera_alt,color: Colors.white,)
                ):  
                CircleAvatar(
                      backgroundImage: NetworkImage(PhotoURL),
                      radius: 60,
                    ) ,
                
                SizedBox(height: 12,),
                Text('Thay đổi ảnh')

              ],
            )
          
          ],
        );
      }