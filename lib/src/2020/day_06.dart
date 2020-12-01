int day06(int part, String contents) =>
    (part == 1) ? day06_part1(contents) : day06_part2(contents);

int day06_part1(String contents) => contents
    .split('\n\n')
    .map((block) => block.split('\n').join('').split('').toSet().length)
    .reduce((x, y) => x + y);

int day06_part2(String contents) => contents
    .split('\n\n')
    .map((block) => block
        .trim()
        .split('\n')
        .map((line) => line.split('').toSet())
        .reduce((x, y) => x.intersection(y))
        .length)
    .reduce((x, y) => x + y);
