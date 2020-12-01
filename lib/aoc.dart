import 'dart:io';
import 'dart:math';

import 'package:trotter/trotter.dart';

int solution({int day, int part, String data}) => {
      01: {1: day01, 2: day01_part2},
      02: {1: day02, 2: day02_part2},
      03: {1: day03, 2: day03_part2},
      04: {1: day04, 2: day04_part2},
      05: {1: day05, 2: day05_part2},
      06: {1: day06, 2: day06_part2},
      07: {1: day07, 2: day07_part2},
      08: {1: day08, 2: day08_part2},
      09: {1: day09, 2: day09_part2},
      10: {1: day10, 2: day10_part2},
      11: {1: day11, 2: day11_part2},
      12: {1: day12, 2: day12_part2},
      13: {1: day13, 2: day13_part2},
      14: {1: day14, 2: day14_part2},
      15: {1: day15, 2: day15_part2},
      16: {1: day16, 2: day16_part2},
      17: {1: day17, 2: day17_part2},
      18: {1: day18, 2: day18_part2},
      19: {1: day19, 2: day19_part2},
      20: {1: day20, 2: day20_part2},
      21: {1: day21, 2: day21_part2},
      22: {1: day22, 2: day22_part2},
      23: {1: day23, 2: day23_part2},
      24: {1: day24, 2: day24_part2},
      25: {1: day25, 2: day25_part2},
    }[day][part](data);

// day 1

Set day01Entries(String contents) =>
    contents.trim().split('\n').map((str) => int.parse(str)).toSet();

int day01(String contents) {
  var entries = day01Entries(contents);
  for (var x in entries) {
    var y = 2020 - x;
    if (entries.contains(y)) {
      return x * y;
    }
  }
  throw Error;
}

int day01_part2(String data) {
  var entries = day01Entries(data);
  for (var pair in Combinations(2, entries.toList())()) {
    var x = pair[0];
    var y = pair[1];
    var z = 2020 - x - y;
    if (entries.contains(z)) {
      return x * y * z;
    }
  }
  throw Error;
}

// day 2

int day02(String contents) {
  var lines = contents.trim().split('\n');
  var validPasswordCount = 0;
  RegExp exp = RegExp(r'^(\d+)-(\d+) (\w): (\w*)$');
  for (var line in lines) {
    var match = exp.firstMatch(line);
    var lowerBound = int.parse(match.group(1));
    var upperBound = int.parse(match.group(2));
    var letter = match.group(3);
    var password = match.group(4);
    var filteredPassword = password.replaceAll(RegExp('[^$letter]'), '');
    var letterFrequency = filteredPassword.length;
    var inBounds =
        letterFrequency >= lowerBound && letterFrequency <= upperBound;
    // print('*' * 80);
    // print('\'$password\' ÷ \'$letter\' = \'$filteredPassword\'');
    // print('$letterFrequency ' +
    //     (inBounds ? '∈' : '∉') +
    //     ' {$lowerBound, $upperBound}');
    if (inBounds) {
      validPasswordCount += 1;
    }
  }
  return validPasswordCount;
}

int day02_part2(String contents) {
  var lines = contents.trim().split('\n');
  var validPasswordCount = 0;
  RegExp exp = RegExp(r'^(\d+)-(\d+) (\w): (\w*)$');
  for (var line in lines) {
    var match = exp.firstMatch(line);
    var firstPosition = int.parse(match.group(1));
    var secondPosition = int.parse(match.group(2));
    var letter = match.group(3);
    var password = match.group(4);
    var first = password[firstPosition - 1];
    var second = password[secondPosition - 1];
    // print('*' * 80);
    // print(letter);
    // print('\'$password\'[$firstPosition] = $first');
    // print('\'$password\'[$secondPosition] = $second');
    if ((first == letter) ^ (second == letter)) {
      validPasswordCount += 1;
    }
  }
  return validPasswordCount;
}

// day 3

class Grid {
  Grid(String data)
      : _lines = data.trim().split('\n'),
        _width = data.trim().split('\n')[0].length,
        _position = MapEntry(0, 0);

  final List<String> _lines;
  final int _width;

  MapEntry _position;

  int get _x => _position.key;
  int get _y => _position.value;

  bool get atTree => _lines[_y][_x] == '#';

  void move({int delta_x, int delta_y}) {
    _position = MapEntry((_x + delta_x) % _width, _y + delta_y);
  }

  bool get atBottom => _y >= _lines.length;
}

int countTrees({Grid grid, int delta_x, int delta_y}) {
  int trees = 0;

  while (!grid.atBottom) {
    if (grid.atTree) {
      trees += 1;
    }
    grid.move(delta_x: delta_x, delta_y: delta_y);
  }
  return trees;
}

int day03(String contents) => countTrees(
      grid: Grid(contents),
      delta_x: 3,
      delta_y: 1,
    );

int day03_part2(String contents) {
  var ratios = [
    {'x': 1, 'y': 1},
    {'x': 3, 'y': 1},
    {'x': 5, 'y': 1},
    {'x': 7, 'y': 1},
    {'x': 1, 'y': 2},
  ];
  var result = ratios
      .map((ratio) => countTrees(
            grid: Grid(contents),
            delta_x: ratio['x'],
            delta_y: ratio['y'],
          ))
      .reduce((x, y) => x * y);
  return result;
}

// day 4

