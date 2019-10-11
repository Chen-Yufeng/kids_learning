import 'dart:math';

class ExerciseGenerator {
  static final _mul = [-1, 1, 1, -2, 1, 2, 2, 1, -3, 1, 3, 3, 1, -4, 1, 4, 2, 2, 4, 1, -5, 1, 5, 5, 1, -6, 1, 6, 2, 3, 3, 2, 6, 1, -7, 1, 7, 7, 1, -8, 1, 8, 2, 4, 4, 2, 8, 1, -9, 1, 9, 3, 3, 9, 1, -10, 1, 10, 2, 5, 5, 2, 10, 1, -11, 1, 11, 11, 1, -12, 1, 12, 2, 6, 3, 4, 4, 3, 6, 2, 12, 1, -13, 1, 13, 13, 1, -14, 1, 14, 2, 7, 7, 2, 14, 1, -15, 1, 15, 3, 5, 5, 3, 15, 1, -16, 1, 16, 2, 8, 4, 4, 8, 2, 16, 1, -17, 1, 17, 17, 1, -18, 1, 18, 2, 9, 3, 6, 6, 3, 9, 2, 18, 1, -19, 1, 19, 19, 1, -20, 1, 20, 2, 10, 4, 5, 5, 4, 10, 2, 20, 1, -21, 1, 21, 3, 7, 7, 3, 21, 1, -22, 1, 22, 2, 11, 11, 2, 22, 1, -23, 1, 23, 23, 1, -24, 1, 24, 2, 12, 3, 8, 4, 6, 6, 4, 8, 3, 12, 2, 24, 1, -25, 1, 25, 5, 5, 25, 1, -26, 1, 26, 2, 13, 13, 2, 26, 1, -27, 1, 27, 3, 9, 9, 3, 27, 1, -28, 1, 28, 2, 14, 4, 7, 7, 4, 14, 2, 28, 1, -29, 1, 29, 29, 1, -30, 1, 30, 2, 15, 3, 10, 5, 6, 6, 5, 10, 3, 15, 2, 30, 1, -31, 1, 31, 31, 1, -32, 1, 32, 2, 16, 4, 8, 8, 4, 16, 2, 32, 1, -33, 1, 33, 3, 11, 11, 3, 33, 1, -34, 1, 34, 2, 17, 17, 2, 34, 1, -35, 1, 35, 5, 7, 7, 5, 35, 1, -36, 1, 36, 2, 18, 3, 12, 4, 9, 6, 6, 9, 4, 12, 3, 18, 2, 36, 1, -37, 1, 37, 37, 1, -38, 1, 38, 2, 19, 19, 2, 38, 1, -39, 1, 39, 3, 13, 13, 3, 39, 1, -40, 1, 40, 2, 20, 4, 10, 5, 8, 8, 5, 10, 4, 20, 2, 40, 1, -41, 1, 41, 41, 1, -42, 1, 42, 2, 21, 3, 14, 6, 7, 7, 6, 14, 3, 21, 2, 42, 1, -43, 1, 43, 43, 1, -44, 1, 44, 2, 22, 4, 11, 11, 4, 22, 2, 44, 1, -45, 1, 45, 3, 15, 5, 9, 9, 5, 15, 3, 45, 1, -46, 1, 46, 2, 23, 23, 2, 46, 1, -47, 1, 47, 47, 1, -48, 1, 48, 2, 24, 3, 16, 4, 12, 6, 8, 8, 6, 12, 4, 16, 3, 24, 2, 48, 1, -49, 1, 49, 7, 7, 49, 1, -50, 1, 50, 2, 25, 5, 10, 10, 5, 25, 2, 50, 1, -51, 1, 51, 3, 17, 17, 3, 51, 1, -52, 1, 52, 2, 26, 4, 13, 13, 4, 26, 2, 52, 1, -53, 1, 53, 53, 1, -54, 1, 54, 2, 27, 3, 18, 6, 9, 9, 6, 18, 3, 27, 2, 54, 1, -55, 1, 55, 5, 11, 11, 5, 55, 1, -56, 1, 56, 2, 28, 4, 14, 7, 8, 8, 7, 14, 4, 28, 2, 56, 1, -57, 1, 57, 3, 19, 19, 3, 57, 1, -58, 1, 58, 2, 29, 29, 2, 58, 1, -59, 1, 59, 59, 1, -60, 1, 60, 2, 30, 3, 20, 4, 15, 5, 12, 6, 10, 10, 6, 12, 5, 15, 4, 20, 3, 30, 2, 60, 1, -61, 1, 61, 61, 1, -62, 1, 62, 2, 31, 31, 2, 62, 1, -63, 1, 63, 3, 21, 7, 9, 9, 7, 21, 3, 63, 1, -64, 1, 64, 2, 32, 4, 16, 8, 8, 16, 4, 32, 2, 64, 1, -65, 1, 65, 5, 13, 13, 5, 65, 1, -66, 1, 66, 2, 33, 3, 22, 6, 11, 11, 6, 22, 3, 33, 2, 66, 1, -67, 1, 67, 67, 1, -68, 1, 68, 2, 34, 4, 17, 17, 4, 34, 2, 68, 1, -69, 1, 69, 3, 23, 23, 3, 69, 1, -70, 1, 70, 2, 35, 5, 14, 7, 10, 10, 7, 14, 5, 35, 2, 70, 1, -71, 1, 71, 71, 1, -72, 1, 72, 2, 36, 3, 24, 4, 18, 6, 12, 8, 9, 9, 8, 12, 6, 18, 4, 24, 3, 36, 2, 72, 1, -73, 1, 73, 73, 1, -74, 1, 74, 2, 37, 37, 2, 74, 1, -75, 1, 75, 3, 25, 5, 15, 15, 5, 25, 3, 75, 1, -76, 1, 76, 2, 38, 4, 19, 19, 4, 38, 2, 76, 1, -77, 1, 77, 7, 11, 11, 7, 77, 1, -78, 1, 78, 2, 39, 3, 26, 6, 13, 13, 6, 26, 3, 39, 2, 78, 1, -79, 1, 79, 79, 1, -80, 1, 80, 2, 40, 4, 20, 5, 16, 8, 10, 10, 8, 16, 5, 20, 4, 40, 2, 80, 1, -81, 1, 81, 3, 27, 9, 9, 27, 3, 81, 1, -82, 1, 82, 2, 41, 41, 2, 82, 1, -83, 1, 83, 83, 1, -84, 1, 84, 2, 42, 3, 28, 4, 21, 6, 14, 7, 12, 12, 7, 14, 6, 21, 4, 28, 3, 42, 2, 84, 1, -85, 1, 85, 5, 17, 17, 5, 85, 1, -86, 1, 86, 2, 43, 43, 2, 86, 1, -87, 1, 87, 3, 29, 29, 3, 87, 1, -88, 1, 88, 2, 44, 4, 22, 8, 11, 11, 8, 22, 4, 44, 2, 88, 1, -89, 1, 89, 89, 1, -90, 1, 90, 2, 45, 3, 30, 5, 18, 6, 15, 9, 10, 10, 9, 15, 6, 18, 5, 30, 3, 45, 2, 90, 1, -91, 1, 91, 7, 13, 13, 7, 91, 1, -92, 1, 92, 2, 46, 4, 23, 23, 4, 46, 2, 92, 1, -93, 1, 93, 3, 31, 31, 3, 93, 1, -94, 1, 94, 2, 47, 47, 2, 94, 1, -95, 1, 95, 5, 19, 19, 5, 95, 1, -96, 1, 96, 2, 48, 3, 32, 4, 24, 6, 16, 8, 12, 12, 8, 16, 6, 24, 4, 32, 3, 48, 2, 96, 1, -97, 1, 97, 97, 1, -98, 1, 98, 2, 49, 7, 14, 14, 7, 49, 2, 98, 1, -99, 1, 99, 3, 33, 9, 11, 11, 9, 33, 3, 99, 1, -100, 1, 100, 2, 50, 4, 25, 5, 20, 10, 10, 20, 5, 25, 4, 50, 2, 100, 1];

