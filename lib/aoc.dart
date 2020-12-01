import 'dart:io';

String getFileContents(String file) => File(file).readAsStringSync();

int solution({int day, int part, String data}) {
  switch (day) {
    case 1:
      return (part == 1) ? day01(data) : day01_part2(data);
    case 2:
      return (part == 1) ? day02(data) : day02_part2(data);
    case 3:
      return (part == 1) ? day03(data) : day03_part2(data);
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
