import 'dart:math';

import 'package:test/test.dart';
import 'dart:collection';

class Solution {
  int maxTotalReward(List<int> rewardValues) {
    List<int> sortedRewardValues = rewardValues;
    sortedRewardValues.sort((a, b) => a - b);

    List<SplayTreeSet<int>> maximumRewardValueCandidates = [SplayTreeSet<int>(), SplayTreeSet<int>()];

    maximumRewardValueCandidates[0].add(0);
    maximumRewardValueCandidates[1].add(0);
    int i = 0;
    for (int rewardValue in sortedRewardValues) {
      int sourceIndex = i % 2;
      int targetIndex = (i + 1) % 2;
      maximumRewardValueCandidates[targetIndex].add(rewardValue);
      var source = maximumRewardValueCandidates[sourceIndex];
      var iterable = source.takeWhile((candidate) => candidate < rewardValue);
      for (int candidate in source) {
        maximumRewardValueCandidates[targetIndex].add(candidate);
      }
      for (int candidate in iterable) {
        maximumRewardValueCandidates[targetIndex].add(rewardValue + candidate);
      }
      maximumRewardValueCandidates[targetIndex].add(rewardValue);

      i += 1;
    }
    return max(maximumRewardValueCandidates[0].reduce(max), maximumRewardValueCandidates[1].reduce(max));
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
