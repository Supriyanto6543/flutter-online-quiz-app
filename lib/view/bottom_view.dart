import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'account.dart';
import 'home.dart';
import 'leaderboards.dart';

class BottomView extends StatefulWidget {
  @override
  _BottomViewState createState() => _BottomViewState();
}

class _BottomViewState extends State<BottomView> {

  int currentIndex = 0;
  List<Widget> body = [
    Home(),
    LeaderBoards(),
    Account()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: whenTap,
        currentIndex: currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined, color: Colors.blueAccent,),
            label: 'Home',
            activeIcon: Icon(Icons.home, color: Colors.lightBlueAccent,)
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.leaderboard_outlined, color: Colors.blueAccent,),
              label: 'Leaderboards',
              activeIcon: Icon(Icons.leaderboard, color: Colors.lightBlueAccent,)
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_outlined, color: Colors.blueAccent,),
              label: 'Account',
              activeIcon: Icon(Icons.account_circle, color: Colors.lightBlueAccent,)
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: body[currentIndex],
    );
  }

  void whenTap(int tap){
    setState(() {
      currentIndex = tap;
    });
  }
}
