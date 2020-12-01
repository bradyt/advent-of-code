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
};
