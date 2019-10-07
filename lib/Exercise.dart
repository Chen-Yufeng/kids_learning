import 'package:flutter/material.dart';
import 'package:kids_learning/Generator.dart';

class Exercise extends StatelessWidget {
  final int _choose;
  final int _number;

  Exercise(this._choose, this._number);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '练习模式',
      theme: ThemeData(primaryColor: Colors.white),
      home: ExerciseMode(_choose, _number),
    );
  }
}

class ExerciseMode extends StatefulWidget {
  final int _choose;
  final int _number;

  ExerciseMode(this._choose, this._number);

  @override
  State<StatefulWidget> createState() {
    return ExerciseModeState(_choose, _number);
  }
}

class ExerciseModeState extends State<ExerciseMode> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final int _choose;
  final int _number;
  List<Quiz> _list;
  String operator;
  final _font = const TextStyle(fontSize: 18.0);

  ExerciseModeState(this._choose, this._number) {
    switch (_choose) {
      case 1:
        operator = '+';
        break;
      case 2:
        operator = '-';
        break;
      case 3:
        operator = '×';
        break;
      case 4:
        operator = '÷';
        break;
      default:
        operator = 'Error';
    }
    _list = ExerciseGenerator.generate(
        _choose, _number, 100); // todo: change hardcode
//    print(_list);
  }

  Widget _buildExerciseListView() {
    return ListView.builder(
      itemCount: _list.length * 2,
      itemBuilder: (context, i) {
        if (i.isOdd) return Divider();

        final index = i ~/ 2;
        return _buildRow(_list[index]);
      },
    );
  }

  Widget _buildRow(Quiz quiz) {
    return ListTile(
      title: Text(
        '${quiz.first} $operator ${quiz.second} =',
        style: _font,
      ),
      trailing: Container(
          width: 100.0,
          child: TextField(
            onChanged: (newString) {
              quiz.input = int.parse(newString);
              if (quiz.input == quiz.answer) {
                quiz.isRight = true;
              } else {
                quiz.isRight = false;
              }
            },
            keyboardType: TextInputType.number, // todo: only numbers?
          )),
    );
  }

  void _submit() {
    int right = 0;
    int wrong = 0;
    for (Quiz quiz in _list) {
      quiz.isRight ? ++right : ++wrong;
    }
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text('right=$right; wrong=$wrong'),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('练习模式'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () {
              _submit();
            },
          )
        ],
      ),
      body: _buildExerciseListView(),
    );
  }
}
