import 'dart:io';

import 'package:test/test.dart';

import 'package:advent_of_code/aoc.dart';
import 'package:advent_of_code/data.dart';

void main() {
  runTestGroup(day: 1);
  runTestGroup(day: 2);
  runTestGroup(day: 3);
  group('test day 4;', () {
    runTest(4, part: 1, example: true);
    runTest(4, part: 1);
    test('part 2 examples', () {
      expect(validate('byr', '2002'), true);
      expect(validate('byr', '2003'), false);
      expect(validate('hgt', '60in'), true);
      expect(validate('hgt', '190cm'), true);
      expect(validate('hgt', '190in'), false);
      expect(validate('hgt', '190'), false);
      expect(validate('hcl', '#123abc'), true);
      expect(validate('hcl', '#123abz'), false);
      expect(validate('hcl', '123abc'), false);
      expect(validate('ecl', 'brn'), true);
      expect(validate('ecl', 'wat'), false);
      expect(validate('pid', '000000001'), true);
      expect(validate('pid', '0123456789'), false);
    });
    runTest(4, part: 2);
  });
  group('test day 5;', () {
    test('part 1 examples', () {
      expect(day05_convert('FBFBBFFRLR'), 357);
      expect(day05_convert('BFFFBBFRRR'), 567);
      expect(day05_convert('FFFBBBFRRR'), 119);
      expect(day05_convert('BBFFBBFRLL'), 820);
    });
    runTest(5, part: 1);
    runTest(5, part: 2);
  });
  runTestGroup(day: 06);
  runTestGroup(day: 07);
  runTestGroup(day: 08);
  runTestGroup(day: 09);
  runTestGroup(day: 10);
  runTestGroup(day: 11);
  runTestGroup(day: 12);
  runTestGroup(day: 13);
  runTestGroup(day: 14);
  runTestGroup(day: 15);
  runTestGroup(day: 16);
  runTestGroup(day: 17);
  runTestGroup(day: 18);
  runTestGroup(day: 19);
  runTestGroup(day: 20);
  runTestGroup(day: 21);
  runTestGroup(day: 22);
  runTestGroup(day: 23);
  runTestGroup(day: 24);
  runTestGroup(day: 25);
}

void runTestGroup({int day}) {
  group('test day $day', () {
    runTest(day, part: 1, example: true);
    runTest(day, part: 1);
    runTest(day, part: 2, example: true);
    runTest(day, part: 2);
  });
}

void runTest(int day, {int part, bool example = false}) {
  test(('Test part $part${example ? '' : ' example'}'), () {
    testDayPartExample(day: day, part: part, example: example);
  });
}

void testDayPartExample({int day, int part, bool example = false}) {
  var calculatedSolution = solution(
      day: day,
      part: part,
      data: example
          ? examplesAndSolutions[day].example
          : File('input/day-${'$day'.padLeft(2, '0')}.txt').readAsStringSync());

  var expectedSolution =
      examplesAndSolutions[day].solution(example: example, part: part);

  // print('-' * 80);
  // print('day: $day, part: $part, example: $example');
  // print('calculated: $calculatedSolution');
  // print('expected: $expectedSolution');
  expect(calculatedSolution, expectedSolution);
}
