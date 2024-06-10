import 'dart:math';

import 'package:test/test.dart';
import 'dart:collection';

class Solution {
  List<bool> candidates = List<bool>.generate(101010, (index) => false);

  int maxTotalReward(List<int> rewardValues) {
    SplayTreeSet<int> sortedRewardValues = SplayTreeSet<int>.from(rewardValues);

    for (int rewardValue in rewardValues) {
      candidates[rewardValue] = true;
      for (int i = 0; i < rewardValue; i++) {
        if (candidates[i] && i < rewardValue) {
          candidates[i + rewardValue] = true;
        }
      }
    }

    int answer = 0;
    for (int i = 0; i < 101010; i++) {
      if (candidates[i]) {
        answer = max(answer, i);
      }
    }

    return answer;
  }
}

void main() {
  test("Testing maxTotalReward", () {
    expect(Solution().maxTotalReward([1, 1, 3, 3]), equals(4));
    expect(Solution().maxTotalReward([1, 6, 4, 3, 2]), equals(11));
    expect(Solution().maxTotalReward([1, 5, 4]), equals(9));
    expect(Solution().maxTotalReward([3, 4, 17, 11]), equals(32));
    expect(Solution().maxTotalReward([19, 1, 14, 13]), equals(34));
    expect(Solution().maxTotalReward([5, 8, 9, 12]), equals(21));
  });
}
