import 'package:chat_app/helpers/constants.dart';
import 'package:chat_app/helpers/helperfunctions.dart';
import 'package:chat_app/services/database.dart';
import 'package:chat_app/views/conversationScreen.dart';
import 'package:chat_app/widgets/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}
String _myName;
class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchTextEditingController = new TextEditingController();
  DatabaseMethods databaseMethods = new DatabaseMethods();

  QuerySnapshot searchSnapshot;

  initiateSearch() {
    databaseMethods.
    getUserByUserName(searchTextEditingController.text).
    then((val) {
      setState(() {
        searchSnapshot = val;
      });
    });
  }

  Widget searchList(){
    return searchSnapshot != null ? ListView.builder(
      itemCount: searchSnapshot.documents.length,
        shrinkWrap: true,
        itemBuilder: (context,index){
        return SearchTile(
          userName: searchSnapshot.documents[index].data["name"],
          userEmail: searchSnapshot.documents[index].data["email"],
        );
        }):Container();
  }
  createChatRoomAndStartConversation(String userName){
    String chatRoomId = getChatRoomId(userName,Constants.myName);
    List<String> users=[userName,Constants.myName];
    Map<String, dynamic> chatRoomMap={
      "users": users,
      "chatRoomId":chatRoomId
    };
    DatabaseMethods().createChatRoom(chatRoomId,chatRoomMap);
    Navigator.push(context, MaterialPageRoute(
        builder: (context)=> ConversationScreen(chatRoomId)
    ));
  }
  Widget SearchTile( {String userName,String userEmail}){
    return Container(
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Text(userName,style: simpleTextStyle(),),
              Text(userEmail,style: simpleTextStyle(),)

            ],
          ),
          Spacer(),
          GestureDetector(
            onTap: (){
              createChatRoomAndStartConversation(userName);
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
              decoration: BoxDecoration(
                color: Colors.blue, borderRadius: BorderRadius.circular(30),
              ),
              child: Text("Message"),
            ),
          )
        ],
      ),
    );
  }

    @override
    void initState(){
      getUserInfo();
      super.initState();
    }
    getUserInfo() async{
     _myName = await HelperFunctions.getUserNameSharedPreference('userName');
     setState(() {

     });
    }
    @override
    Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Image.asset('assets/images/logo.png', height: 50,),
    ),
    body: Container(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24,vertical: 16),
              color: Colors.black12,
              child: Row(

                children: [
                  Expanded(child: TextField(
                    controller: searchTextEditingController,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(hintText: "search user",
                                                hintStyle: TextStyle(color: Colors.white54),
                                                border: InputBorder.none ),
                  )
                  ),
                  GestureDetector(
                    onTap: (){
                      initiateSearch();
                      },
                    child: Container(
                       height: 40,
                       width: 40,
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(gradient: LinearGradient(colors: [
                                 const Color(0xFFEFEBE9),
                                  const Color(0xFF000000),
                        ]),
                            borderRadius: BorderRadius.circular(40)
                        ),
                        child: Image.asset("assets/images/search_white.png")),
                  )
                ],
              ),
            ),
                searchList(),
      ],
    ),
    ),

  );
  }
}


getChatRoomId(String a, String b){
  if (a.substring(0,1).codeUnitAt(0)>b.substring(0,1).codeUnitAt(0)){
    return "$b\_$a";

  }else{
    return "$a\_$b";
  }
}