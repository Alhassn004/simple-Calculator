import 'dart:io';

//for any input from user
String readInput(String message) {
  stdout.write(message);
  return stdin.readLineSync()!.trim();
}

// the logical calculations
double? calculate(double a, double b, String op) {
  switch (op) {
    case '+':
      return a + b;
    case '-':
      return a - b;
    case '*':
      return a * b;
    case '/':
      if (b == 0) return null; 
      return a / b;
    default:
      return null; 
  }
}

// Displays the output
void displayResult(double? result, String op) {
  if (result == null) {
    if (op == '/') {
      print("Error: Cannot divide by zero.");
    } else {
      print("Invalid operation.");
    }
  } else {
    print("Result: $result");
  }
}

void main() {
  print("Simple Calculator\n");

  String op = readInput("Enter operation {+, -, *, /}: ");
  double num1 = double.parse(readInput("Enter first number: "));
  double num2 = double.parse(readInput("Enter second number: "));

  double? result = calculate(num1, num2, op);
  displayResult(result, op);
}
