import 'dart:io';

void main() {
  File file = File('day-01.txt');
  var entries =
      file.readAsStringSync().trim().split('\n').map((str) => int.parse(str));
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
