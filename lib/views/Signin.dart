import 'package:chat_app/helpers/helperfunctions.dart';
import 'package:chat_app/services/auth.dart';
import 'package:chat_app/services/database.dart';
import 'package:chat_app/views/chatRoomScreen.dart';
import 'package:chat_app/widgets/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final Function toggle;
  SignIn(this.toggle);
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController emailTextEditingController = new TextEditingController();
  TextEditingController passwordTextEditingController = new TextEditingController();
  AuthMethods authMethods =new AuthMethods();
  DatabaseMethods databaseMethods = new DatabaseMethods();
  
  final formKey  =GlobalKey<FormState>();

  bool isLoading = false;
  QuerySnapshot snapshotUserInfo;
  signIn(){
    if (formKey.currentState.validate()){
      HelperFunctions.saveUserEmailSharedPreference(emailTextEditingController.text);
      //HelperFunctions.saveUserEmailSharedPreference(passwordTextEditingController.text);
      databaseMethods.getUserByUserEmail(emailTextEditingController.text).then((val){
        snapshotUserInfo = val;
        HelperFunctions.saveUserNameSharedPreference(snapshotUserInfo.documents[0].data["name"]);
      });

      setState(() {
        isLoading =true;

      });

      authMethods.SignInWithEmailAndPassword(emailTextEditingController.text, passwordTextEditingController.text).then((value){
        if (value != null){

          HelperFunctions.saveUserLoggedInSharedPreference(true);
          Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context)=> ChatRoom()
          ));
        }
      });





    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBarMain(context),
      body: SingleChildScrollView(
           child: Container(
                  height: MediaQuery.of(context).size.height - 50,
                  alignment: Alignment.bottomCenter,
              child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Form(
                          key: formKey,
                          child: Column(children:[
                              SizedBox(height: 8,),
                              TextFormField(
                                validator: (val){
                                  return RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$"
                                  ).hasMatch(val) ? null: "provide a valid email";
                                },
                                controller: emailTextEditingController,
                                style: simpleTextStyle(),
                                decoration:textFieldInputDecoration('email'),
                              ),
                              TextFormField(
                                obscureText: true,
                                validator: (val){
                                  return val.isEmpty || val.length<=4 ?'password must have more than 4 characters' : null;
                                },
                                controller: passwordTextEditingController,
                                style: simpleTextStyle(),
                                decoration: textFieldInputDecoration('password'),
                              ),
                          ]),
                        ),
                        SizedBox(height:8,),
                        Container(
                          alignment: Alignment.centerRight,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                            child: Text("Forgot Password ? ",style: simpleTextStyle(),),
                          ),
                        ),
                        SizedBox(height:8,),
                        GestureDetector(
                          onTap: (){
                            signIn();
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.symmetric(vertical: 16),
                            decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            const Color(0xff007EF4),
                                            const Color(0xFF7603),
                                          ]
                                        ),
                                          borderRadius: BorderRadius.circular(30)
                            ),
                            child: Text("Sign In",style: mediumTextStyle(),),
                          ),
                        ),
                        SizedBox(height:12,),
                        Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.symmetric(vertical: 16),
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [
                                    const Color(0xFFFD180),
                                    const Color(0xFFFFFF00),
                                  ]
                              ),
                              borderRadius: BorderRadius.circular(30)
                          ),
                          child: Text("Sign In with Google",style: mediumTextStyle(),),
                        ),
                        SizedBox(height:12,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Don\'t have an account ? ",style: mediumTextStyle(),),
                            GestureDetector(
                              onTap: (){
                                widget.toggle();
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 8),
                                child: Text("Register now",style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    color: Colors.white70,
                                    fontSize: 16
                                ),),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height:50,)
                      ],
                    ),

                  ),

        )
    )

    );
  }
}
