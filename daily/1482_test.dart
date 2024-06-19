import 'dart:math';

import 'package:test/test.dart';

class Solution {
  int makeBouquet(List<bool> isBloomed, int k) {
    int currentBloomed = 0;
    int bouquets = 0;
    for (int i = 0; i < isBloomed.length; i++) {
      if (isBloomed[i]) {
        currentBloomed += 1;
      } else {
        currentBloomed = 0;
      }
      if (currentBloomed == k) {
        currentBloomed = 0;
        bouquets += 1;
      }
    }

    return bouquets;
  }

  int minDays(List<int> bloomDays, int m, int k) {
    int lo = 0;
    int hi = 1000000000;
    int mid = (lo + hi) ~/ 2;

    int bouquets = 0;
    while (lo < hi) {
      bouquets = makeBouquet(bloomDays.map((e) => e <= mid).toList(), k);
      if (lo == hi) break;
      if (bouquets >= m) {
        hi = mid;
        mid = (lo + hi) ~/ 2;
      } else {
        lo = mid + 1;
        mid = (lo + hi + 1) ~/ 2;
      }
    }

    bouquets = makeBouquet(bloomDays.map((e) => e <= hi).toList(), k);

    return bouquets < m ? -1 : lo;
  }
}

void main() {
  final s = Solution();
  test('Testing makeBouquet', () {
    expect(s.makeBouquet([true, true, true], 1), equals(3));
    expect(s.makeBouquet([true, true, true], 2), equals(1));
    expect(s.makeBouquet([true, true, true, true], 2), equals(2));
    expect(s.makeBouquet([true, true, false, true, true, false, true, true], 2), equals(3));
    expect(s.makeBouquet([true, false, true, true, true, true, true, true, true, true], 2), equals(4));
  });

  test('Testing minDays', () {
    expect(s.minDays([1, 10, 3, 10, 2], 3, 1), 3);
    expect(s.minDays([1, 10, 3, 10, 2], 3, 2), -1);
    expect(s.minDays([7, 7, 7, 7, 12, 7, 7], 2, 3), 12);

    expect(s.minDays([1, 10, 2, 9, 3, 8, 4, 7, 5, 6], 4, 2), 9);
  });
}
