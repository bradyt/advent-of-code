// ignore: unused_import
import 'dart:io';

import 'package:advent_of_code/aoc.dart';
import 'package:advent_of_code/data.dart';

void main() {
  var day = 6;
  var part = 1;
  var data;

  data = examplesAndSolutions[day].example;
  // data = File('input/day-0$day.txt').readAsStringSync();

  print(solution(day: day, part: part, data: data));
}
