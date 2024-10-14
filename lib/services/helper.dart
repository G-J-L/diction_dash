bool containsNumbers(String input) {
  // Regular expression to check for any digit in the string
  RegExp regex = RegExp(r'\d');
  return regex.hasMatch(input);
}