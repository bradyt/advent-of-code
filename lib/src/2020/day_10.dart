import 'dart:math';

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
