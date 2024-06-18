import 'dart:io';

void main() {
  String line = stdin.readLineSync()!;
  List<String> tokens = line.split(" ");
  int N = int.parse(tokens[0]);
  final strings = [for (int i = 0; i < int.parse(N.toString()); ++i) stdin.readLineSync()!].toList();

  strings.sort();

  print(strings.join());
}
