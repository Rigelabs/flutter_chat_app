import 'package:chat_app/helpers/authenticate.dart';
import 'package:chat_app/helpers/constants.dart';
import 'package:chat_app/helpers/helperfunctions.dart';
import 'package:chat_app/services/auth.dart';
import 'package:chat_app/views/search.dart';

import 'package:flutter/material.dart';

class ChatRoom extends StatefulWidget {
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  AuthMethods authMethod = new AuthMethods();
  @override
  void initState(){
    getUserInfo();
    super.initState();
  }
  getUserInfo() async{
    Constants.myName = await HelperFunctions.getUserNameSharedPreference("userName");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/images/logo.png', height: 50,),
      actions: [
        GestureDetector(
          onTap: () {
              authMethod.signOut();
              Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context)=> Authenticate()
              ));
          },
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child:
              Icon(Icons.exit_to_app)),
        )
      ],),
     floatingActionButton: FloatingActionButton(
       child:
            Icon(Icons.search),
            onPressed: (){
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => SearchScreen(),
                ));
            },
     ),
    );
  }
}
