import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:online_quiz/controller/leaderboards/con_leaderboards.dart';
import 'package:online_quiz/model/leaderboards/model_leaderboards.dart';

class LeaderBoards extends StatefulWidget {
  @override
  _LeaderBoardsState createState() => _LeaderBoardsState();
}

class _LeaderBoardsState extends State<LeaderBoards> {

  Future<List<ModelLeaderBoards>>? getMLB;
  List<ModelLeaderBoards> listMLB = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMLB = getLeaderBoards(listMLB);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text('Leaderbaords', style: TextStyle(
          color: Colors.black, fontSize: 17
        ),),
      ),
      body: SafeArea(
        child: Container(
          child: FutureBuilder(
            future: getMLB,
            builder: (BuildContext context, AsyncSnapshot<List<ModelLeaderBoards>> snapshot) {
              if(snapshot.connectionState == ConnectionState.done){
                return ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index){
                    return Container(
                      child: index == 0 ?
                      GestureDetector(
                        onTap: ()async{
                          await showDialog(
                              context: context,
                              builder: (context)=>AlertDialog(
                                content: Container(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      listMLB[index].photo_user == "" ?
                                      ClipRRect(
                                          borderRadius: BorderRadius.circular(100),
                                          child: Image.asset(
                                            'assets/image/noimg.png',
                                            height: 80,
                                            width: 80,)
                                      ) :
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(100),
                                        child: Image.network(
                                          '${listMLB[index].photo_user}',
                                          fit: BoxFit.cover,
                                          height: 80,
                                          width: 80,),
                                      ),
                                      SizedBox(height: 5,),
                                      Text('${listMLB[index].name_user}', style: TextStyle(color: Colors.lightBlue, fontSize: 17),),
                                      SizedBox(height: 10,),
                                      listMLB[index].badge.length != 0 ? GridView.builder(
                                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 5,
                                              mainAxisSpacing: 4.0,
                                              crossAxisSpacing: 9
                                          ),
                                          itemCount: listMLB[index].badge.length,
                                          shrinkWrap: true,
                                          itemBuilder: (context, indexBadge){
                                            return Container(
                                              child: Column(
                                                children: [
                                                  ClipRRect(
                                                    borderRadius: BorderRadius.circular(100),
                                                    child: Image.network(
                                                      '${listMLB[index].badge[indexBadge].badge_image}',
                                                      fit: BoxFit.cover, height: 30, width: 30,),
                                                  )
                                                ],
                                              ),
                                            );
                                          }) : Container(child: Text('No badge yet'),),
                                    ],
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                      onPressed: ()=>Navigator.pop(context),
                                      child: Text('Close', style: TextStyle(color: Colors.red, fontSize: 14),))
                                ],
                              ));
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.blueGrey,
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(4),
                              bottomLeft: Radius.circular(4)
                            )
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: Column(
                              children: [
                                Stack(
                                  children: [
                                    Center(
                                      child: listMLB[index].photo_user == "" ? ClipRRect(
                                        borderRadius: BorderRadius.circular(100),
                                        child: Image.asset(
                                            'assets/image/noimg.png',
                                          fit: BoxFit.cover,
                                          width: 130,
                                          height: 130,),
                                      ) : ClipRRect(
                                        borderRadius: BorderRadius.circular(100),
                                        child: Image.network(
                                          '${listMLB[index].photo_user}',
                                          fit: BoxFit.cover,
                                          height: 130,
                                          width: 130,
                                        ),
                                      ),
                                    ),
                                    Center(
                                      child: Container(
                                        margin: EdgeInsets.only(top: 110, left: 60),
                                        width: 30,
                                          child: Padding(
                                            padding: const EdgeInsets.all(5),
                                            child: Text(
                                                '${index+1}',style: TextStyle(
                                                color: Colors.white, fontSize: 17),
                                              textAlign: TextAlign.center,),
                                          ),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(100),
                                          color: Colors.blue
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('${listMLB[index].name_user}', style: TextStyle(
                                      color: Colors.white, fontSize: 24
                                    ),),
                                    Text(' (${listMLB[index].score}) ', style: TextStyle(
                                        color: Colors.orange, fontSize: 24
                                    ),),
                                  ],
                                ),
                                listMLB[index].badge.length != 0 ? GridView.builder(
                                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 5,
                                        mainAxisSpacing: 4.0,
                                        crossAxisSpacing: 9
                                    ),
                                    itemCount: listMLB[index].badge.length,
                                    shrinkWrap: true,
                                    itemBuilder: (context, indexBadge){
                                      return Container(
                                        child: Column(
                                          children: [
                                            ClipRRect(
                                              borderRadius: BorderRadius.circular(100),
                                              child: Image.network(
                                                '${listMLB[index].badge[indexBadge].badge_image}',
                                                fit: BoxFit.cover, height: 30, width: 30,),
                                            )
                                          ],
                                        ),
                                      );
                                    }) : Container(child: Text('No badge yet', style: TextStyle(
                                  color: Colors.white, fontSize: 17
                                ),),),
                              ],
                            ),
                          ),
                        ),
                      ) :
                      GestureDetector(
                        onTap: ()async{
                          await showDialog(
                              context: context,
                              builder: (context)=>AlertDialog(
                                content: Container(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      listMLB[index].photo_user == "" ?
                                      ClipRRect(
                                          borderRadius: BorderRadius.circular(100),
                                          child: Image.asset(
                                            'assets/image/noimg.png',
                                            height: 80,
                                            width: 80,)
                                      ) :
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(100),
                                        child: Image.network(
                                          '${listMLB[index].photo_user}',
                                          fit: BoxFit.cover,
                                          height: 80,
                                          width: 80,),
                                      ),
                                      SizedBox(height: 5,),
                                      Text('${listMLB[index].name_user}', style: TextStyle(color: Colors.lightBlue, fontSize: 17),),
                                      SizedBox(height: 10,),
                                      listMLB[index].badge.length != 0 ? GridView.builder(
                                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 5,
                                              mainAxisSpacing: 4.0,
                                              crossAxisSpacing: 9
                                          ),
                                          itemCount: listMLB[index].badge.length,
                                          shrinkWrap: true,
                                          itemBuilder: (context, indexBadge){
                                            return Container(
                                              child: Column(
                                                children: [
                                                  ClipRRect(
                                                    borderRadius: BorderRadius.circular(100),
                                                    child: Image.network(
                                                      '${listMLB[index].badge[indexBadge].badge_image}',
                                                      fit: BoxFit.cover, height: 30, width: 30,),
                                                  )
                                                ],
                                              ),
                                            );
                                          }) : Container(child: Text('No badge yet'),),
                                    ],
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                      onPressed: ()=>Navigator.pop(context),
                                      child: Text('Close', style: TextStyle(color: Colors.red, fontSize: 14),))
                                ],
                              ));
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: 10, left: 10, top: 5),
                          child: Row(
                            children: [
                              Text('${index+1}', style: TextStyle(color: Colors.black, fontSize: 17),),
                              SizedBox(width: 10,),
                              listMLB[index].photo_user == "" ?
                              ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Image.asset(
                                    'assets/image/noimg.png',
                                    height: 60,
                                    width: 60,)
                              ) :
                              ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Image.network(
                                  '${listMLB[index].photo_user}',
                                  fit: BoxFit.cover,
                                  height: 60,
                                  width: 60,),
                              ),
                              SizedBox(width: 10,),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('${listMLB[index].name_user}', style: TextStyle(color: Colors.black, fontSize: 17),),
                                    listMLB[index].badge.length != 0 ? GridView.builder(
                                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 5,
                                            mainAxisSpacing: 4.0,
                                            crossAxisSpacing: 9
                                        ),
                                        itemCount: listMLB[index].badge.length,
                                        shrinkWrap: true,
                                        itemBuilder: (context, indexBadge){
                                          return Container(
                                            child: Column(
                                              children: [
                                                ClipRRect(
                                                  borderRadius: BorderRadius.circular(100),
                                                  child: Image.network(
                                                    '${listMLB[index].badge[indexBadge].badge_image}',
                                                    fit: BoxFit.cover, height: 30, width: 30,),
                                                )
                                              ],
                                            ),
                                          );
                                        }) : Container(child: Text('No badge yet'),),
                                  ],
                                ),
                              ),
                              SizedBox(width: 7,),
                              Align(
                                  alignment: Alignment.centerRight,
                                  child: Text('${listMLB[index].score}', style: TextStyle(color: Colors.lightBlue, fontSize: 17),)),
                            ],
                          ),
                        ),
                      ),
                    );
                  });
              }else{
                return Center(
                  child: CircularProgressIndicator(strokeWidth: 1.6, color: Colors.red,),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
