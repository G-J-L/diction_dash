import 'dart:math';

bool containsNumbers(String input) {
  // Regular expression to check for any digit in the string
  RegExp regex = RegExp(r'\d');
  return regex.hasMatch(input);
}

List<int> getRandomNumbers({int? max, int? count}) {
  final Random random = Random();
  final numbers = <int>{};
  while (numbers.length < 10) {
    numbers.add(random.nextInt(max!));
  }
  return numbers.toList();
}