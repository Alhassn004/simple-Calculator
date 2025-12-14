import 'dart:io';

abstract class operationStratey {
  double execute(double a, double b);
  String get operation;
}

class Addition implements operationStratey {
  @override
  double execute(double a, double b) => a + b;
  @override
  String get operation => '+';
}

class Subtraction implements operationStratey {
  @override
  double execute(double a, double b) => a - b;
  @override
  String get operation => '-';
}

class Multiplication implements operationStratey {
  @override
  double execute(double a, double b) => a * b;
  @override
  String get operation => '*';
}

class Division implements operationStratey {
  @override
  double execute(double a, double b) {
    if (b == 0) {
      throw ArgumentError(
        "Cannot divide by zero: Division by zero is not allowed.",
      );
    }
    return a / b;
  }

  @override
  String get operation => '/';
}

class CalculatorEngine {
  final Map<String, operationStratey> availableOperations = {
    Addition().operation: Addition(),
    Subtraction().operation: Subtraction(),
    Multiplication().operation: Multiplication(),
    Division().operation: Division(),
  };

  double calculate(double a, double b, String opSymbol) {
    operationStratey? strategy = availableOperations[opSymbol];

    if (strategy == null) {
      throw ArgumentError("Invalid operation symbol: $opSymbol");
    }

    return strategy.execute(a, b);
  }
}

class ReadInput {
  //read any input from user
  String readInput(String prompt) {
    stdout.write(prompt);
    return stdin.readLineSync()!.trim();
  }

  //read input from user and convert to double
  double readNumberInput(String prompt) {
    String input = readInput(prompt);
    double? number = double.tryParse(input);

    if (number == null) {
      throw FormatException(
        "Invalid number format: '$input'. Please enter a valid number.",
      );
    }
    return number;
  }
}

void main() {
  final CalculatorEngine _engine = CalculatorEngine();
  final ReadInput _input = ReadInput();

  print("Strategy Pattern Calculator\n");

  try {
    String op = _input.readInput("Enter operation {+, -, *, /}: ");

    double num1 = _input.readNumberInput("Enter first number: ");

    double num2 = _input.readNumberInput("Enter second number: ");

    double result = _engine.calculate(num1, num2, op);

    print("\nResult: $result");
  } on FormatException catch (e) {
    print("Input Error: ${e.message}");
  } on ArgumentError catch (e) {
    print("Calculation Error: ${e.message}");
  } catch (e) {
    print("An unexpected error occurred: $e");
  }
}
