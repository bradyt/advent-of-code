import 'dart:math';

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
