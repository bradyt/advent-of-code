import 'dart:io';

import '../examplesAndSolutions.dart';
import '../lib/aoc.dart';

void main() {
  String data;
  assert(0 == 0);
  data = File('day-01.txt').readAsStringSync();
  print(0);
  assert(
    day01(data) == examplesAndSolutions[1],
  );
  print(1);
}
