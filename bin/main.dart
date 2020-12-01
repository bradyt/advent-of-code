// ignore: unused_import
import 'dart:io';

import 'package:advent_of_code/aoc.dart';
import 'package:advent_of_code/data.dart';

void main() {
  var day = DateTime.now().toUtc().subtract(Duration(hours: 5)).day;
  var part = (examplesAndSolutions[day].partTwoExampleSolution == null) ? 1 : 2;
  var data;

  data = examplesAndSolutions[day].example;

  var calculatedExampleSolution = solution(day: day, part: part, data: data);
  var expectedExampleSolution =
      examplesAndSolutions[day].solution(example: true, part: part);

  var completedExample = calculatedExampleSolution == expectedExampleSolution;

  if (completedExample) {
    data = File('input/day-${'$day'.padLeft(2, '0')}.txt').readAsStringSync();
  }

  print('day: $day, part: $part, example: ${!completedExample}');

  if (data.trim().isEmpty) throw Exception('input file empty');

  print(solution(day: day, part: part, data: data));
}
