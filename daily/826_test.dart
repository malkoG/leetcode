import 'dart:math';

import 'package:test/test.dart';

class Assignment {
  int difficulty;
  int profit;

  Assignment(this.difficulty, this.profit);

  @override
  bool operator ==(Object o) {
    final other = o as Assignment;
    return difficulty == other.difficulty && profit == other.profit;
  }
}

class Solution {
  List<Assignment> compress(List<Assignment> assignments) {
    assignments.sort((a, b) => a.difficulty == b.difficulty ? b.profit - a.profit : a.difficulty - b.difficulty);
    List<Assignment> result = [];

    result.add(Assignment(0, 0));

    for (Assignment assignment in assignments) {
      final difficultist = result.last;
      if (difficultist.difficulty != assignment.difficulty) {
        result.add(assignment);
      } else {
        if (difficultist.profit >= assignment.profit) continue;
      }
    }

    return result;
  }

  int maxProfitAssignment(List<int> difficulties, List<int> profits, List<int> workers) {
    int sizeOfAssignments = difficulties.length;
    workers.sort();
    final assignments = [for (int i = 0; i < sizeOfAssignments; i++) Assignment(difficulties[i], profits[i])];
    final compressedAssignments = compress(assignments);

    int totalProfit = 0;

    int current = 0;
    for (int worker in workers) {
      int candidateProfit = 0;
      for (var assignment in compressedAssignments) {
        if (assignment.difficulty < worker) candidateProfit = max(candidateProfit, assignment.profit);
      }
      totalProfit += candidateProfit;
    }

    return totalProfit;
  }
}

void main() {
  final s = Solution();
  test('Testing compress', () {
    expect(s.compress([Assignment(1, 1), Assignment(4, 4), Assignment(4, 1), Assignment(4, 10)]).map((e) => e.profit),
        equals([Assignment(0, 0), Assignment(1, 1), Assignment(4, 10)].map((e) => e.profit)));
    expect(
        s
            .compress([2, 4, 6, 8, 10].map((e) => Assignment(e, e * 5)).toList())
            .map((e) => e.profit)
            .fold(0, (a, b) => a + b),
        equals([2, 4, 6, 8, 10].map((e) => Assignment(e, e * 5)).map((e) => e.profit).reduce((a, b) => a + b)));
  });

  test('Testing maxProfitAssignment', () {
    expect(s.maxProfitAssignment([85, 47, 57], [24, 66, 99], [40, 25, 25]), equals(0));
    expect(s.maxProfitAssignment([2, 4, 6, 8, 10], [10, 20, 30, 40, 50], [4, 5, 6, 7]), equals(100));
  });
}
