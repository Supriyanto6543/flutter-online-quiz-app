import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:online_quiz/controller/api.dart';
import 'package:online_quiz/my_shared.dart';
import 'package:online_quiz/view/bottom_view.dart';
import 'package:online_quiz/view/register.dart';

import '../router.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool visibleLoading = false;

  Future login({required TextEditingController name,
    required TextEditingController password,
  required BuildContext context, required Widget widget}) async{

    String getName = name.text;
    String getPassword = password.text;

    setState(() {
      visibleLoading = true;
    });

    var data = {'email': getName, 'password': getPassword};
    var apiCall = await Dio().post(Api.baseUrl+Api.utils+Api.login, data: data);

    var decode = jsonDecode(apiCall.data); //this replace double quotes

    if(decode[3] == "Successfully login"){
      setState(() {
        visibleLoading = false;
      });
      prefLogin(id: decode[0], name: decode[1], email: decode[2]);
      pushPageAndRemove(context, widget);
    }else{
      setState(() {
        visibleLoading = false;
      });
      showDialog(
          context: context,
          builder: (context){
            return AlertDialog(
              title: Text('Please double check your name or password', style: TextStyle(
                  color: Colors.blueAccent, fontSize: 19
              ),),
              actions: [
                GestureDetector(
                  onTap: ()=>Navigator.pop(context),
                  child: Text('Okay'),
                )
              ],
            );
          });
    }

  }

  @override
  void initState() {
    super.initState();
    prefLoad().then((value) {
      setState(() {
        if(value != null){
          pushPageAndRemove(context, BottomView());
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Container(
        margin: EdgeInsets.only(top: 90),
        child: Stack(
          children: [
            Column(
              children: [
                Image.asset('assets/image/noimg.png', width: 125, height: 125,),
                Text('Online Quiz App', style: TextStyle(
                  fontSize: 24, color: Colors.blueAccent
                ),),
                Container(
                  margin: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 5),
                  child: TextField(
                    controller: nameController,
                    style: TextStyle(color: Colors.blueAccent),
                    decoration: InputDecoration(
                        hintText: 'Enter your email',
                        prefixIcon: Icon(Icons.account_circle_outlined, color: Colors.blueAccent,),
                        filled: true,
                        fillColor: Colors.white54,
                        hintStyle: TextStyle(color: Colors.blue),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.blueAccent)
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.blueAccent)
                        )
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 5),
                  child: TextField(
                    controller: passwordController,
                    style: TextStyle(color: Colors.blueAccent),
                    decoration: InputDecoration(
                        hintText: 'Enter your password',
                        prefixIcon: Icon(Icons.lock_outline, color: Colors.blueAccent,),
                        filled: true,
                        fillColor: Colors.white54,
                        hintStyle: TextStyle(color: Colors.blue),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.blueAccent)
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.blueAccent)
                        )
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 7, bottom: 7),
                  child: GestureDetector(
                    onTap: (){
                      login(name: nameController,
                          password: passwordController,
                          context: context, widget: BottomView());
                    },
                    child: Container(
                        margin: EdgeInsets.only(top: 20, right: 20, left: 20, bottom: 7),
                        padding: EdgeInsets.only(top: 14, bottom: 14, right: 40, left: 40),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Colors.blueAccent
                        ),
                        child: !visibleLoading ? Container(
                          width: 150,
                          child: Text('Login', style: TextStyle(
                              color: Colors.white, fontSize: 17
                          ), textAlign: TextAlign.center,),
                        ) : Visibility(visible: visibleLoading,
                          child: Container(
                            width: 150,
                            child: Center(
                              child: Container(
                                width: 15,
                                height: 15,
                                child: CircularProgressIndicator(strokeWidth: 1.6, color: Colors.red,),
                              ),
                            ),
                          ),
                        )
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    margin: EdgeInsets.only(right: 20, left: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Dont have an Account?', style: TextStyle(fontSize: 17),),
                        SizedBox(width: 10,),
                        GestureDetector(
                          onTap: (){
                            pushPage(context, Register());
                          },
                          child: Text('Sign up', style: TextStyle(color: Colors.blueAccent, fontSize: 17),),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      )
    );
  }
}
