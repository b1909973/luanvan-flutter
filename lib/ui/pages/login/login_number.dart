import 'package:flutter/material.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_video/ui/pages/login/login_vertify.dart';

class LoginNumber extends StatefulWidget{
  static const routeName ='/login';

    const LoginNumber({Key? key});
 static String vertify='';
  @override
  State<LoginNumber> createState() => _LoginNumberState();
}

class _LoginNumberState extends State<LoginNumber> {
  String _number='';

Widget build(BuildContext context){
      print("set state");

    return Scaffold(
      appBar: AppBar(
        title: Text('Nhập số điện thoại'),
        backgroundColor: Colors.red,
      ),
      body:VertifyContainer(),
    );

}



login() async{
 FirebaseAuth auth = FirebaseAuth.instance;
       print(_number);
      // ConfirmationResult confirmationResult = await auth.signInWithPhoneNumber('+84 858 235 239');
      
        await auth.verifyPhoneNumber(
  phoneNumber: _number,
  timeout: const Duration(seconds: 60),
  codeAutoRetrievalTimeout: (String verificationId) {
    // Auto-resolution timed out...
  },
  verificationCompleted: (phoneAuthCredential) {
  
  print('sucessssssssssssssssssssssssssssssssssssss');
      
  },
  verificationFailed: (error) {
     ScaffoldMessenger.of(context).showSnackBar(
                               SnackBar(content: Text('Falled!'),duration: Duration(seconds: 2),),
                               );
        
    print('false ------------------------------------------');
  },
  codeSent: (verificationId, forceResendingToken) {
    LoginNumber.vertify=verificationId;
      print(LoginNumber.vertify);
          Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const LoginVetify()),
  );
  },

);
     


 


}

Widget VertifyContainer(){
// String defaultCountryCode = '+84';
    return Center(

      child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
        children: [
             InternationalPhoneNumberInput(
                
               
          selectorConfig: SelectorConfig(
              
              
            selectorType: PhoneInputSelectorType.BOTTOM_SHEET
          ),
          formatInput: false,
          onInputChanged: (value) {
            setState(() {
              _number=value.phoneNumber!;
            });
              print(_number);

        },
        // initialValue: PhoneNumber(isoCode: defaultCountryCode.replaceAll('+', '')),
        
        ), 
        SizedBox(height: 100,),
        MaterialButton(onPressed: () {
         login();
        //  +84392357354
     
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)
        ,
        
        ),
        padding: EdgeInsets.symmetric(vertical: 15,horizontal: 30),
        color: Colors.red,
        child: Text('Request OTP' ,style: TextStyle(color: Colors.white),),
        
        )

        ],
      ),
    );
}
}