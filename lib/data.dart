class ExamplesAndSolution {
  ExamplesAndSolution({
    this.example,
    this.partOneExampleSolution,
    this.partOneSolution,
    this.partTwoExampleSolution,
    this.partTwoSolution,
  });

  final String example;
  final int partOneExampleSolution;
  final int partOneSolution;
  final int partTwoExampleSolution;
  final int partTwoSolution;

  int solution({bool example, int part}) {
    if (example && part == 1) {
      return partOneExampleSolution;
    } else if (!example && part == 1) {
      return partOneSolution;
    } else if (example && part == 2) {
      return partTwoExampleSolution;
    } else if (!example && part == 2) {
      return partTwoSolution;
    }
    throw Error;
  }
}

var examplesAndSolutions = {
  1: ExamplesAndSolution(
    example: '''
1721
979
366
299
675
1456''',
    partOneExampleSolution: 514579,
    partOneSolution: 381699,
    partTwoExampleSolution: 241861950,
    partTwoSolution: 111605670,
  ),
  2: ExamplesAndSolution(
    example: '''
1-3 a: abcde
1-3 b: cdefg
2-9 c: ccccccccc''',
    partOneExampleSolution: 2,
    partOneSolution: 546,
    partTwoExampleSolution: 1,
    partTwoSolution: 275,
  ),
  3: ExamplesAndSolution(
    example: '''
..##.......
#...#...#..
.#....#..#.
..#.#...#.#
.#...##..#.
..#.##.....
.#.#.#....#
.#........#
#.##...#...
#...##....#
.#..#...#.#''',
    partOneExampleSolution: 7,
    partOneSolution: 259,
    partTwoExampleSolution: 336,
    partTwoSolution: 2224913600,
  ),
  4: ExamplesAndSolution(
    example: '''
ecl:gry pid:860033327 eyr:2020 hcl:#fffffd
byr:1937 iyr:2017 cid:147 hgt:183cm

iyr:2013 ecl:amb cid:350 eyr:2023 pid:028048884
hcl:#cfa07d byr:1929

hcl:#ae17e1 iyr:2013
eyr:2024
ecl:brn pid:760753108 byr:1931
hgt:179cm

hcl:#cfa07d eyr:2025 pid:166559648
iyr:2011 ecl:brn hgt:59in''',
    partOneExampleSolution: 2,
    partOneSolution: 170,
    partTwoSolution: 103,
  ),
  5: ExamplesAndSolution(
    partOneSolution: 935,
    partTwoSolution: 743,
  ),
  6: ExamplesAndSolution(
    example: '''
abc

a
b
c

ab
ac

a
a
a
a

b''',
    partOneExampleSolution: 11,
    partOneSolution: 6683,
    partTwoExampleSolution: 6,
    partTwoSolution: 3122,
  ),
  07: ExamplesAndSolution(
    example: '''
''',
    partOneExampleSolution: null,
    partOneSolution: null,
    partTwoExampleSolution: null,
    partTwoSolution: null,
  ),
  08: ExamplesAndSolution(
    example: '''
''',
    partOneExampleSolution: null,
    partOneSolution: null,
    partTwoExampleSolution: null,
    partTwoSolution: null,
  ),
  09: ExamplesAndSolution(
    example: '''
''',
    partOneExampleSolution: null,
    partOneSolution: null,
    partTwoExampleSolution: null,
    partTwoSolution: null,
  ),
  10: ExamplesAndSolution(
    example: '''
''',
    partOneExampleSolution: null,
    partOneSolution: null,
    partTwoExampleSolution: null,
    partTwoSolution: null,
  ),
  11: ExamplesAndSolution(
    example: '''
''',
    partOneExampleSolution: null,
    partOneSolution: null,
    partTwoExampleSolution: null,
    partTwoSolution: null,
  ),
  12: ExamplesAndSolution(
    example: '''
''',
    partOneExampleSolution: null,
    partOneSolution: null,
    partTwoExampleSolution: null,
    partTwoSolution: null,
  ),
  13: ExamplesAndSolution(
    example: '''
''',
    partOneExampleSolution: null,
    partOneSolution: null,
    partTwoExampleSolution: null,
    partTwoSolution: null,
  ),
  14: ExamplesAndSolution(
    example: '''
''',
    partOneExampleSolution: null,
    partOneSolution: null,
    partTwoExampleSolution: null,
    partTwoSolution: null,
  ),
  15: ExamplesAndSolution(
    example: '''
''',
    partOneExampleSolution: null,
    partOneSolution: null,
    partTwoExampleSolution: null,
    partTwoSolution: null,
  ),
  16: ExamplesAndSolution(
    example: '''
''',
    partOneExampleSolution: null,
    partOneSolution: null,
    partTwoExampleSolution: null,
    partTwoSolution: null,
  ),
  17: ExamplesAndSolution(
    example: '''
''',
    partOneExampleSolution: null,
    partOneSolution: null,
    partTwoExampleSolution: null,
    partTwoSolution: null,
  ),
  18: ExamplesAndSolution(
    example: '''
''',
    partOneExampleSolution: null,
    partOneSolution: null,
    partTwoExampleSolution: null,
    partTwoSolution: null,
  ),
  19: ExamplesAndSolution(
    example: '''
''',
    partOneExampleSolution: null,
    partOneSolution: null,
    partTwoExampleSolution: null,
    partTwoSolution: null,
  ),
  20: ExamplesAndSolution(
    example: '''
''',
    partOneExampleSolution: null,
    partOneSolution: null,
    partTwoExampleSolution: null,
    partTwoSolution: null,
  ),
  21: ExamplesAndSolution(
    example: '''
''',
    partOneExampleSolution: null,
    partOneSolution: null,
    partTwoExampleSolution: null,
    partTwoSolution: null,
  ),
  22: ExamplesAndSolution(
    example: '''
''',
    partOneExampleSolution: null,
    partOneSolution: null,
    partTwoExampleSolution: null,
    partTwoSolution: null,
  ),
  23: ExamplesAndSolution(
    example: '''
''',
    partOneExampleSolution: null,
    partOneSolution: null,
    partTwoExampleSolution: null,
    partTwoSolution: null,
  ),
  24: ExamplesAndSolution(
    example: '''
''',
    partOneExampleSolution: null,
    partOneSolution: null,
    partTwoExampleSolution: null,
    partTwoSolution: null,
  ),
  25: ExamplesAndSolution(
    example: '''
''',
    partOneExampleSolution: null,
    partOneSolution: null,
    partTwoExampleSolution: null,
    partTwoSolution: null,
  ),
};