int day04(String contents) => contents
    .replaceAll(' ', '\n')
    .replaceAll(RegExp(r'cid:[^ \n]+[ \n]?'), '')
    .split('\n\n')
    .where((block) => block.trim().split('\n').length == 7)
    .length;

int day04_part2(String contents) {
  var passports = contents.split('\n\n').map((block) => {
        for (var pair in block
            .replaceAll(' ', '\n')
            .trim()
            .split('\n')
            .map((line) => line.split(':')))
          pair[0]: pair[1]
      });
  // passports.forEach((passport) {
  //   print('-' * 80);
  //   print(passport);
  //   print(validatePassport(passport));
  // });

  var result = passports.where((passport) => validatePassport(passport)).length;
  // print(result);
  return result;
}

// bool validateYear(String input, int lowerBound, int upperBound) {
//   if (input == null) return false;
//   int n = int.parse(input);
//   return n >= lowerBound && n <= upperBound;
// }

bool validateYear(String str, int lowerBound, int upperBound) {
  var match = RegExp(r'[0-9]{4}').firstMatch(str ?? '');
  var valid;
  if (match == null) {
    valid = false;
  } else {
    int n = int.parse(match.group(0));

    valid = n >= lowerBound && n <= upperBound;
  }
  return valid;
}

bool validateHeight(String hgt) {
  var hgtMatch = RegExp(r'([0-9]+)(in|cm)').firstMatch(hgt ?? '');
  var validHgt;

  if (hgtMatch == null) {
    validHgt = false;
  } else {
    int n = int.parse(hgtMatch.group(1));

    switch (hgtMatch.group(2)) {
      case 'cm':
        validHgt = n >= 150 && n <= 193;
        break;
      case 'in':
        validHgt = n >= 59 && n <= 76;
        break;
      default:
        validHgt = false;
        break;
    }
  }

  return validHgt;
}

bool validatePassport(Map passport) {
  return ['byr', 'iyr', 'eyr', 'hgt', 'hcl', 'ecl', 'pid']
      .every((key) => validate(
            key,
            passport[key],
          ));
}

bool validate(String key, String value) {
  bool valid;
  switch (key) {
    case 'byr':
      valid = validateYear(value, 1920, 2002);
      break;
    case 'iyr':
      valid = validateYear(value, 2010, 2020);
      break;
    case 'eyr':
      valid = validateYear(value, 2020, 2030);
      break;
    case 'hgt':
      valid = validateHeight(value);
      break;
    case 'hcl':
      valid = RegExp(r'^#[0-9a-f]{6}$').hasMatch(value ?? '');
      break;
    case 'ecl':
      valid = ['amb', 'blu', 'brn', 'gry', 'grn', 'hzl', 'oth'].contains(value);
      break;
    case 'pid':
      valid = RegExp(r'^\d{9}$').hasMatch(value ?? '');
      break;
    case 'cid':
      valid = true;
      break;
    default:
      valid = false;
  }
  return valid;
}

// day 5

int day05_convert(String boardingPass) => boardingPass
    .split('')
    .map((letter) => {'B': 1, 'F': 0, 'R': 1, 'L': 0}[letter])
    .fold(0, (prev, element) => 2 * prev + element);

int day05(String contents) =>
    contents.trim().split('\n').map(day05_convert).reduce((x, y) => max(x, y));

int day05_part2(String contents) {
  var sortedBoardingPasses =
      contents.trim().split('\n').map(day05_convert).toList()..sort();
  var lastBoardingPass = sortedBoardingPasses[0] - 3;
  for (var boardingPass in sortedBoardingPasses) {
    if (boardingPass == lastBoardingPass + 2) {
      return boardingPass - 1;
    }
    lastBoardingPass = boardingPass;
  }
  throw Error;
}

// day 6

int day06(String contents) => contents
    .split('\n\n')
    .map((block) => block.split('\n').join('').split('').toSet().length)
    .reduce((x, y) => x + y);

int day06_part2(String contents) => contents
    .split('\n\n')
    .map((block) => block
        .trim()
        .split('\n')
        .map((line) => line.split('').toSet())
        .reduce((x, y) => x.intersection(y))
        .length)
    .reduce((x, y) => x + y);

// day 7

int day07(String data) {}

int day07_part2(String data) {}

// day 8

int day08(String data) {}

int day08_part2(String data) {}

// day 9

int day09(String data) {}

int day09_part2(String data) {}

// day 10

int day10(String data) {}

int day10_part2(String data) {}

// day 11

int day11(String data) {}

int day11_part2(String data) {}

// day 12

int day12(String data) {}

int day12_part2(String data) {}

// day 13

int day13(String data) {}

int day13_part2(String data) {}

// day 14

int day14(String data) {}

int day14_part2(String data) {}

// day 15

int day15(String data) {}

int day15_part2(String data) {}

// day 16

int day16(String data) {}

int day16_part2(String data) {}

// day 17

int day17(String data) {}

int day17_part2(String data) {}

// day 18

int day18(String data) {}

int day18_part2(String data) {}

// day 19

int day19(String data) {}

int day19_part2(String data) {}

// day 20

int day20(String data) {}

int day20_part2(String data) {}

// day 21

int day21(String data) {}

int day21_part2(String data) {}

// day 22

int day22(String data) {}

int day22_part2(String data) {}

// day 23

int day23(String data) {}

int day23_part2(String data) {}

// day 24

int day24(String data) {}

int day24_part2(String data) {}

// day 25

int day25(String data) {}

int day25_part2(String data) {}
