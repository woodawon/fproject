// ignore_for_file: must_be_immutable, use_key_in_widget_constructors, library_private_types_in_public_api, unused_field, prefer_final_fields, prefer_const_constructors, prefer_interpolation_to_compose_strings, sort_child_properties_last, no_leading_underscores_for_local_identifiers, avoid_unnecessary_containers, sized_box_for_whitespace

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_swiper_3/flutter_swiper_3.dart';
import 'package:fproject/model/model_quiz.dart';
import 'package:flutter/material.dart';
import 'package:fproject/screen/screen_result.dart';
import 'package:fproject/widget/widget_candidate.dart';

class QuizScreen extends StatefulWidget {
  List<Quiz> quizs;
  QuizScreen({required this.quizs});
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  List<int> _answers = [-1, -1, -1];
  List<bool> _answerState = [false, false, false, false];
  int _currentIndex = 0;
  SwiperController _controller = SwiperController();
  
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.deepPurple,
        body: Center(
          child: Container(
            width: width * 0.85,
            height: height * 0.5,
            child: Swiper(
              controller: _controller,
              // scroll이 되지 않게 함으로써, 퀴즈를 풀지 않고 다음 퀴즈 페이지로 넘어가는 것을 차단함.
              physics: NeverScrollableScrollPhysics(), 
              loop: false,
              itemCount: widget.quizs.length,
              itemBuilder: (BuildContext context, int index) {
                return _buildQuizCard(widget.quizs[index], width, height);
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuizCard(Quiz quiz, double width, double height) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(0, width * 0.024, 0, width * 0.024),
            child: Text(
              'Q' + (_currentIndex + 1).toString() + ".",
              style: TextStyle(
                fontSize: width * 0.06,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            width: width * 0.8,
            padding: EdgeInsets.only(top : width * 0.012),
            child: AutoSizeText(
              quiz.title,
              textAlign: TextAlign.center,
              maxLines: 2,
              style: TextStyle(
                fontSize: width * 0.048,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            // expanded에 빈 container 넣기 => 이후에 배치될 children들이 아래서부터 배치되는 효과를 줌.
            child: Container(),
          ),
          Column(children: _buildCandidates(width, quiz),),
          Container(
            padding: EdgeInsets.all(width * 0.024),
            child: Center(
              child: ButtonTheme(
                minWidth: width * 0.5,
                height: height * 0.05,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ElevatedButton(
                  child: _currentIndex == widget.quizs.length - 1 
                      ? Text('결과 보기')
                      : Text('다음문제'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: _answers[_currentIndex] == -1
                      ? null
                      : () {
                          if(_currentIndex == widget.quizs.length - 1) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ResultScreen(
                                  answers: _answers,
                                  quizs: widget.quizs,
                                ),
                              ),
                            );
                          } else {
                            _answerState = [false, false, false, false];
                            _currentIndex += 1;
                            _controller.next();
                          }
                        },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  List<Widget> _buildCandidates(double width, Quiz quiz) {
    List<Widget> _children = [];
    for(int i = 0; i < 4; i++) {
      _children.add(
        CandWidget(
          index: i,
          text: quiz.candidates[i],
          width: width,
          answerState: _answerState[i],
          tap: () {
            setState(() {
              for(int j = 0; j < 4; j++) {
                if(j == i) {
                  _answerState[j] = true;
                  _answers[_currentIndex] = j;
                  print(_answers[_currentIndex]);
                } else {
                  _answerState[j] = false;
                }
              }
            });
          },
        ),
      );
      _children.add(
        Padding(
          padding: EdgeInsets.all(width * 0.024),
        ),
      );
    }
    return _children;
  }
}