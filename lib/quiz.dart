import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class quizScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _quizScreenState();
}

class _quizScreenState extends State {
  Quiz quiz = generateQuiz();
  int index = 0;

  void _incrementIndex() {
    setState(() {
      if (quiz.questions.length - 1 > index) {
        index++;
      }
    });
  }

  void _decrementIndex() {
    setState(() {
      if (index > 0) {
        index--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Question question = quiz.questions[index];
    return Scaffold(
      appBar: AppBar(
        title: Text(quiz.name),
      ),
      body: Center(
        child: Column(
          children: [
            Text(question.text),
            ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: question.options.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(question.options[index].text),
                    leading: question.options[index].is_true
                        ? Icon(
                            Icons.check_box_outlined,
                            color: Colors.green,
                          )
                        : Icon(
                            Icons.clear_sharp,
                            color: Colors.red,
                          ),
                  );
                }),
            IconButton(
                onPressed: () {
                  _decrementIndex();
                },
                icon: Icon(Icons.chevron_left)),
            IconButton(
                onPressed: () {
                  _incrementIndex();
                },
                icon: Icon(Icons.chevron_right)),
          ],
        ),
      ),
    );
  }
}

Quiz generateQuiz() {
  List<Question> questions = List<Question>.generate(10, (i) {
    List<AnswerOption> options = List<AnswerOption>.generate(4, (j) {
      return AnswerOption('Answer number $j', j % 4 == 0 ? true : false);
    });
    Question question = Question('Question number $i', options);

    return question;
  });
  return Quiz('TestQuiz', questions);
}

class Quiz {
  String name;
  List<Question> questions;

  Quiz(this.name, this.questions);
}

class Question {
  String text;
  List<AnswerOption> options;

  Question(this.text, this.options);
}

class AnswerOption {
  String text;
  bool is_true;

  AnswerOption(this.text, this.is_true);
}
