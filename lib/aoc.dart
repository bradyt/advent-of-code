import 'dart:io';
import 'dart:math';

String getFileContents(String file) => File(file).readAsStringSync();

int solution({int day, int part, String data}) {
  switch (day) {
    case 1:
      return (part == 1) ? day01(data) : day01_part2(data);
    case 2:
      return (part == 1) ? day02(data) : day02_part2(data);
    case 3:
      return (part == 1) ? day03(data) : day03_part2(data);
    case 4:
      return (part == 1) ? day04(data) : day04_part2(data);
    case 5:
      return (part == 1) ? day05(data) : day05_part2(data);
  }
}

int day01(String contents) {
  var entries = contents.trim().split('\n').map((str) => int.parse(str));
  for (var i = 0; i < entries.length; i++) {
    var entry_i = entries.elementAt(i);
    for (var j = i + 1; j < entries.length; j++) {
      var entry_j = entries.elementAt(j);
      if (entry_i + entry_j == 2020) {
        return entry_i * entry_j;
      }
    }
  }
}

int day01_part2(String data) {
  var entries = data.trim().split('\n').map((str) => int.parse(str));
  for (var i = 0; i < entries.length; i++) {
    var entry_i = entries.elementAt(i);
    for (var j = i + 1; j < entries.length; j++) {
      var entry_j = entries.elementAt(j);
      for (var k = i + 1; k < entries.length; k++) {
        var entry_k = entries.elementAt(k);
        if (entry_i + entry_j + entry_k == 2020) {
          return entry_i * entry_j * entry_k;
        }
      }
    }
  }
}

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

int day05_convert(String boardingPass) =>
    boardingPass
        .split('')
        .map((letter) => {'B': 1, 'F': 0, 'R': 1, 'L': 0}[letter])
        .fold(0, (prev, element) => (prev + element) * 2) ~/
    2;

int day05(String contents) =>
    contents.trim().split('\n').map(day05_convert).reduce((x, y) => max(x, y));

int day05_part2(String contents) {
  var sortedBoardingPasses =
      contents.trim().split('\n').map(day05_convert).toList()..sort();
  var lastBoardingPass = sortedBoardingPasses[0] - 3;
  var result;
  for (var boardingPass in sortedBoardingPasses) {
    if (boardingPass == lastBoardingPass + 2) {
      return boardingPass - 1;
    }
    lastBoardingPass = boardingPass;
  }
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
