import 'dart:math';

class RandomTool {
  static int genInt({int min = 0, int max = 100}) {
    var x = Random().nextInt(max) + min;
    return x.floor();
  }
}