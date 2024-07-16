// ignore_for_file: must_be_immutable, use_key_in_widget_constructors, unused_local_variable, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_interpolation_to_compose_strings, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:fproject/model/model_quiz.dart';
import 'package:fproject/screen/screen_home.dart';

class ResultScreen extends StatelessWidget {

  List<int> answers;
  List<Quiz> quizs;
  ResultScreen({required this.answers, required this.quizs});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;

    int score = 0;
    for(int i = 0; i < quizs.length; i++) {
      if(quizs[i].answer == answers[i]) {
        score += 1;
      }
    }
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          title: Text('My Quiz App'),
          backgroundColor: Colors.deepPurple,
          leading: Container(),
        ),
        body: Center(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.deepPurple),
              color: Colors.deepPurple,
            ),
            width: width * 0.85,
            height: height * 0.5,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: width * 0.048),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  width: width * 0.73,
                  height: height * 0.25,
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.fromLTRB(
                          0, width * 0.048, 0, width * 0.012
                        ),
                        child: Text(
                          '수고하셨습니다.',
                          style: TextStyle(
                            fontSize: width * 0.055,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        '당신의 점수는',
                        style: TextStyle(
                          fontSize: width * 0.048,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Expanded(
                        child: Container(),
                      ),
                      Text(
                        score.toString() + '/' + quizs.length.toString(),
                        style: TextStyle(
                          fontSize: width * 0.21,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(),
                ),
                Container(
                  padding: EdgeInsets.only(bottom: width * 0.048),
                  child: ButtonTheme(
                    minWidth: width * 0.73,
                    height: height * 0.05,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder:(context) {
                            return HomeScreen();
                          }));
                      },
                      child: Text('홈으로 돌아가기'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    
  }
}