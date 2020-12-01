import 'dart:math';

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
