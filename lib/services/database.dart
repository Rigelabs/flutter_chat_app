import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods{

  getUserByUserName(String username) async{
    return await Firestore.instance.collection("users").
    where('name',isEqualTo: username).
    getDocuments();

  }
  getUserByUserEmail(String userEmail) async{
    return await Firestore.instance.collection("users").
    where('email',isEqualTo: userEmail).
    getDocuments();

  }
  uploadUserInfo(userMap){
    Firestore.instance.collection("users").add(userMap).catchError((e){
        print(e.toString());
    });

  }
  createChatRoom(String chatRoomId, chatRoomMap){
    Firestore.instance.collection("ChatRoom").
    document(chatRoomId).setData(chatRoomMap).
    catchError((err){
      print(err.toString());
    });
  }
  getConversationMessages(String chatRoomId){
    Firestore.instance.collection("ChatRoom").document(
      chatRoomId).collection("chats").snapshots();
  }
  addConversationMessages(String chatRoomId,messageMap){
    Firestore.instance.collection("ChatRoom").document(
        chatRoomId).collection("chats").add(messageMap).
    catchError((err){
      print(err.toString());
    });
  }
}
