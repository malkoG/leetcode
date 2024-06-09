import 'package:test/test.dart';
import 'dart:collection';
import 'dart:math';

class Solution {
  bool withinOddPeriod(int n, int k) {
    return k ~/ (n - 1) % 2 != 0;
  }

  int numberOfChild(int n, int k) {
    final periodLength = n - 1;
    final relativePosition = k % periodLength;
    if (withinOddPeriod(n, k)) {
      return periodLength - relativePosition;
    } else {
      return relativePosition;
    }
  }
}

void main() {
  test("Testing withinOddPeriod", () {
    expect(Solution().withinOddPeriod(3, 1), equals(false));
    expect(Solution().withinOddPeriod(3, 1), equals(false));
    expect(Solution().withinOddPeriod(3, 3), equals(true));
    expect(Solution().withinOddPeriod(3, 5), equals(false));
    expect(Solution().withinOddPeriod(5, 6), equals(true));
    expect(Solution().withinOddPeriod(4, 2), equals(false));
  });

  test("Testing numberOfChild", () {
    expect(Solution().numberOfChild(3, 1), equals(1));
    expect(Solution().numberOfChild(3, 2), equals(2));
    expect(Solution().numberOfChild(3, 3), equals(1));
    expect(Solution().numberOfChild(3, 5), equals(1));
    expect(Solution().numberOfChild(5, 6), equals(2));
    expect(Solution().numberOfChild(4, 2), equals(2));
  });
}
