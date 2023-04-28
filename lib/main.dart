import 'package:flutter/material.dart';
import 'package:social_video/ui/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:social_video/ui/pages/chat__screen/chat_manager.dart';
import 'package:social_video/ui/pages/detail_screen/detail_screen.dart';
import 'package:social_video/ui/pages/detail_screen/video_grids_detail.dart';
import 'package:social_video/ui/pages/discover_screen/search_manager.dart';
import 'package:social_video/ui/pages/feed_screen/feed_screen.dart';
import 'package:social_video/ui/pages/feed_screen/video_grid_item.dart';
import 'package:social_video/ui/pages/login/auth_manager.dart';
// import 'package:social_video/ui/pages/login/login_vertify.dart';
import 'package:social_video/ui/pages/login/login_number.dart';
import 'package:social_video/ui/pages/notification/notification_screen.dart';
import 'package:social_video/ui/pages/post_video/post_video_screen.dart';
import 'package:social_video/ui/pages/profile_screen/setting_profile.dart';
import './ui/pages/video_manager.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
   
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(

        providers: [
          ChangeNotifierProvider(
            create: (ctx) =>VideosManager()
            ),
            ChangeNotifierProvider(
            create: (ctx) =>ChatManager()
            ),
          
          ChangeNotifierProvider(
            create: (ctx) => AuthManager(),
          ),
           ChangeNotifierProvider(
            create: (ctx) =>SearchManager()
            ),
          
        ],
        child:   Consumer<AuthManager>(
        builder: (context,authManager,child) {
      
       return MaterialApp(
        debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
      
        primarySwatch: Colors.blue,
      ),
      home:HomeScreen(),
        routes: {
        HomeScreen.routeName:
          (ctx) =>  HomeScreen(),
        LoginNumber.routeName:
          (ctx) =>  LoginNumber(),
      
           NotificationScreen.routeName:
        (ctx)=> NotificationScreen(),
      
       
      },
     
    );
    
    
    })
        
    );
  // return  MaterialApp(
  //     title: 'Flutter Demo',
  //     debugShowCheckedModeBanner: false,
  //     theme: ThemeData(
    
  //       primarySwatch: Colors.blue,
  //     ),
  //     home: PostVideoScreen(),
  // );

}
}

  
  