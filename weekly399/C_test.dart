import 'package:test/test.dart';
import 'dart:collection';
import 'dart:math';

class PairCounter {
  List<int> nums1;
  List<int> nums2;

  PairCounter(this.nums1, this.nums2);

  List<int> divisibleBy(int k) {
    return nums1.where((num1) => num1 % k == 0).toList();
  }

  List<int> factors(int n) {
    List<int> factors = [];
    int sqrtN = sqrt(n).toInt();
    for (int i = 1; i <= sqrtN; i++) {
      if (n % i == 0) {
        factors.add(i);
        if (i != n ~/ i) {
          factors.add(n ~/ i);
        }
      }
    }

    return factors;
  }

  int count(int k) {
    List<int> filteredList = divisibleBy(k);
    filteredList.sort();

    HashMap<int, int> hash = HashMap<int, int>();
    filteredList.forEach((element) {
      int candidate = (element / k).toInt();
      factors(candidate).forEach((factor) {
        hash[factor] = hash.containsKey(factor) ? hash[factor]! + 1 : 1;
      });
    });

    int count = 0;
    nums2.forEach((element) {
      if (hash.containsKey(element)) {
        count += hash[element]!;
      }
    });

    return count;
  }
}

class Solution {
  int numberOfPairs(List<int> nums1, List<int> nums2, int k) {
    return PairCounter(nums1, nums2).count(k);
  }
}

void main() {
  test("", () {
    expect(Solution().numberOfPairs([1, 3, 4], [1, 3, 4], 1), equals(5));
  });

  test("", () {
    expect(Solution().numberOfPairs([1, 2, 4, 12], [2, 4], 3), equals(2));
  });
}
