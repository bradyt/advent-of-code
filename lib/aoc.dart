import 'dart:math';

import 'package:trotter/trotter.dart';

int solution({int day, int part, String data}) => {
      01: day01,
      02: day02,
      03: day03,
      04: day04,
      05: day05,
      06: day06,
      07: day07,
      08: day08,
      09: day09,
      10: day10,
      11: day11,
      12: day12,
      13: day13,
      14: day14,
      15: day15,
      16: day16,
      17: day17,
      18: day18,
      19: day19,
      20: day20,
      21: day21,
      22: day22,
      23: day23,
      24: day24,
      25: day25,
    }[day](part, data);

// day 1

Set day01Entries(String contents) =>
    contents.trim().split('\n').map((str) => int.parse(str)).toSet();

int day01(int part, String contents) =>
    (part == 1) ? day01_part1(contents) : day01_part2(contents);

int day01_part1(String contents) {
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

int day02(int part, String contents) =>
    (part == 1) ? day02_part1(contents) : day02_part2(contents);

int day02_part1(String contents) {
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

int day03(int part, String contents) =>
    (part == 1) ? day03_part1(contents) : day03_part2(contents);

int day03_part1(String contents) => countTrees(
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

int day04(int part, String contents) =>
    (part == 1) ? day04_part1(contents) : day04_part2(contents);

int day04_part1(String contents) => contents
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

int day05(int part, String contents) =>
    (part == 1) ? day05_part1(contents) : day05_part2(contents);

int day05_part1(String contents) =>
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

int day06(int part, String contents) =>
    (part == 1) ? day06_part1(contents) : day06_part2(contents);

int day06_part1(String contents) => contents
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

int day07(int part, String data) =>
    (part == 1) ? day07_part1(data) : day07_part2(data);

Map day07_parser(data) {
  var map = {};

  data.trim().split('\n').forEach((line) {
    var match = RegExp(r'^(\w+ \w+) bags contain (.+)\.$').firstMatch(line);
    var bag = match.group(1);
    var requiredContents = match.group(2).split(', ');
    map[bag] = {};
    if (requiredContents[0] != 'no other bags') {
      var bagExp = RegExp(r'(\d+) (.+) bags?');
      var bagMatch;
      requiredContents.forEach((bags) {
        bagMatch = bagExp.firstMatch(bags);
        map[bag][bagMatch.group(2)] = int.parse(bagMatch.group(1));
      });
    }
  });

  return map;
}

Map day07_partOneGraphFlip(Map graph) {
  var result = {};

  for (var key in graph.keys) {
    result[key] = <String>{};
  }

  for (var entry in graph.entries) {
    for (var key in entry.value.keys) {
      result[key].add(entry.key);
    }
  }

  return result;
}

int day07_part1(String data) {
  var parsedData = day07_parser(data);
  var invertedTree = day07_partOneGraphFlip(parsedData);

  var visitedBags = <String>{};
  var currentDepth = {'shiny gold'};

  while (currentDepth.isNotEmpty) {
    currentDepth = currentDepth
        .map((bag) => invertedTree[bag])
        .reduce((x, y) => x.union(y))
          ..removeAll(visitedBags);
    visitedBags.addAll(currentDepth);
  }

  return visitedBags.length;
}

class Day07HowManyBags {
  Day07HowManyBags({Map rules})
      : _rules = rules,
        _cache = {};

  final Map _rules;
  final Map _cache;

  int howManyBags(String bag) {
    if (_cache.containsKey(bag)) {
      return _cache[bag];
    }
    _cache[bag] = _rules[bag]
        .entries
        .map((entry) => entry.value * (1 + howManyBags(entry.key)))
        .fold(0, (prev, element) => prev + element);
    return _cache[bag];
  }
}

int day07_part2(String data) {
  var parsedData = day07_parser(data);
  var howManyBags = Day07HowManyBags(rules: parsedData);
  return howManyBags.howManyBags('shiny gold');
}

// day 8

int day08(int part, String data) =>
    (part == 1) ? day08_part1(data) : day08_part2(data);

class Day08Instruction {
  Day08Instruction({this.operation, this.argument});

  final String operation;
  final int argument;
}

List<Day08Instruction> day08_parser(String data) => data
    .trim()
    .split('\n')
    .map((line) => Day08Instruction(
          operation: line.split(' ')[0],
          argument: int.parse(line.split(' ')[1]),
        ))
    .toList();

class Delta {
  Delta({this.position, this.accumulator});

  final position;
  final accumulator;

  factory Delta.fromInstruction(Day08Instruction instruction) {
    var delta_position = 1;
    var delta_accumulator = 0;

    switch (instruction.operation) {
      case 'acc':
        delta_accumulator = instruction.argument;
        break;
      case 'jmp':
        delta_position = instruction.argument;
        break;
      case 'nop':
        break;
    }

    return Delta(
      position: delta_position,
      accumulator: delta_accumulator,
    );
  }
}

int calculateAccumulator({List instructions, bool mustTerminate}) {
  var accumulator = 0;
  var position = 0;

  var allowedPositions = {
    ...List.generate(instructions.length, (i) => i),
  };

  while (allowedPositions.contains(position)) {
    allowedPositions.remove(position);

    var delta = Delta.fromInstruction(instructions[position]);

    accumulator += delta.accumulator;
    position += delta.position;
  }

  if (mustTerminate && position != instructions.length) {
    return null;
  }
  return accumulator;
}

int day08_part1(String data) => calculateAccumulator(
      instructions: day08_parser(data),
      mustTerminate: false,
    );

int day08_part2(String data) {
  var instructions = day08_parser(data);

  List flipAtElement(int index, List instructions) {
    var flippedInstruction = Day08Instruction(
      operation: {
        'jmp': 'nop',
        'nop': 'jmp',
        'acc': 'acc',
      }[instructions[index].operation],
      argument: instructions[index].argument,
    );
    instructions[index] = flippedInstruction;
    return instructions;
  }

  var accumulator;

  for (var i = 0; i < instructions.length; i++) {
    accumulator = calculateAccumulator(
      instructions: flipAtElement(i, List.from(instructions)),
      mustTerminate: true,
    );
    if (accumulator != null) break;
  }

  return accumulator;
}

// day 9

int day09(int part, String data) =>
    (part == 1) ? day09_part1(data) : day09_part2(data);

int day09_part1(String data) {
  var input = data.trim().split('\n').map((line) => int.parse(line)).toList();

  var preambleLength = (input.length < 25) ? 5 : 25;

  for (var position = preambleLength; position < input.length; position++) {
    var isSum = false;
    var target = input[position];

    for (var i = position - preambleLength; i < position; i++) {
      for (var j = i + 1; j < position; j++) {
        if (input[i] + input[j] == target) {
          isSum = true;
        }
      }
    }

    if (isSum == false) {
      return target;
    }
  }
  throw Error;
}

int day09_part2(String data) {
  var input = data.trim().split('\n').map((line) => int.parse(line)).toList();

  var target = day09_part1(data);

  for (var i = 0; i < input.length; i++) {
    for (var j = i + 2; j < input.length; j++) {
      var candidate = input.sublist(i, j);

      if (candidate.reduce((x, y) => x + y) == target) {
        return candidate.reduce((x, y) => max(x, y)) +
            candidate.reduce((x, y) => min(x, y));
      }
    }
  }
  throw Error;
}

// day 10

int day10(int part, String data) =>
    (part == 1) ? day10_part1(data) : day10_part2(data);

class Pair {
  Pair(this.first, this.second);

  final int first;
  final int second;
}

int day10_part1(String data) {
  var adapters = data.trim().split('\n').map((line) => int.parse(line)).toList()
    ..sort();

  var length = adapters.length;
  var joltageMax = adapters.reduce(max) + 3;

  var differences = [
    for (var i = 0; i < length + 1; i++)
      Pair(
        (i == 0) ? 0 : adapters[i - 1],
        (i == length) ? joltageMax : adapters[i],
      ),
  ].map((pair) => pair.second - pair.first);

  return differences.where((x) => x == 1).length *
      differences.where((x) => x == 3).length;
}

int day10_part2(String data) {
  var adapters = data.trim().split('\n').map((line) => int.parse(line)).toList()
    ..sort();

  var cache = {0: 1};

  for (var joltage in adapters) {
    cache[joltage] = (cache[joltage - 1] ?? 0) +
        (cache[joltage - 2] ?? 0) +
        (cache[joltage - 3] ?? 0);

    cache.remove(joltage - 3);
  }

  return cache[adapters.last];
}

// day 11

int day11(int part, String data) =>
    (part == 1) ? day11_part1(data) : day11_part2(data);

const String occupied = '#';
const String empty = 'L';
const String floor = '.';

class Day11Vector {
  Day11Vector({this.row, this.column});

  final int row;
  final int column;

  Day11Vector operator +(Object other) => Day11Vector(
        row: row + (other as Day11Vector).row,
        column: column + (other as Day11Vector).column,
      );
}

class Matrix {
  Matrix(List<List<String>> matrix) : _matrix = matrix;

  final List<List<String>> _matrix;

  int get _numberOfRows => _matrix.length;
  int get _numberOfColumns => _matrix[0].length;

  int numberOccupied() => _matrix
      .map((row) => row.where((value) => value == occupied).length)
      .reduce((x, y) => x + y);

  String valueAt(Day11Vector position) =>
      _matrix[position.row][position.column];

  var directions = [
    Day11Vector(row: -1, column: -1),
    Day11Vector(row: -1, column: 0),
    Day11Vector(row: -1, column: 1),
    Day11Vector(row: 0, column: -1),
    Day11Vector(row: 0, column: 1),
    Day11Vector(row: 1, column: -1),
    Day11Vector(row: 1, column: 0),
    Day11Vector(row: 1, column: 1),
  ];

  String _visibleSeat({Day11Vector position, Day11Vector direction}) {
    var newPosition = position + direction;

    if (!_positionIsValid(newPosition)) {
      return null;
    }

    var newValue = valueAt(newPosition);

    if (newValue == floor) {
      return _visibleSeat(position: newPosition, direction: direction);
    }

    return newValue;
  }

  List<String> _visibleSeats(Day11Vector position) => directions
      .map((direction) => _visibleSeat(
            position: position,
            direction: direction,
          ))
      .where((seat) => seat != null)
      .toList();

  List<String> _adjacentValues(Day11Vector position) => directions
      .map((direction) => position + direction)
      .where(_positionIsValid)
      .map(valueAt)
      .toList();

  bool _positionIsValid(Day11Vector position) =>
      position.row >= 0 &&
      position.row < _numberOfRows &&
      position.column >= 0 &&
      position.column < _numberOfColumns;

  bool _atLeastFourAdjacentOccupied(Day11Vector position) =>
      _adjacentValues(position).where((value) => (value == occupied)).length >=
      4;

  bool _adjacentAreAllEmpty(Day11Vector position) =>
      _adjacentValues(position).where((value) => (value == occupied)).isEmpty;

  bool _atLeastFiveVisibleOccupied(Day11Vector position) =>
      _visibleSeats(position).where((value) => (value == occupied)).length >= 5;

  bool _visibleAreAllEmpty(Day11Vector position) =>
      _visibleSeats(position).where((value) => (value == occupied)).isEmpty;

  String _newValueAt(Day11Vector position, int part) {
    var value = valueAt(position);
    switch (value) {
      case occupied:
        if ((part == 1 && _atLeastFourAdjacentOccupied(position)) ||
            (part == 2 && _atLeastFiveVisibleOccupied(position))) {
          value = empty;
        }
        break;
      case empty:
        if ((part == 1 && _adjacentAreAllEmpty(position)) ||
            (part == 2 && _visibleAreAllEmpty(position))) {
          value = occupied;
        }
        break;
    }
    return value;
  }

  Matrix nextMatrix({int part}) {
    List<List<String>> next = [
      for (var row = 0; row < _numberOfRows; row++)
        [
          for (var column = 0; column < _numberOfColumns; column++)
            _newValueAt(Day11Vector(row: row, column: column), part),
        ],
    ];
    return Matrix(next);
  }

  bool operator ==(Object other) => (other is Matrix)
      ? [
          for (var row = 0; row < _numberOfRows; row++)
            for (var column = 0; column < _numberOfColumns; column++)
              _matrix[row][column] ==
                  other.valueAt(Day11Vector(row: row, column: column)),
        ].reduce((x, y) => x && y)
      : false;

  String toString() => _matrix.map((row) => row.join('')).join('\n');
}

int day11_part1(String data) {
  var matrix =
      Matrix(data.trim().split('\n').map((row) => row.split('')).toList());

  while (true) {
    var newMatrix = matrix.nextMatrix(part: 1);
    if (newMatrix == matrix) break;
    matrix = newMatrix;
  }

  return matrix.numberOccupied();
}

int day11_part2(String data) {
  var matrix =
      Matrix(data.trim().split('\n').map((row) => row.split('')).toList());

  while (true) {
    var newMatrix = matrix.nextMatrix(part: 2);
    if (newMatrix == matrix) break;
    matrix = newMatrix;
  }

  return matrix.numberOccupied();
}

// day 12

class Instruction {
  Instruction({this.action, this.value});

  final String action;
  final int value;
}

class Vector {
  Vector({this.x, this.y});

  final int x;
  final int y;
  String toString() => '($x, $y)';
}

class Ship {
  Ship({this.position, this.facing});

  final Vector position;
  final Vector facing;

  String toString() => '  position: $position\n  facing: $facing';
}

Vector rotateVector({Instruction instruction, Vector vector}) {
  var action = instruction.action;
  var value = instruction.value;

  if (value == 0) {
    return vector;
  } else if (action == 'R') {
    return rotateVector(
      instruction: Instruction(
        action: 'L',
        value: 360 - value,
      ),
      vector: vector,
    );
  } else if (action == 'L') {
    return rotateVector(
      instruction: Instruction(
        action: action,
        value: value - 90,
      ),
      vector: Vector(
        x: -vector.y,
        y: vector.x,
      ),
    );
  } else {
    throw Error;
  }
  return vector;
}

Ship nextShip({Instruction instruction, Ship ship}) {
  String action = instruction.action;
  int value = instruction.value;

  Vector position = ship.position;
  Vector facing = ship.facing;

  if (action == 'F') {
    position = Vector(
      x: ship.position.x + value * ship.facing.x,
      y: ship.position.y + value * ship.facing.y,
    );
  } else if ('LR'.split('').contains(action)) {
    facing = rotateVector(
      instruction: instruction,
      vector: ship.facing,
    );
  } else if ('NSEW'.split('').contains(action)) {
    var delta;
    switch (action) {
      case 'N':
        delta = Vector(x: 0, y: 1);
        break;
      case 'S':
        delta = Vector(x: 0, y: -1);
        break;
      case 'E':
        delta = Vector(x: 1, y: 0);
        break;
      case 'W':
        delta = Vector(x: -1, y: 0);
        break;
    }

    position = Vector(
      x: ship.position.x + value * delta.x,
      y: ship.position.y + value * delta.y,
    );
  } else {
    throw Error;
  }

  return Ship(position: position, facing: facing);
}

int day12(int part, String data) =>
    (part == 1) ? day12_part1(data) : day12_part2(data);

int day12_part1(String data) {
  var instructions = data.trim().split('\n').map((line) =>
      Instruction(action: line[0], value: int.parse(line.substring(1))));

  var ship = Ship(
    position: Vector(x: 0, y: 0),
    facing: Vector(x: 1, y: 0),
  );

  instructions.forEach((instruction) {
    ship = nextShip(ship: ship, instruction: instruction);
  });

  return ship.position.x.abs() + ship.position.y.abs();
}

int day12_part2(String data) => null;

// day 13

int day13(int part, String data) =>
    (part == 1) ? day13_part1(data) : day13_part2(data);

int day13_part1(String data) => null;

int day13_part2(String data) => null;

// day 14

int day14(int part, String data) =>
    (part == 1) ? day14_part1(data) : day14_part2(data);

int day14_part1(String data) => null;

int day14_part2(String data) => null;

// day 15

int day15(int part, String data) =>
    (part == 1) ? day15_part1(data) : day15_part2(data);

int day15_part1(String data) => null;

int day15_part2(String data) => null;

// day 16

int day16(int part, String data) =>
    (part == 1) ? day16_part1(data) : day16_part2(data);

int day16_part1(String data) => null;

int day16_part2(String data) => null;

// day 17

int day17(int part, String data) =>
    (part == 1) ? day17_part1(data) : day17_part2(data);

int day17_part1(String data) => null;

int day17_part2(String data) => null;

// day 18

int day18(int part, String data) =>
    (part == 1) ? day18_part1(data) : day18_part2(data);

int day18_part1(String data) => null;

int day18_part2(String data) => null;

// day 19

int day19(int part, String data) =>
    (part == 1) ? day19_part1(data) : day19_part2(data);

int day19_part1(String data) => null;

int day19_part2(String data) => null;

// day 20

int day20(int part, String data) =>
    (part == 1) ? day20_part1(data) : day20_part2(data);

int day20_part1(String data) => null;

int day20_part2(String data) => null;

// day 21

int day21(int part, String data) =>
    (part == 1) ? day21_part1(data) : day21_part2(data);

int day21_part1(String data) => null;

int day21_part2(String data) => null;

// day 22

int day22(int part, String data) =>
    (part == 1) ? day22_part1(data) : day22_part2(data);

int day22_part1(String data) => null;

int day22_part2(String data) => null;

// day 23

int day23(int part, String data) =>
    (part == 1) ? day23_part1(data) : day23_part2(data);

int day23_part1(String data) => null;

int day23_part2(String data) => null;

// day 24

int day24(int part, String data) =>
    (part == 1) ? day24_part1(data) : day24_part2(data);

int day24_part1(String data) => null;

int day24_part2(String data) => null;

// day 25

int day25(int part, String data) =>
    (part == 1) ? day25_part1(data) : day25_part2(data);

int day25_part1(String data) => null;

int day25_part2(String data) => null;
