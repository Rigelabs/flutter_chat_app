import 'package:flutter/material.dart';

Widget appBarMain(BuildContext context){
  return AppBar(
    title: Image.network(
      'https://github.com/flutter/plugins/raw/master/packages/video_player/video_player/doc/demo_ipod.gif?raw=true',
      width: double.infinity,
    ),


  );
}

InputDecoration textFieldInputDecoration(String hintText){
  return  InputDecoration(hintText: hintText,hintStyle: TextStyle(color: Colors.white),
      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.limeAccent),
      ),
      enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.blueAccent)
      )
  );
}

TextStyle simpleTextStyle(){
  return TextStyle(
    color: Colors.white
  );
}

TextStyle mediumTextStyle (){
  return TextStyle(
                    color: Colors.white70,
                    fontSize: 16
  );
}