import 'package:test/test.dart';
import 'dart:collection';
import 'dart:math';

class Solution {
  static List<List<int>> matrix = List.generate(1002, (index) => List.generate(1002, (index) => -1));

  int valueAfterKSeconds(int n, int k) {
    if (matrix[n][k] != -1) {
      return matrix[n][k];
    }

    if (n == 0) {
      return matrix[n][k] = 0;
    }

    if (k == 0) {
      return matrix[n][k] = 1;
    }

    return matrix[n][k] = (valueAfterKSeconds(n, k - 1) + valueAfterKSeconds(n - 1, k) % (1e9 + 7).toInt());
  }
}

void main() {
  test("Testing valueAfterKSeconds", () {
    final solution = Solution();
    expect(Solution().valueAfterKSeconds(1, 1), equals(1));
    expect(Solution().valueAfterKSeconds(1, 2), equals(1));
    expect(Solution().valueAfterKSeconds(1, 3), equals(1));
    expect(Solution().valueAfterKSeconds(1, 4), equals(1));
    expect(Solution().valueAfterKSeconds(1, 5), equals(1));
    expect(Solution().valueAfterKSeconds(4, 5), equals(56));
    expect(Solution().valueAfterKSeconds(5, 3), equals(35));
    expect(Solution().valueAfterKSeconds(5, 1000), equals(84693457));
  });
}
