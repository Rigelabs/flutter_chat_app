import 'package:chat_app/views/Signin.dart';
import 'package:chat_app/views/Signup.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;
  void toogleView(){
    setState(() {
      showSignIn =! showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn){
      return SignIn(toogleView);
    }else{
      return SignUp(toogleView);
    }
  }
}
