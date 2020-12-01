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
