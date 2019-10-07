import 'package:flutter/material.dart';

class Exercise extends StatelessWidget {
  final _choose;
  final _number;

  Exercise(this._choose, this._number);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '练习模式',
      theme: ThemeData(
        primaryColor: Colors.white
      ),
      home: ExerciseMode(_choose, _number),
    );
  }
}

class ExerciseMode extends StatefulWidget {
  final _choose;
  final _number;

  ExerciseMode(this._choose, this._number);

  @override
  State<StatefulWidget> createState() {
    return ExerciseModeState(_choose, _number);
  }
}

class ExerciseModeState extends State<ExerciseMode> {
  final _choose;
  final _number;

  ExerciseModeState(this._choose, this._number);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('练习模式'),
      ),
    );
  }
}
