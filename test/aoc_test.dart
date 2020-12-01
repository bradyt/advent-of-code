import 'dart:io';

import 'package:test/test.dart';

import '../examplesAndSolutions.dart';
import '../lib/aoc.dart';

void main() {
  group('test day 1', () {
    test('test day 1 part 1 example', () {
      testDayPartExample(day: 1, part: 1);
    });
    test('test day 1 part 1', () {
      testDayPartExample(day: 1, part: 1, example: false);
    });
    test('test day 1 part 2 example', () {
      testDayPartExample(day: 1, part: 2);
    });
    test('test day 1 part 2', () {
      testDayPartExample(day: 1, part: 2, example: false);
    });
  });
  group('test day 2', () {
    test('test day 2 part 1 example', () {
      testDayPartExample(day: 2, part: 1);
    });
    test('test day 2 part 1', () {
      testDayPartExample(day: 2, part: 1, example: false);
    });
    test('test day 2 part 2 example', () {
      testDayPartExample(day: 2, part: 2);
    });
    test('test day 2 part 2', () {
      testDayPartExample(day: 2, part: 2, example: false);
    });
  });
  group('test day 3', () {
    test('test day 3 part 1 example', () {
      testDayPartExample(day: 3, part: 1);
    });
    test('test day 3 part 1', () {
      testDayPartExample(day: 3, part: 1, example: false);
    }, skip: true);
    test('test day 3 part 2 example', () {
      testDayPartExample(day: 3, part: 2);
    }, skip: true);
    test('test day 3 part 2', () {
      testDayPartExample(day: 3, part: 2, example: false);
    }, skip: true);
  });
}

void testDayPartExample({int day, int part, bool example = true}) {
  var calculatedSolution = solution(
      day: day,
      part: part,
      data: example
          ? examplesAndSolutions[day].example
          : File('day-0$day.txt').readAsStringSync());

  var expectedSolution =
      examplesAndSolutions[day].solution(example: example, part: part);

  // print('-' * 80);
  // print('day: $day, part: $part, example: $example');
  // print('calculated: $calculatedSolution');
  // print('expected: $expectedSolution');
  assert(calculatedSolution == expectedSolution);
}
