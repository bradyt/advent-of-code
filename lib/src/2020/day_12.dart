class Instruction {
  Instruction({this.action, this.value});

  final String action;
  final int value;
}

class Vector {
  Vector({this.x, this.y});

  final int x;
  final int y;
  String toString() => '($x, $y)';
}

class Ship {
  Ship({this.position, this.facing});

  final Vector position;
  final Vector facing;

  String toString() => '  position: $position\n  facing: $facing';
}

Vector rotateVector({Instruction instruction, Vector vector}) {
  var action = instruction.action;
  var value = instruction.value;

  if (value == 0) {
    return vector;
  } else if (action == 'R') {
    return rotateVector(
      instruction: Instruction(
        action: 'L',
        value: 360 - value,
      ),
      vector: vector,
    );
  } else if (action == 'L') {
    return rotateVector(
      instruction: Instruction(
        action: action,
        value: value - 90,
      ),
      vector: Vector(
        x: -vector.y,
        y: vector.x,
      ),
    );
  } else {
    throw Error;
  }
  return vector;
}

Ship nextShip({Instruction instruction, Ship ship}) {
  String action = instruction.action;
  int value = instruction.value;

  Vector position = ship.position;
  Vector facing = ship.facing;

  if (action == 'F') {
    position = Vector(
      x: ship.position.x + value * ship.facing.x,
      y: ship.position.y + value * ship.facing.y,
    );
  } else if ('LR'.split('').contains(action)) {
    facing = rotateVector(
      instruction: instruction,
      vector: ship.facing,
    );
  } else if ('NSEW'.split('').contains(action)) {
    var delta;
    switch (action) {
      case 'N':
        delta = Vector(x: 0, y: 1);
        break;
      case 'S':
        delta = Vector(x: 0, y: -1);
        break;
      case 'E':
        delta = Vector(x: 1, y: 0);
        break;
      case 'W':
        delta = Vector(x: -1, y: 0);
        break;
    }

    position = Vector(
      x: ship.position.x + value * delta.x,
      y: ship.position.y + value * delta.y,
    );
  } else {
    throw Error;
  }

  return Ship(position: position, facing: facing);
}

int day12(int part, String data) =>
    (part == 1) ? day12_part1(data) : day12_part2(data);

int day12_part1(String data) {
  var instructions = data.trim().split('\n').map((line) =>
      Instruction(action: line[0], value: int.parse(line.substring(1))));

  var ship = Ship(
    position: Vector(x: 0, y: 0),
    facing: Vector(x: 1, y: 0),
  );

  instructions.forEach((instruction) {
    ship = nextShip(ship: ship, instruction: instruction);
  });

  return ship.position.x.abs() + ship.position.y.abs();
}

int day12_part2(String data) => null;
