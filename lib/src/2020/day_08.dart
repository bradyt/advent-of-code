int day08(int part, String data) =>
    (part == 1) ? day08_part1(data) : day08_part2(data);

class Day08Instruction {
  Day08Instruction({this.operation, this.argument});

  final String operation;
  final int argument;
}

List<Day08Instruction> day08_parser(String data) => data
    .trim()
    .split('\n')
    .map((line) => Day08Instruction(
          operation: line.split(' ')[0],
          argument: int.parse(line.split(' ')[1]),
        ))
    .toList();

class Delta {
  Delta({this.position, this.accumulator});

  final position;
  final accumulator;

  factory Delta.fromInstruction(Day08Instruction instruction) {
    var delta_position = 1;
    var delta_accumulator = 0;

    switch (instruction.operation) {
      case 'acc':
        delta_accumulator = instruction.argument;
        break;
      case 'jmp':
        delta_position = instruction.argument;
        break;
      case 'nop':
        break;
    }

    return Delta(
      position: delta_position,
      accumulator: delta_accumulator,
    );
  }
}

int calculateAccumulator({List instructions, bool mustTerminate}) {
  var accumulator = 0;
  var position = 0;

  var allowedPositions = {
    ...List.generate(instructions.length, (i) => i),
  };

  while (allowedPositions.contains(position)) {
    allowedPositions.remove(position);

    var delta = Delta.fromInstruction(instructions[position]);

    accumulator += delta.accumulator;
    position += delta.position;
  }

  if (mustTerminate && position != instructions.length) {
    return null;
  }
  return accumulator;
}

int day08_part1(String data) => calculateAccumulator(
      instructions: day08_parser(data),
      mustTerminate: false,
    );

int day08_part2(String data) {
  var instructions = day08_parser(data);

  List flipAtElement(int index, List instructions) {
    var flippedInstruction = Day08Instruction(
      operation: {
        'jmp': 'nop',
        'nop': 'jmp',
        'acc': 'acc',
      }[instructions[index].operation],
      argument: instructions[index].argument,
    );
    instructions[index] = flippedInstruction;
    return instructions;
  }

  var accumulator;

  for (var i = 0; i < instructions.length; i++) {
    accumulator = calculateAccumulator(
      instructions: flipAtElement(i, List.from(instructions)),
      mustTerminate: true,
    );
    if (accumulator != null) break;
  }

  return accumulator;
}
