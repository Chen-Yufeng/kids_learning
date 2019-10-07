import 'dart:math';

class ExerciseGenerator {
  static List<Quiz> generate(int choose, int number, int max) {
    switch (choose) {
      case 1:
        return generateAddition(number, max);
      case 2:
        return generateSubtraction(number, max);
//      case 3:
//        return generateMultiplication(number, max);
//      case 4:
//        return generateDivision(number, max);
      default:
        return null;
    }
  }

  static List<Quiz> generateAddition(int number, int max) {
    List<Quiz> list = new List();
    var random = new Random();

    for (int i = 0; i < number; ++i) {
     Quiz quiz = new Quiz();
     quiz.isRight = false;
     quiz.answer = random.nextInt(max);
     quiz.first = random.nextInt(quiz.answer);
     quiz.second = quiz.answer - quiz.first;
     list.add(quiz);
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
      quiz.second = random.nextInt(quiz.first);
      quiz.answer = quiz.first - quiz.second;
      list.add(quiz);
    }

    return list;
  }

  static List<Quiz> generateMultiplication(int number, int max) {
    List<Quiz> list = new List();
    var random = new Random();

    for (int i = 0; i < number; ++i) {
      Quiz quiz = new Quiz();
      quiz.isRight = false;
      quiz.answer = random.nextInt(max);
      quiz.first = random.nextInt(max - 1) + 1;
      int tmp = quiz.answer ~/ quiz.first;

    }

    return list;
  }

  static List<Quiz> generateDivision(int number, int max) {
    List<Quiz> list = new List();

    for (int i = 0; i < number; ++i) {

    }

    return list;
  }
}

class Quiz {
  int first;
  int second;
  int answer;
  int input;
  bool isRight = false;
}