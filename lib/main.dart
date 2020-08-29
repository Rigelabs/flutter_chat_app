import 'package:chat_app/helpers/authenticate.dart';
import 'package:chat_app/helpers/helperfunctions.dart';
import 'package:chat_app/views/chatRoomScreen.dart';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
    bool userIsLoggedIn;
    @override
    void initState() {
      getLoggedInState();
      super.initState();
    }
    getLoggedInState() async{
      await HelperFunctions.saveUserLoggedInSharedPreference(true).then((val){
        setState(() {
          userIsLoggedIn=val;
        });
      });
    }

    @override
    Widget build(BuildContext context) {
      return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Color(0x1ff1F1F1F),
          primarySwatch: Colors.blue,

          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: userIsLoggedIn != null ? userIsLoggedIn ? ChatRoom(): Authenticate() :Authenticate(),
      );
    }
  }


class IamBlank extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

