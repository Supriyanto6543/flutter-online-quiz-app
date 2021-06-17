import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:online_quiz/controller/api.dart';
import 'package:online_quiz/my_shared.dart';
import 'package:online_quiz/router.dart';
import 'package:online_quiz/view/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Account extends StatefulWidget {
  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {

  late SharedPreferences preferences;
  String id = "";
  String name = "";
  String email = "";
  String photo = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    prefLoad().then((value) {
      setState(() {
        id = value[0];
        name = value[1];
        email = value[2];
        getPhoto(id);
      });
    });
  }

  Future getPhoto(String id) async{
    var requestPhoto = await Dio().post(Api.baseUrl+Api.utils+Api.viewPhoto, data: {'id': id});
    var decode = requestPhoto.data;
    if(decode != "no_img"){
      setState(() {
        photo = decode;
        print("this is photo $decode");
      });
    }else{
      setState(() {
        photo = "";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('Account', style: TextStyle(color: Colors.black),),
        actions: [
          GestureDetector(
            onTap: ()async{
              preferences = await SharedPreferences.getInstance();
              preferences.remove('login');
              pushPageAndRemove(context, Login());
            },
            child: Container(
              margin: EdgeInsets.only(right: 10),
              child: Center(
                  child: Text(
                    'Logout', style: TextStyle(
                      color: Colors.black),)
              )
            ),
          )
        ],
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            Center(
              child: Container(
                child: photo == "" ?
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.asset(
                    'assets/image/noimg.png', fit: BoxFit.cover, height: 100, width: 100,
                  ),
                ) :
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.network(
                    '$photo', fit: BoxFit.cover, height: 100, width: 100,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10,),
            Center(
              child: Column(
                children: [
                  Text(
                    '$name', style: TextStyle(
                      color: Colors.black, fontSize: 20),),
                  SizedBox(height: 10,),
                  Text(
                    '$email', style: TextStyle(
                      color: Colors.black87, fontSize: 17),)
                ],
              ),
            ),
            SizedBox(height: 15,),
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                child: Text(
                  'Support Online Quiz', style: TextStyle(
                    color: Colors.black87, fontSize: 14),),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: GestureDetector(
                onTap: (){

                },
                child: Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Text(
                    'About App', style: TextStyle(
                      color: Colors.blue, fontSize: 16),),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: GestureDetector(
                onTap: (){

                },
                child: Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Text(
                    'Share this App', style: TextStyle(
                      color: Colors.blue, fontSize: 16),),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: GestureDetector(
                onTap: (){

                },
                child: Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Text(
                    'Give a Rating', style: TextStyle(
                      color: Colors.blue, fontSize: 16),),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
