import 'package:chat_app/helpers/constants.dart';
import 'package:chat_app/services/database.dart';
import 'package:flutter/material.dart';

class ConversationScreen extends StatefulWidget {
  final String chatRoomId;
  ConversationScreen(this.chatRoomId);
  @override
  _ConversationScreenState createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  TextEditingController messageController = new TextEditingController();
  DatabaseMethods databaseMethods =DatabaseMethods();
  Widget ChatMessageList(){
    return StreamBuilder(stream: chatMessagesStream,
                          builder: (context, snapshot){
                            return snapshot.hasData ? ListView.builder(
                                itemCount: snapshot.data.documents.length,
                                itemBuilder: (context,index){
                                  return MessageTile(snapshot.data.documents[index].data["message"]);
                                }) : Container();
                          },
    );


  }
  Stream chatMessagesStream;
  @override
  void initState(){
    databaseMethods.getConversationMessages(widget.chatRoomId).then((value){
      chatMessagesStream = value;
    });
    super.initState();
  }
  sendMessage(){
    if(messageController.text.isNotEmpty){
      Map<String, String>messageMap={
        "message":messageController.text,
        "sendBy":Constants.myName
    };
      databaseMethods.addConversationMessages(widget.chatRoomId, messageMap);
      messageController.text="";
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/images/logo.png', height: 50,),
      ),
      body: Container(
        child: Stack(
          children: [
            ChatMessageList(),
            Container(
              alignment: Alignment.bottomCenter,
              child: Container(
              padding: EdgeInsets.symmetric(horizontal: 24,vertical: 16),
              color: Colors.black12,
              child: Row(

                children: [
                  Expanded(child: TextField(
                    controller: messageController,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(hintText: "Message",
                        hintStyle: TextStyle(color: Colors.white54),
                        border: InputBorder.none ),
                  )
                  ),
                  GestureDetector(
                    onTap: (){
                      sendMessage();
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
                        child: Image.asset("assets/images/send.png")),
                  )
                ],
              ),
            ),

          ),
        ],
        ),
      ),


    );


  }
}
class MessageTile extends StatelessWidget {
  final String message;
  MessageTile(this.message);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        message
      ),
    );
  }
}

