import 'package:flutter/material.dart';

class showLogin extends StatelessWidget{

    showLogin({Key? key});


    Widget build(BuildContext context){

        return   Stack(
                            children: [
                             Positioned(
                               child:Align(child: Text('Đăng nhập để làm nhiều thứ hơn!',style: TextStyle(fontSize: 18,fontStyle: FontStyle.italic),),),
                              top: 220,
                              left: 50,
                              ),

                              
                           Align(
                            child:     ElevatedButton(onPressed: () {
                                                         Navigator.of(context).popAndPushNamed('/login');


                            },
                                       child:  Padding(padding: EdgeInsets.symmetric(horizontal: 30,vertical: 10),child:Text('Đăng nhập')),
                                        style:  ElevatedButton.styleFrom(backgroundColor: Colors.red),),
                           )
                            ],
                          );
    

    }



}