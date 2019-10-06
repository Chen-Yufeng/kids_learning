// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

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
  final _suggestions = <WordPair>[];
  final _saved = Set<WordPair>();
  final _biggerFont = const TextStyle(fontSize: 18.0);

  Widget _buildSuggestions() {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: /*1*/ (context, i) {
          if (i.isOdd) return Divider(); /*2*/

          final index = i ~/ 2; /*3*/
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10)); /*4*/
          }
          return _buildRow(_suggestions[index]);
        });
  }

  Widget _buildRow(WordPair pair) {
    final bool alreadySaved = _saved.contains(pair);
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        });
      },
    );
  }

  void _pushSaved() {
    Navigator.of(context)
        .push(MaterialPageRoute<void>(builder: (BuildContext context) {
      final Iterable<ListTile> tiles = _saved.map((WordPair pair) {
        return ListTile(
          title: Text(
            pair.asPascalCase,
            style: _biggerFont,
          ),
        );
      });
      final List<Widget> divided = ListTile.divideTiles(
        context: context,
        tiles: tiles,
      ).toList();
      return Scaffold(
        appBar: AppBar(
          title: Text('Saved Suggestions'),
        ),
        body: ListView(children: divided),
      );
    }));
  }

  void _showDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return _MyDialog();
        },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kids Learning'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.list),
            onPressed: _pushSaved,
          )
        ],
      ),
      body: _buildSuggestions(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showDialog();
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }
}

class _MyDialog extends StatefulWidget {

  @override
  _MyDialogState createState() => _MyDialogState();
}

class _MyDialogState extends State<_MyDialog> {
  int _choose = 0;
  int _number = 30;

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
                icon: Icon(Icons.add, size: 40.0,),
                color: _choose == 1 ? Colors.blue : null,
                onPressed: () {
                  setState(() {
                    _choose = 1;
                  });
                },
              ),
              IconButton(
                icon: Icon(Icons.remove, size: 40.0,),
                color: _choose == 2 ? Colors.blue : null,
                onPressed: () {
                  setState(() {
                    _choose = 2;
                  });
                },
              ),
              IconButton(
                icon: Icon(Icons.clear, size: 40.0,),
                color: _choose == 3 ? Colors.blue : null,
                onPressed: () {
                  setState(() {
                    _choose = 3;
                  });
                },
              ),
              IconButton(
                icon: Icon(Icons.vertical_align_center, size: 40.0,),
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
          onPressed: () {
            
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