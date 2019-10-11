import 'package:flutter/material.dart';
import 'package:kids_learning/Exercise.dart';
import 'package:kids_learning/ExerciseResultPage.dart';

import 'StaticPage.dart';
import 'WrongPage.dart';

class IndexPage extends StatefulWidget {
  @override
  State createState() {
    return _IndexState();
  }
}

class _IndexState extends State<IndexPage> {
  final List<BottomNavigationBarItem> bottomNavItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.event_note),
      title: Text('错题'),
      backgroundColor: Colors.blue,
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.create),
      title: Text('练习'),
      backgroundColor: Colors.blue,
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.timeline),
      title: Text('统计'),
      backgroundColor: Colors.blue,
    ),
  ];
  int currentIndex;
  final pages = [WrongPage(), ExerciseResultsPage(), StaticPage()];

  @override
  void initState() {
    super.initState();
    currentIndex = 1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('KidsLearning'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: bottomNavItems,
        currentIndex: currentIndex,
        type: BottomNavigationBarType.shifting,
        onTap: (index) {
          _changePage(index);
        },
      ),
      body: pages[currentIndex],
    );
  }

  void _changePage(int index) {
    if (index != currentIndex) {
      setState(() {
        currentIndex = index;
      });
    }
  }
}
