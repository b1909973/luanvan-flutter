import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:social_video/models/user.dart';
import 'package:social_video/services/auth.dart';
import 'package:social_video/services/user.dart';
import 'package:social_video/ui/pages/feed_screen/feed_screen.dart';
import 'package:social_video/ui/pages/login/auth_manager.dart';
import 'package:social_video/ui/pages/login/login_number.dart';
import '../../../models/user.dart';
import 'package:provider/provider.dart';

class LoginVetify extends StatefulWidget{
    const LoginVetify({Key? key});

  @override
  State<LoginVetify> createState() => _LoginVetifyState();
}

class _LoginVetifyState extends State<LoginVetify> {
  String _code='';

Widget build(BuildContext context){
      print("set state");

    return Scaffold(
      appBar: AppBar(
        title: Text('Vertify'),
      ),
      body: NumberContainer(),
    );

}

Widget NumberContainer(){

    return Center(
      
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
          children: [
              Text('Please enter OTP to vetify', style: TextStyle(
                fontSize: 20
              ),)
            ,
            SizedBox(height: 30,)
            ,
VerificationCode(
  fullBorder: mounted,
    textStyle: TextStyle(fontSize: 20.0, color: Colors.red[900]),
    keyboardType: TextInputType.number,
    underlineColor: Colors.amber, // If this is null it will use primaryColor: Colors.red from Theme
    length: 6,
    cursorColor: Colors.blue, // If this is null it will default to the ambient
    // clearAll is NOT required, you can delete it
    // takes any widget, so you can implement your design
    clearAll: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        'clear all',
        style: TextStyle(fontSize: 14.0, decoration: TextDecoration.underline, color: Colors.blue[700]),
      ),
    ),
    onCompleted: (String value) {
      print(value);
      setState(() {
        _code=value;
      });
 
    },
    onEditing: (bool value) {
   
    
    },
  ),
  TextButton(
    
    onPressed: ()async {
    print(_code.length);

    FirebaseAuth auth = FirebaseAuth.instance;

        PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: LoginNumber.vertify, smsCode: _code);
  try {
    // Sign the user in (or link) with the credential
    await auth.signInWithCredential(credential).then((UserCredential value) async {
      print(value.user);
    AuthService authService = AuthService();
  
           bool a= await authService.fetchUser(value.user!.uid).then((value) => value);
      print('11111111111111111111111111111111111111111111111111');
        print(a);
      print('11111111111111111111111111111111111111111111111111');

        if(a){
          context.read<AuthManager>().login(value.user!.uid);

         Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false);
        }else{

        }
      });
       
        
      // print('=====================================${value.user?.uid}');
   
    
    

    
          print('dung');
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Falled'),duration: Duration(seconds: 2),),
            

        );
        print('sai');
      }
  
    
  }, child: Text('Vertify'))
          ],
        ),

    );


}
}