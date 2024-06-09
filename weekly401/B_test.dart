import 'package:test/test.dart';
import 'dart:collection';
import 'dart:math';

class Solution {
  static List<List<int>> matrix = List.generate(1002, (index) => List.generate(1002, (index) => -1));

  int solve(int n, int k) {
    if (matrix[n][k] != -1) return matrix[n][k];

    if (n == 0) return matrix[n][k] = 1;
    if (k == 0) return matrix[n][k] = 1;

    return matrix[n][k] = (solve(n, k - 1) + solve(n - 1, k) % (1e9 + 7).toInt());
  }

  void bootstrap() {
    for (int i = 1; i <= 1000; i++) {
      matrix[i][0] = 1;
    }

    for (int i = 1; i <= 1000; i++) {
      matrix[0][i] = 1;
    }

    for (int i = 1; i <= 1000; i++) {
      for (int k = 0; k <= 1000; k++) {
        matrix[i][k + 1] = (matrix[i][k] + matrix[i - 1][k + 1]) % (1e9 + 7).toInt();
      }
    }
  }

  int valueAfterKSeconds(int n, int k) {
    if (matrix[1][1] == -1) {
      bootstrap();
    }

    return matrix[n - 1][k];
  }
}

void main() {
  test("Testing valueAfterKSeconds", () {
    final solution = Solution();
    expect(Solution().valueAfterKSeconds(1, 1), equals(1));
    expect(Solution().valueAfterKSeconds(2, 1), equals(2));
    expect(Solution().valueAfterKSeconds(3, 1), equals(3));
    expect(Solution().valueAfterKSeconds(4, 1), equals(4));
    expect(Solution().valueAfterKSeconds(5, 1), equals(5));
    expect(Solution().valueAfterKSeconds(1, 1), equals(1));
    expect(Solution().valueAfterKSeconds(1, 2), equals(1));
    expect(Solution().valueAfterKSeconds(1, 3), equals(1));
    expect(Solution().valueAfterKSeconds(1, 4), equals(1));
    expect(Solution().valueAfterKSeconds(1, 5), equals(1));
    expect(Solution().valueAfterKSeconds(4, 5), equals(56));
    expect(Solution().valueAfterKSeconds(5, 3), equals(35));
    expect(Solution().valueAfterKSeconds(5, 1000), equals(84793457));
  });
}
