import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

pushPage(BuildContext context, Widget widget){
  Navigator.push(context, MaterialPageRoute(builder: (context)=>widget));
}

pushPageAndRemove(BuildContext context, Widget widget){
  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>widget),
          (Route<dynamic> route) => false);
}