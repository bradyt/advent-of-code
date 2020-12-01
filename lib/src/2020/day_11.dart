int day11(int part, String data) =>
    (part == 1) ? day11_part1(data) : day11_part2(data);

const String occupied = '#';
const String empty = 'L';
const String floor = '.';

class Day11Vector {
  Day11Vector({this.row, this.column});

  final int row;
  final int column;

  Day11Vector operator +(Object other) => Day11Vector(
        row: row + (other as Day11Vector).row,
        column: column + (other as Day11Vector).column,
      );
}

class Matrix {
  Matrix(List<List<String>> matrix) : _matrix = matrix;

  final List<List<String>> _matrix;

  int get _numberOfRows => _matrix.length;
  int get _numberOfColumns => _matrix[0].length;

  int numberOccupied() => _matrix
      .map((row) => row.where((value) => value == occupied).length)
      .reduce((x, y) => x + y);

  String valueAt(Day11Vector position) =>
      _matrix[position.row][position.column];

  var directions = [
    Day11Vector(row: -1, column: -1),
    Day11Vector(row: -1, column: 0),
    Day11Vector(row: -1, column: 1),
    Day11Vector(row: 0, column: -1),
    Day11Vector(row: 0, column: 1),
    Day11Vector(row: 1, column: -1),
    Day11Vector(row: 1, column: 0),
    Day11Vector(row: 1, column: 1),
  ];

  String _visibleSeat({Day11Vector position, Day11Vector direction}) {
    var newPosition = position + direction;

    if (!_positionIsValid(newPosition)) {
      return null;
    }

    var newValue = valueAt(newPosition);

    if (newValue == floor) {
      return _visibleSeat(position: newPosition, direction: direction);
    }

    return newValue;
  }

  List<String> _visibleSeats(Day11Vector position) => directions
      .map((direction) => _visibleSeat(
            position: position,
            direction: direction,
          ))
      .where((seat) => seat != null)
      .toList();

  List<String> _adjacentValues(Day11Vector position) => directions
      .map((direction) => position + direction)
      .where(_positionIsValid)
      .map(valueAt)
      .toList();

  bool _positionIsValid(Day11Vector position) =>
      position.row >= 0 &&
      position.row < _numberOfRows &&
      position.column >= 0 &&
      position.column < _numberOfColumns;

  bool _atLeastFourAdjacentOccupied(Day11Vector position) =>
      _adjacentValues(position).where((value) => (value == occupied)).length >=
      4;

  bool _adjacentAreAllEmpty(Day11Vector position) =>
      _adjacentValues(position).where((value) => (value == occupied)).isEmpty;

  bool _atLeastFiveVisibleOccupied(Day11Vector position) =>
      _visibleSeats(position).where((value) => (value == occupied)).length >= 5;

  bool _visibleAreAllEmpty(Day11Vector position) =>
      _visibleSeats(position).where((value) => (value == occupied)).isEmpty;

  String _newValueAt(Day11Vector position, int part) {
    var value = valueAt(position);
    switch (value) {
      case occupied:
        if ((part == 1 && _atLeastFourAdjacentOccupied(position)) ||
            (part == 2 && _atLeastFiveVisibleOccupied(position))) {
          value = empty;
        }
        break;
      case empty:
        if ((part == 1 && _adjacentAreAllEmpty(position)) ||
            (part == 2 && _visibleAreAllEmpty(position))) {
          value = occupied;
        }
        break;
    }
    return value;
  }

  Matrix nextMatrix({int part}) {
    List<List<String>> next = [
      for (var row = 0; row < _numberOfRows; row++)
        [
          for (var column = 0; column < _numberOfColumns; column++)
            _newValueAt(Day11Vector(row: row, column: column), part),
        ],
    ];
    return Matrix(next);
  }

  bool operator ==(Object other) => (other is Matrix)
      ? [
          for (var row = 0; row < _numberOfRows; row++)
            for (var column = 0; column < _numberOfColumns; column++)
              _matrix[row][column] ==
                  other.valueAt(Day11Vector(row: row, column: column)),
        ].reduce((x, y) => x && y)
      : false;

  String toString() => _matrix.map((row) => row.join('')).join('\n');
}

int day11_part1(String data) {
  var matrix =
      Matrix(data.trim().split('\n').map((row) => row.split('')).toList());

  while (true) {
    var newMatrix = matrix.nextMatrix(part: 1);
    if (newMatrix == matrix) break;
    matrix = newMatrix;
  }

  return matrix.numberOccupied();
}

int day11_part2(String data) {
  var matrix =
      Matrix(data.trim().split('\n').map((row) => row.split('')).toList());

  while (true) {
    var newMatrix = matrix.nextMatrix(part: 2);
    if (newMatrix == matrix) break;
    matrix = newMatrix;
  }

  return matrix.numberOccupied();
}
