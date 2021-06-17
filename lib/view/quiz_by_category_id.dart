import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:online_quiz/controller/quiz_by_id/con_quiz_by_id.dart';
import 'package:online_quiz/model/quiz/model_quiz.dart';

import '../router.dart';
import 'main_quiz.dart';

class QuizByCategoryId extends StatefulWidget {

  String id;

  QuizByCategoryId({required this.id});

  @override
  _QuizByCategoryIdState createState() => _QuizByCategoryIdState();
}

class _QuizByCategoryIdState extends State<QuizByCategoryId> {

  Future<List<ModelQuiz>>? getSlider;
  List<ModelQuiz> listSlider = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSlider = getQuizByCategoryId(listSlider, widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Quiz By Category', style: TextStyle(
          color: Colors.black87
        ),),
        leading: GestureDetector(
          onTap: ()=>Navigator.pop(context),
            child: Icon(Icons.arrow_back, color: Colors.black87,)),
      ),
      body: Container(
        child: FutureBuilder(
          future: getSlider,
          builder: (BuildContext context, AsyncSnapshot<List<ModelQuiz>> snapshot) {
            if(snapshot.connectionState == ConnectionState.done){
              return ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: (){
                      pushPage(context, MainQuiz(
                        cat_name: listSlider[index].category_name,
                        content: listSlider[index].content,));
                    },
                    child: Container(
                        margin: EdgeInsets.all(5),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              child: Image.network('${listSlider[index].image_quiz}',
                                width: 90, height: 90, fit: BoxFit.cover,),
                            ),
                            SizedBox(width: 10,),
                            Expanded(
                              child: Column(
                                children: [
                                  Text('${listSlider[index].name_quiz}', style: TextStyle(
                                      color: Colors.black, fontSize: 17
                                  ),),
                                  Text('${listSlider[index].category_name}', style: TextStyle(
                                      color: Colors.black, fontSize: 15
                                  ),),
                                  Text('${listSlider[index].content.length} Quiz', style: TextStyle(
                                      color: Colors.black, fontSize: 15
                                  ),),
                                ],
                                crossAxisAlignment: CrossAxisAlignment.start,
                              ),
                            )
                          ],
                        )
                    ),
                  );
                },
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: snapshot.data!.length,);
            }else{
              return Center(
                child: CircularProgressIndicator(strokeWidth: 1.6, color: Colors.red,),
              );
            }
          },
        ),
      ),
    );
  }
}
