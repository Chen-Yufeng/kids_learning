import 'package:sqflite/sqflite.dart';

class Grade {
  final int id;
  final int right;
  final int wrong;
  final int millisecondsSinceEpoch;

  Grade({this.id, this.right, this.wrong, this.millisecondsSinceEpoch});

  Map<String, dynamic> toMap() {
    return {
      'id' : id,
      'right' : right,
      'wrong' : wrong,
      'milliseconds_since_epoch' : millisecondsSinceEpoch,
    };
  }
}
