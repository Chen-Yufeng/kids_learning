// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
import 'package:flutter/material.dart';
import 'package:kids_learning/Database.dart';
import 'package:kids_learning/Exercise.dart';
import 'package:kids_learning/Generator.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'Result.dart';

Future<List<Grade>> _gradeList;

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kids Learning',
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: ExerciseResults(),
    );
  }
}

class ExerciseResults extends StatefulWidget {
  ExerciseResultsState createState() => ExerciseResultsState();
}

class ExerciseResultsState extends State<ExerciseResults> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  void initState() {
    super.initState();
    _gradeList = DBProvider.db.grades();
  }

  Widget _buildRow(Grade grade) {
    return ListTile(
      title: Text(
        'id=${grade.id};right=${grade.right};wrong=${grade.wrong}',
        style: _biggerFont,
      ),
//      onTap: () {
//        setState(() {});
//      },
    );
  }

  void _showDialog(BuildContext context) async {
    Grade grade = await showDialog(
      context: context,
      builder: (context) {
        return _MyDialog();
      },
    );
    setState(() {
      _gradeList = DBProvider.db.grades();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Kids Learning'),
      ),
      body: _futureBuild(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showDialog(context);
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }

  Widget _futureBuild() {
    return FutureBuilder<List<Grade>>(
      future: _gradeList,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: snapshot.data.length * 2,
              itemBuilder: /*1*/ (context, i) {
                if (i.isOdd) return Divider(); /*2*/

                final index = i ~/ 2; /*3*/
                return _buildRow(snapshot.data[index]);
              });
        } else {
          return Center(child: CircularProgressIndicator(),);
        }
      },
    );
  }
}

class _MyDialog extends StatefulWidget {
  @override
  _MyDialogState createState() => _MyDialogState();
}

class _MyDialogState extends State<_MyDialog> {
  int _choose = 1;
  int _number = 30;
  int _range = 50;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('请选择练习类型'),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.add,
                  size: 40.0,
                ),
                color: _choose == 1 ? Colors.blue : null,
                onPressed: () {
                  setState(() {
                    _choose = 1;
                  });
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.remove,
                  size: 40.0,
                ),
                color: _choose == 2 ? Colors.blue : null,
                onPressed: () {
                  setState(() {
                    _choose = 2;
                  });
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.clear,
                  size: 40.0,
                ),
                color: _choose == 3 ? Colors.blue : null,
                onPressed: () {
                  setState(() {
                    _choose = 3;
                  });
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.vertical_align_center,
                  size: 40.0,
                ),
                color: _choose == 4 ? Colors.blue : null,
                onPressed: () {
                  setState(() {
                    _choose = 4;
                  });
                },
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 0),
            child: Text('范围: 0 ~ $_range'),
          ),
          Slider(
            value: _range.toDouble(),
            onChanged: (newValue) {
              setState(() {
                _range = newValue.toInt();
              });
            },
            min: 1.0,
            max: 100.0,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 0),
            child: Text('题目数量: $_number'),
          ),
          Slider(
            value: _number.toDouble(),
            onChanged: (newValue) {
              setState(() {
                _number = newValue.toInt();
              });
            },
            min: 1.0,
            max: 50.0,
          )
        ],
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () async {
            final List<int> result = await Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ExerciseMode(_choose, _number, _range),
            ));
            if (result == null) return;
            // todo: add to grade list
            var grade = Grade(
                id: 0, // not need.
                right: result[0],
                wrong: result[1],
                millisecondsSinceEpoch: DateTime.now().millisecondsSinceEpoch
            );
            DBProvider.db.insertGrade(grade)
            .whenComplete(() {
              Navigator.pop(context, grade);
            });
          },
          child: Text('确认'),
        ),
        FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('取消'),
        )
      ],
    );
  }
}
