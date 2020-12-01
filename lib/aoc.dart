import 'dart:io';

String getFileContents(String file) => File(file).readAsStringSync();

int solution({int day, int part, String data}) {
  switch (day) {
    case 1:
      return (part == 1) ? day01(data) : day01_part2(data);
    case 2:
      return (part == 1) ? day02(data) : day02_part2(data);
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
