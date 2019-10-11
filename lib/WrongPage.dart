import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart' show CalendarCarousel;
import 'package:kids_learning/WrongDatabase.dart';

import 'Generator.dart';

class WrongPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _WrongState();
  }
}

class _WrongState extends State<WrongPage> {
  DateTime _currentDate = DateTime.now();
  final _biggerFont = const TextStyle(fontSize: 18.0);
  Future<List<Quiz>> _list;

  @override
  void initState() {
    super.initState();
    _list = WrongDBProvider.db.wrongOfADay(_currentDate.year, _currentDate.month, _currentDate.day);
  }

  Widget widgetCalendar() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0),
      child: CalendarCarousel<Event>(
        onDayPressed: (DateTime date, List<Event> events) {
          this.setState(() {
            _currentDate = date;
            _list = WrongDBProvider.db.wrongOfADay(_currentDate.year, _currentDate.month, _currentDate.day);
          });
        },
        weekendTextStyle: TextStyle(
          color: Colors.red,
        ),
        thisMonthDayBorderColor: Colors.grey,
//      weekDays: null, /// for pass null when you do not want to render weekDays
//      headerText: Container( /// Example for rendering custom header
//        child: Text('Custom Header'),
//      ),
        customDayBuilder: (   /// you can provide your own build function to make custom day containers
            bool isSelectable,
            int index,
            bool isSelectedDay,
            bool isToday,
            bool isPrevMonthDay,
            TextStyle textStyle,
            bool isNextMonthDay,
            bool isThisMonthDay,
            DateTime day,
            ) {
          /// If you return null, [CalendarCarousel] will build container for current [day] with default function.
          /// This way you can build custom containers for specific days only, leaving rest as default.

          // Example: every 15th of month, we have a flight, we can place an icon in the container like that:
//          if (day.day == 15) {
//            return Center(
//              child: Icon(Icons.local_airport),
//            );
//          } else {
//            return null;
//          }
            return null;
        },
        weekFormat: false,
//        markedDatesMap: _markedDateMap,
        height: 420.0,
        selectedDateTime: _currentDate,
        daysHaveCircularBorder: false, /// null for not rendering any border, true for circular border, false for rectangular border
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        children: <Widget>[
          widgetCalendar(),
          FutureBuilder<List<Quiz>>(
            future: _list,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
//                  scrollDirection: Axis.vertical,
                physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: snapshot.data.length * 2,
                  itemBuilder: (context, i) {
                    if (i.isOdd) {
                      return Divider();
                    } else {
                      var quiz = snapshot.data[i ~/ 2];
                      return ListTile(
                        title: Center(
                          child: Text('${quiz.first} ${quiz.operator} ${quiz.second} = ${quiz.answer}', style: _biggerFont,),
                        ),
                      );
                    }
                  },
                );
              } else {
                return Center(
                  child: Text('没有错题哦~'),
                );
              }
            },
          )
        ],
      )
    );
  }
}