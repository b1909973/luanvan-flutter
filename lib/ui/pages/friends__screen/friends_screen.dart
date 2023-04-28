import 'package:flutter/material.dart';

class FriendsScreen extends StatelessWidget{

   const FriendsScreen({super.key});

  @override
  Widget build(BuildContext context) {
        return 
        Container(

          decoration: BoxDecoration(
            color: Color.fromARGB(96, 17, 16, 16)
          ),
          child: Padding(
            
            padding: EdgeInsets.all(16),
            child:  Column(
            
            children: [
                buildSearchFriend(),
                const SizedBox(height: 12,)
                ,
             Expanded(
                child: ListView.separated(itemBuilder: (context, index) => buildFriend(), separatorBuilder: (context, index) => const Divider(), itemCount: 10),

             )

                
            ],
          ),
          
        ),
        );
          
  }
Widget buildFriend(){
  return     Padding(padding: EdgeInsets.symmetric(vertical: 8),
                  child:    Row(
                  children: [
                   const CircleAvatar(
                      backgroundImage: NetworkImage('https://picsum.photos/id/237/200/300'),
                      radius: 30,
                    ),
                  const  SizedBox(width: 20,),
                 const   Text('Lena Griffin',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  const   Spacer(),
                  


                    
                    
                    ElevatedButton(
                      
                      
            style: ElevatedButton.styleFrom(
             shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
              
                backgroundColor: Colors.grey[100], 
                foregroundColor: Colors.black,
                textStyle: TextStyle(
                  fontWeight: FontWeight.bold
                )
                
                ),
            onPressed: () {},
            child: const Text('Unfriend'),
            
          ),
        

                  ],
                )
                  );
}

  Widget buildSearchFriend(){
    return   Padding(padding: EdgeInsets.all(0),
                child:  TextField(
              decoration: InputDecoration(
                  
                  
                        filled: true,
                      fillColor: Color.fromARGB(255, 237, 236, 230), 
                      border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(60.0),
                    borderSide: BorderSide.none
                    
                  ),
                      hintText: 'Search',
                     
                    
                      
  )
              ),
                
                );
  }

}