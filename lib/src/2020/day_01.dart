import 'dart:math';

import 'package:trotter/trotter.dart';

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
