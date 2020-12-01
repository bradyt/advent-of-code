int day07(int part, String data) =>
    (part == 1) ? day07_part1(data) : day07_part2(data);

Map day07_parser(data) {
  var map = {};

  data.trim().split('\n').forEach((line) {
    var match = RegExp(r'^(\w+ \w+) bags contain (.+)\.$').firstMatch(line);
    var bag = match.group(1);
    var requiredContents = match.group(2).split(', ');
    map[bag] = {};
    if (requiredContents[0] != 'no other bags') {
      var bagExp = RegExp(r'(\d+) (.+) bags?');
      var bagMatch;
      requiredContents.forEach((bags) {
        bagMatch = bagExp.firstMatch(bags);
        map[bag][bagMatch.group(2)] = int.parse(bagMatch.group(1));
      });
    }
  });

  return map;
}

Map day07_partOneGraphFlip(Map graph) {
  var result = {};

  for (var key in graph.keys) {
    result[key] = <String>{};
  }

  for (var entry in graph.entries) {
    for (var key in entry.value.keys) {
      result[key].add(entry.key);
    }
  }

  return result;
}

int day07_part1(String data) {
  var parsedData = day07_parser(data);
  var invertedTree = day07_partOneGraphFlip(parsedData);

  var visitedBags = <String>{};
  var currentDepth = {'shiny gold'};

  while (currentDepth.isNotEmpty) {
    currentDepth = currentDepth
        .map((bag) => invertedTree[bag])
        .reduce((x, y) => x.union(y))
          ..removeAll(visitedBags);
    visitedBags.addAll(currentDepth);
  }

  return visitedBags.length;
}

class Day07HowManyBags {
  Day07HowManyBags({Map rules})
      : _rules = rules,
        _cache = {};

  final Map _rules;
  final Map _cache;

  int howManyBags(String bag) {
    if (_cache.containsKey(bag)) {
      return _cache[bag];
    }
    _cache[bag] = _rules[bag]
        .entries
        .map((entry) => entry.value * (1 + howManyBags(entry.key)))
        .fold(0, (prev, element) => prev + element);
    return _cache[bag];
  }
}

int day07_part2(String data) {
  var parsedData = day07_parser(data);
  var howManyBags = Day07HowManyBags(rules: parsedData);
  return howManyBags.howManyBags('shiny gold');
}
