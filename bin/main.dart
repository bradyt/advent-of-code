// ignore: unused_import
import 'dart:io';

import 'package:advent_of_code/aoc.dart';
import 'package:advent_of_code/data.dart';

void main() {
  var day = DateTime.now().toUtc().subtract(Duration(hours: 5)).day;
  var part = (examplesAndSolutions[day].partTwoExampleSolution == null) ? 1 : 2;
  var data;

  data = examplesAndSolutions[day].example;
  data = File('input/day-${'$day'.padLeft(2, '0')}.txt').readAsStringSync();

  print(solution(day: day, part: part, data: data));
}
