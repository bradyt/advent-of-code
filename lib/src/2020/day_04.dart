int day04(int part, String contents) =>
    (part == 1) ? day04_part1(contents) : day04_part2(contents);

int day04_part1(String contents) => contents
    .replaceAll(' ', '\n')
    .replaceAll(RegExp(r'cid:[^ \n]+[ \n]?'), '')
    .split('\n\n')
    .where((block) => block.trim().split('\n').length == 7)
    .length;

int day04_part2(String contents) {
  var passports = contents.split('\n\n').map((block) => {
        for (var pair in block
            .replaceAll(' ', '\n')
            .trim()
            .split('\n')
            .map((line) => line.split(':')))
          pair[0]: pair[1]
      });
  // passports.forEach((passport) {
  //   print('-' * 80);
  //   print(passport);
  //   print(validatePassport(passport));
  // });

  var result = passports.where((passport) => validatePassport(passport)).length;
  // print(result);
  return result;
}

// bool validateYear(String input, int lowerBound, int upperBound) {
//   if (input == null) return false;
//   int n = int.parse(input);
//   return n >= lowerBound && n <= upperBound;
// }

bool validateYear(String str, int lowerBound, int upperBound) {
  var match = RegExp(r'[0-9]{4}').firstMatch(str ?? '');
  var valid;
  if (match == null) {
    valid = false;
  } else {
    int n = int.parse(match.group(0));

    valid = n >= lowerBound && n <= upperBound;
  }
  return valid;
}

bool validateHeight(String hgt) {
  var hgtMatch = RegExp(r'([0-9]+)(in|cm)').firstMatch(hgt ?? '');
  var validHgt;

  if (hgtMatch == null) {
    validHgt = false;
  } else {
    int n = int.parse(hgtMatch.group(1));

    switch (hgtMatch.group(2)) {
      case 'cm':
        validHgt = n >= 150 && n <= 193;
        break;
      case 'in':
        validHgt = n >= 59 && n <= 76;
        break;
      default:
        validHgt = false;
        break;
    }
  }

  return validHgt;
}

bool validatePassport(Map passport) {
  return ['byr', 'iyr', 'eyr', 'hgt', 'hcl', 'ecl', 'pid']
      .every((key) => validate(
            key,
            passport[key],
          ));
}

bool validate(String key, String value) {
  bool valid;
  switch (key) {
    case 'byr':
      valid = validateYear(value, 1920, 2002);
      break;
    case 'iyr':
      valid = validateYear(value, 2010, 2020);
      break;
    case 'eyr':
      valid = validateYear(value, 2020, 2030);
      break;
    case 'hgt':
      valid = validateHeight(value);
      break;
    case 'hcl':
      valid = RegExp(r'^#[0-9a-f]{6}$').hasMatch(value ?? '');
      break;
    case 'ecl':
      valid = ['amb', 'blu', 'brn', 'gry', 'grn', 'hzl', 'oth'].contains(value);
      break;
    case 'pid':
      valid = RegExp(r'^\d{9}$').hasMatch(value ?? '');
      break;
    case 'cid':
      valid = true;
      break;
    default:
      valid = false;
  }
  return valid;
}
