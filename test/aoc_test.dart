import 'dart:io';

import 'package:test/test.dart';

import '../examplesAndSolutions.dart';
import '../lib/aoc.dart';

void main() {
  group('test day 1', () {
    test('part 1 example', () {
      testDayPartExample(day: 1, part: 1);
    });
    test('part 1', () {
      testDayPartExample(day: 1, part: 1, example: false);
    });
    test('part 2 example', () {
      testDayPartExample(day: 1, part: 2);
    });
    test('part 2', () {
      testDayPartExample(day: 1, part: 2, example: false);
    });
  });
  group('test day 2', () {
    test('part 1 example', () {
      testDayPartExample(day: 2, part: 1);
    });
    test('part 1', () {
      testDayPartExample(day: 2, part: 1, example: false);
    });
    test('part 2 example', () {
      testDayPartExample(day: 2, part: 2);
    });
    test('part 2', () {
      testDayPartExample(day: 2, part: 2, example: false);
    });
  });
  group('test day 3', () {
    test('part 1 example', () {
      testDayPartExample(day: 3, part: 1);
    });
    test('part 1', () {
      testDayPartExample(day: 3, part: 1, example: false);
    });
    test('part 2 example', () {
      testDayPartExample(day: 3, part: 2);
    });
    test('part 2', () {
      testDayPartExample(day: 3, part: 2, example: false);
    });
  });
  group('test day 4;', () {
    test('part 1 example', () {
      testDayPartExample(day: 4, part: 1);
    });
    test('part 1', () {
      testDayPartExample(day: 4, part: 1, example: false);
    });
    test('part 2 example', () {
      testDayPartExample(day: 4, part: 2);
    }, skip: true);
    test('part 2', () {
      testDayPartExample(day: 4, part: 2, example: false);
    }, skip: true);
  });
  group('test day 5;', () {
    test('part 1 examples', () {
      expect(day05_convert('FBFBBFFRLR'), 357);
      expect(day05_convert('BFFFBBFRRR'), 567);
      expect(day05_convert('FFFBBBFRRR'), 119);
      expect(day05_convert('BBFFBBFRLL'), 820);
    });
    test('part 1', () {
      testDayPartExample(day: 5, part: 1, example: false);
    });
    test('part 2', () {
      testDayPartExample(day: 5, part: 2, example: false);
    });
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
