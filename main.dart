import 'dart:io';

void main() {
  day01_part2();
}

String getFileContents(String file) => File(file).readAsStringSync();

void day01() {
  var entries = getFileContents('day-01.txt')
      .trim()
      .split('\n')
      .map((str) => int.parse(str));
  for (var i = 0; i < entries.length; i++) {
    var entry_i = entries.elementAt(i);
    for (var j = i + 1; j < entries.length; j++) {
      var entry_j = entries.elementAt(j);
      if (entry_i + entry_j == 2020) {
        print(entry_i * entry_j);
        exit(0);
      }
    }
  }
}

void day01_part2() {
  var entries = getFileContents('day-01.txt')
      .trim()
      .split('\n')
      .map((str) => int.parse(str));
  for (var i = 0; i < entries.length; i++) {
    var entry_i = entries.elementAt(i);
    for (var j = i + 1; j < entries.length; j++) {
      var entry_j = entries.elementAt(j);
      for (var k = i + 1; k < entries.length; k++) {
        var entry_k = entries.elementAt(k);
        if (entry_i + entry_j + entry_k == 2020) {
          print(entry_i * entry_j * entry_k);
          exit(0);
        }
      }
    }
  }
}

void day02() {
  var lines = getFileContents('day-02.txt').trim().split('\n');
  // var lines = '1-3 a: abcde\n'
  //         '1-3 b: cdefg\n'
  //         '2-9 c: ccccccccc'
  //     .split('\n');
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
  print(validPasswordCount);
}
