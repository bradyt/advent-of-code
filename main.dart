import 'dart:io';

void main() {
  day01();
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
