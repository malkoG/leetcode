import 'dart:io';

void main() {
  String line = stdin.readLineSync()!;
  List<String> phrases = line.split(" ");
  print(phrases.where((e) => e == "5").length == 2 ? "YES" : "NO");
}
