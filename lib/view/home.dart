import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:online_quiz/controller/category/con_category.dart';
import 'package:online_quiz/controller/quiz/con_quiz.dart';
import 'package:online_quiz/model/category/model_category.dart';
import 'package:online_quiz/model/quiz/model_quiz.dart';
import 'package:online_quiz/my_shared.dart';
import 'package:online_quiz/router.dart';
import 'package:online_quiz/view/main_quiz.dart';
import 'package:online_quiz/view/quiz_by_category_id.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String id = "";
  String name = "";
  String email = "";

  //this is for slider
  Future<List<ModelQuiz>>? getSlider;
  List<ModelQuiz> listSlider = [];
  //this is for category
  Future<List<ModelCategory>>? getCategory;
  List<ModelCategory> listCategory = [];

  @override
  void initState() {
    super.initState();
    prefLoad().then((value) {
      setState(() {
        id = value[0];
        name = value[1];
        email = value[2];
      });
    });
    getSlider = getQuiz(listSlider);
    getCategory = getCategories(listCategory);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            Text('Hello: ', style: TextStyle(color: Colors.black, fontSize: 17),),
            Text( name, style: TextStyle(color: Colors.black87, fontSize: 16),)
          ],
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: FutureBuilder(
            future: getSlider,
            builder: (BuildContext context, AsyncSnapshot<List<ModelQuiz>> snapshot) {
              if(snapshot.connectionState == ConnectionState.done){
                return Column(
                  children: [
                    //this is slider
                    Container(
                      child: FutureBuilder(
                        future: getSlider,
                        builder: (BuildContext context, AsyncSnapshot<List<ModelQuiz>> snapshot) {
                          if(snapshot.connectionState == ConnectionState.done){
                            return SizedBox(
                              height: 150,
                              child: Swiper(
                                autoplay: true,
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, index){
                                  return GestureDetector(
                                    onTap: (){
                                      pushPage(context, MainQuiz(
                                          content: listSlider[index].content,
                                          cat_name: listSlider[index].category_name));
                                    },
                                    child: Container(
                                      margin: EdgeInsets.all(5),
                                      child: Stack(
                                        children: [
                                          Image.network(
                                            '${listSlider[index].image_quiz}',
                                            width: MediaQuery.of(context).size.width,
                                            fit: BoxFit.cover,
                                          ),
                                          Align(
                                            alignment: Alignment.bottomCenter,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                  end: Alignment(0.0, -1),
                                                  begin: Alignment(0.0, 0.2),
                                                  colors: [
                                                    Color(0x8A000000),
                                                    Colors.black.withOpacity(0.2)
                                                  ]
                                                )
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.all(5),
                                                child: Text('${listSlider[index].name_quiz}', style: TextStyle(
                                                  color: Colors.white, fontSize: 19
                                                ),),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                }
                              ),
                            );
                          }else{
                            return Center(
                              child: CircularProgressIndicator(strokeWidth: 1.6, color: Colors.red,),
                            );
                          }
                        },
                      ),
                    ),
                    //this is category
                    Container(
                      child: FutureBuilder(
                        future: getCategory,
                        builder: (BuildContext context, AsyncSnapshot<List<ModelCategory>> snapshot) {
                          if(snapshot.connectionState == ConnectionState.done){
                            return Container(
                              margin: EdgeInsets.all(8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Category', style: TextStyle(color: Colors.black, fontSize: 21),),
                                  SizedBox(height: 5,),
                                  SizedBox(
                                    height: 110,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: snapshot.data!.length,
                                      itemBuilder: (context, index){
                                        return GestureDetector(
                                          onTap: (){
                                            pushPage(context, QuizByCategoryId(id: listCategory[index].cat_id));
                                          },
                                          child: Container(
                                            child: Column(
                                              children: [
                                                ClipRRect(
                                                  child: Image.network(
                                                      '${listCategory[index].photo_cat}', width: 90, height: 90, fit: BoxFit.cover,
                                                  ),
                                                ),
                                                Text('${listCategory[index].cat_name}', style: TextStyle(
                                                  color: Colors.black, fontSize: 17
                                                ),),
                                              ],
                                            ),
                                          ),
                                        );
                                      }
                                    ),
                                  )
                                ],
                              ),
                            );
                          }else{
                            return Center(
                              child: CircularProgressIndicator(strokeWidth: 1.6, color: Colors.red,),
                            );
                          }
                        },
                      ),
                    ),
                    //this is quiz
                    Container(
                      child: FutureBuilder(
                        future: getSlider,
                        builder: (BuildContext context, AsyncSnapshot<List<ModelQuiz>> snapshot) {
                          if(snapshot.connectionState == ConnectionState.done){
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: Text('New Quiz', style: TextStyle(color: Colors.black, fontSize: 21),),
                                ),
                                ListView.builder(
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
                                  itemCount: snapshot.data!.length,),
                              ],
                            );
                          }else{
                            return Center(
                              child: CircularProgressIndicator(strokeWidth: 1.6, color: Colors.red,),
                            );
                          }
                        },
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
    );
  }
}