  static List<Quiz> generate(int choose, int number, int max) {
    switch (choose) {
      case 1:
        return generateAddition(number, max);
      case 2:
        return generateSubtraction(number, max);
      case 3:
        return generateMultiplication(number, max);
      case 4:
        return generateDivision(number, max);
      default:
        return null;
    }
  }

  static Quiz processForSQLite(Quiz quiz, int choose) {
    var date = DateTime.now();
    switch (choose) {
      case 1:
        quiz.operator = '+';
        break;
      case 2:
        quiz.operator = '-';
        break;
      case 3:
        quiz.operator = '×';
        break;
      case 4:
        quiz.operator = '÷';
        break;
      default:
        break;
    }
    quiz.year = date.year;
    quiz.month = date.month;
    quiz.day = date.day;

    return quiz;
  }

  static List<Quiz> generateAddition(int number, int max) {
    List<Quiz> list = new List();
    var random = new Random();

    for (int i = 0; i < number; ++i) {
     Quiz quiz = new Quiz();
     quiz.isRight = false;
     quiz.answer = random.nextInt(max);
     quiz.first = random.nextInt(quiz.answer + 1);
     quiz.second = quiz.answer - quiz.first;
     list.add(processForSQLite(quiz, 1));
    }

    return list;
  }

  static List<Quiz> generateSubtraction(int number, int max) {
    List<Quiz> list = new List();
    var random = new Random();

    for (int i = 0; i < number; ++i) {
      Quiz quiz = new Quiz();
      quiz.isRight = false;
      quiz.first = random.nextInt(max);
      quiz.second = random.nextInt(quiz.first + 1);
      quiz.answer = quiz.first - quiz.second;
      list.add(processForSQLite(quiz, 2));
    }

    return list;
  }
// [1,100]
  static List<Quiz> generateMultiplication(int number, int max) {
    List<Quiz> all = new List();
    int index = 1, answer = 1;
    while (answer <= max) {
      Quiz quiz = Quiz();
      quiz.isRight = false;
      quiz.first = _mul[index++];
      quiz.second = _mul[index++];
      quiz.answer = answer;
      processForSQLite(quiz, 3);
      all.add(quiz);
      if (_mul[index] < 0) {
        answer = _mul[index++] * -1;
      }
    }

    List<Quiz> list = new List();
    var random = new Random();

    for (int i = 0; i < number; ++i) {
      list.add(all[random.nextInt(all.length)]);
    }

    return list;
  }

  static List<Quiz> generateDivision(int number, int max) {
    List<Quiz> all = new List();
    int index = 1, answer = 1;
    while (answer <= max) {
      Quiz quiz = Quiz();
      quiz.isRight = false;
      quiz.first = answer;
      quiz.second = _mul[index++];
      quiz.answer = _mul[index++];
      processForSQLite(quiz, 4);
      all.add(quiz);
      if (_mul[index] < 0) {
        answer = _mul[index++] * -1;
      }
    }

    List<Quiz> list = new List();
    var random = new Random();

    for (int i = 0; i < number; ++i) {
      list.add(all[random.nextInt(all.length)]);
    }

    return list;
  }
}

class Quiz {
  int id;
  int first;
  int second;
  int answer;
  String operator;
  int year;
  int month;
  int day;
  int input;
  bool isRight = false;


  Quiz({this.id, this.first, this.second, this.answer, this.operator, this.year, this.month, this.day});

  Map<String, dynamic> toMap() {
    return {
      'id' : id,
      'first' : first,
      'second' : second,
      'answer' : answer,
      'operator' : operator,
      'year' : year,
      'month' : month,
      'day' : day,
    };
  }
}