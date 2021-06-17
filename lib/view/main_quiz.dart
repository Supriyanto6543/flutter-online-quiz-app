import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';
import 'package:online_quiz/controller/api.dart';
import 'package:online_quiz/controller/quiz/con_quiz.dart';
import 'package:online_quiz/model/quiz/model_quiz.dart';
import 'package:online_quiz/model/quiz/model_quiz_content.dart';
import 'package:online_quiz/model/quiz/question.dart';
import 'package:online_quiz/my_shared.dart';

class MainQuiz extends StatefulWidget {

  List<ModelQuizContent> content;
  String cat_name;

  MainQuiz({required this.content, required this.cat_name});

  @override
  _MainQuizState createState() => _MainQuizState();
}

class _MainQuizState extends State<MainQuiz> {


  late Future<List<ModelQuiz>> getQuizFormDb;
  List<ModelQuiz> listQuiz = [];
  Question question = Question();
  int scoreText = 0;
  bool completed = false;
  String id = "";
  String name = "";
  String email = "";
  String photo = "";
  String photoView = "";
  late ConfettiController _confettiController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _confettiController = ConfettiController(duration: Duration(seconds: 10));
    _confettiController.play();
    getQuizFormDb = getQuiz(listQuiz);
    prefLoad().then((value) {
      setState(() {
        id = value[0];
        name = value[1];
        email = value[2];
        getPhoto(id);
      });
    });
  }

  storeScore(int score, String id)async{
    var data = {'add_view': score.toInt(), 'id': id};
    var request = await Dio().post(Api.baseUrl+Api.utils+Api.score, data: data);
    print("this is scroe ${Api.baseUrl+Api.utils+Api.score}");
    return request.data;
  }

  void checkAnswer(bool isAnswer){
    bool correctAnswer = question.getAnswer(widget.content);
    setState(() {
      if(question.nextQuestionQuiz(widget.content.length) == true){
        completed = true;
        if(isAnswer == correctAnswer){
          setState(() {
            scoreText += 1;
            print("this is Score $scoreText");
          });
        }else{
          setState(() {
            scoreText = scoreText;
            print("this is Score $scoreText");
          });
        }
      }else{
        if(isAnswer == correctAnswer){
          setState(() {
            scoreText += 1;
            print("this is Score $scoreText");
          });
        }else{
          setState(() {
            scoreText = scoreText;
            print("this is Score $scoreText");
          });
        }
      }
    });
  }

  Future getPhoto(String id) async{
    var requestPhoto = await Dio().post(Api.baseUrl+Api.utils+Api.viewPhoto, data: {'id': id});
    print("this is baseUrl ${Api.baseUrl+Api.utils+Api.viewPhoto}");
    var decode = requestPhoto.data;
    if(decode != "no_img"){
      setState(() {
        photoView = decode;
        print("this is photo $decode");
      });
    }else{
      setState(() {
        photoView = "";
      });
    }
  }

  Path drawStar(Size size) {
    // Method to convert degree to radians
    double degToRad(double deg) => deg * (pi / 180.0);

    const numberOfPoints = 5;
    final halfWidth = size.width / 2;
    final externalRadius = halfWidth;
    final internalRadius = halfWidth / 2.5;
    final degreesPerStep = degToRad(360 / numberOfPoints);
    final halfDegreesPerStep = degreesPerStep / 2;
    final path = Path();
    final fullAngle = degToRad(360);
    path.moveTo(size.width, halfWidth);

    for (double step = 0; step < fullAngle; step += degreesPerStep) {
      path.lineTo(halfWidth + externalRadius * cos(step),
          halfWidth + externalRadius * sin(step));
      path.lineTo(halfWidth + internalRadius * cos(step + halfDegreesPerStep),
          halfWidth + internalRadius * sin(step + halfDegreesPerStep));
    }
    path.close();
    return path;
  }

  @override
  Widget build(BuildContext context) {
    double finalScore = scoreText / widget.content.length * 100;
    print("score in Build $scoreText");
    return WillPopScope(
      onWillPop: ()async{
        await showDialog(
            context: context,
            builder: (context)=>AlertDialog(
              title: Text('Info', style: TextStyle(fontSize: 20, color: Colors.black),),
              content: Text('You cant logout form this main quiz, please take the quiz until finish', style: TextStyle(
                color: Colors.black
              ),),
              actions: [
                TextButton(
                    onPressed: ()=>Navigator.pop(context),
                    child: Text('Okay', style: TextStyle(color: Colors.black),))
              ],
            ));
        return false;
      },
      child: MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leadingWidth: 90,
            leading: Container(
              margin: EdgeInsets.only(left: 10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '${question.numberQuestion+1} / ${widget.content.length}', style: TextStyle(
                  fontSize: 17, color: Colors.black),
                ),
              ),
            ),
            title: Text(
              '${widget.cat_name}', style: TextStyle(
                fontSize: 17, color: Colors.black),
            ),
            centerTitle: true,
            actions: [
              Center(
                child: Container(
                  margin: EdgeInsets.only(right: 10),
                  child: Text(
                    'Score ${finalScore.toInt()}', style: TextStyle(
                      fontSize: 17, color: Colors.black),
                  ),
                ),
              )
            ],
          ),
          body: Container(
            height: MediaQuery.of(context).size.height,
            child: completed == true ?
            Stack(
              children: [
                Center(
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Image.asset('assets/image/award.jpeg', fit: BoxFit.fill,),
                          Container(
                            margin: EdgeInsets.only(top: 40),
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: ConfettiWidget(
                                confettiController: _confettiController,
                                blastDirectionality: BlastDirectionality.explosive,
                                shouldLoop:
                                true, // start again as soon as the animation is finished
                                colors: const [
                                  Colors.green,
                                  Colors.blue,
                                  Colors.pink,
                                  Colors.orange,
                                  Colors.purple
                                ], // manually specify the colors to be used
                                createParticlePath: drawStar,
                              ),
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.only(top: 65),
                              child: Center(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Image.network('$photoView',
                                    width: 140,
                                    height: 140,
                                    fit: BoxFit.cover,),
                                ),
                              )),
                        ],
                      ),
                      Text(name, style: TextStyle(
                          fontSize: 27
                      ),),
                      finalScore.toInt() > 80 ? Text('Congrats!', style: TextStyle(color: Colors.orange, fontSize: 35),) :
                          finalScore.toInt() > 60 ? Text('Awesome!', style: TextStyle(color: Colors.blueAccent, fontSize: 35),) :
                              finalScore.toInt() > 40 ? Text('Good!', style: TextStyle(color: Colors.green, fontSize: 35),) :
                                  finalScore.toInt() > 20 ? Text('Not Good!', style: TextStyle(color: Colors.indigo, fontSize: 35),) :
                                  Text('Very Bad!', style: TextStyle(color: Colors.red, fontSize: 35),),
                      SizedBox(height: 10,),
                      Text('You have earned ${(scoreText / widget.content.length * 100).toInt()} scores!', style: TextStyle(
                          fontSize: 23
                      ),),
                      SizedBox(height: 10,),
                      Text('YOUR SCORE', style: TextStyle(
                          fontSize: 23
                      ),),
                      SizedBox(height: 10,),
                      RichText(
                        text: TextSpan(
                          text: '${(scoreText / widget.content.length * 100).toInt()}',
                          style: TextStyle(
                            fontSize: 29,
                            color: Colors.green
                          ),
                          children: [
                            TextSpan(
                              text: ' / 100',
                              style: TextStyle(
                                  fontSize: 29,
                                  color: Colors.red
                              ),
                            )
                          ]
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(right: 20, left: 20, bottom: 10),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)
                            ),
                            primary: Colors.blueAccent
                          ),
                          onPressed: ()async{
                            double finalScore = scoreText / widget.content.length * 100;
                            await showDialog(
                                context: context,
                                builder: (context)=>FutureProgressDialog(
                                  storeScore(finalScore.toInt(), id),
                                ));
                            Navigator.pop(context);
                            setState(() {
                              completed = false;
                              question.startOver();
                              scoreText = 0;
                            });
                          },
                          child: Text('Finish', style: TextStyle(color: Colors.white, fontSize: 17),),
                        ),
                      )
                    ],
                  ),
                  bottom: 0,
                  left: 0,
                  right: 0,
                )
              ],
            ) :
            FutureBuilder(
              future: getQuizFormDb,
              builder: (BuildContext context, AsyncSnapshot<List<ModelQuiz>> snapshot) {
                if(snapshot.connectionState == ConnectionState.done){
                  print("my photo ${question.getImage(widget.content)}");
                  return Stack(
                    children: [
                      Column(
                        children: [
                          Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Center(
                                  child: Text(question.getQuestion(widget.content), style: TextStyle(
                                    fontSize: 23
                                  ),))),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Center(
                                child: Image.network('${question.getImage(widget.content)}')),
                          )
                        ],
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: ElevatedButton(
                                  onPressed: (){
                                    checkAnswer(true);
                                  },
                                  child: Text('True', style: TextStyle(color: Colors.white, fontSize: 20),),
                                style: ElevatedButton.styleFrom(
                                  shape: CircleBorder(),
                                  padding: EdgeInsets.all(20),
                                  primary: Colors.blueAccent,
                                  onPrimary: Colors.lightBlue
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: ElevatedButton(
                                onPressed: (){
                                  checkAnswer(false);
                                },
                                child: Text('False', style: TextStyle(color: Colors.white, fontSize: 20),),
                                style: ElevatedButton.styleFrom(
                                    shape: CircleBorder(),
                                    padding: EdgeInsets.all(20),
                                    primary: Colors.blueAccent,
                                    onPrimary: Colors.lightBlue
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  );
                }else{
                  return Center(
                    child: CircularProgressIndicator(strokeWidth: 1.6, color: Colors.red,),
                  );
                }
              },
            )
          ),
        ),
      ),
    );
  }
}
