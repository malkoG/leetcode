import 'package:test/test.dart';
import 'dart:collection';
import 'dart:math';

class Solution {
  int maxTotalReward(List<int> rewardValues) {
    List<int> sortedRewardValues = List.from(rewardValues)..sort((a, b) => a - b);
    List<int> accumulatedLisSum = List.generate(rewardValues.length, (index) => 0);
    List<int> accumulatedRewardCandidates = List.generate(rewardValues.length, (index) => 0);

    for (int i = 0; i < rewardValues.length; i++) {
      accumulatedLisSum[i] = rewardValues[i];
      accumulatedRewardCandidates[i] = sortedRewardValues[i];

      for (int k = 0; k < i; k++) {
        if (rewardValues[i] > rewardValues[k]) {
          accumulatedLisSum[i] = max(accumulatedLisSum[i], accumulatedLisSum[k] + rewardValues[i]);
        }
      }

      for (int k = 0; k < i; k++) {
        int candidate = accumulatedRewardCandidates[k];
        if (candidate < sortedRewardValues[i]) {
          accumulatedRewardCandidates[i] = max(sortedRewardValues[i], candidate + sortedRewardValues[i]);
        }

        if (accumulatedLisSum[k] < sortedRewardValues[i]) {
          accumulatedRewardCandidates[i] =
              max(accumulatedRewardCandidates[i], accumulatedLisSum[k] + sortedRewardValues[i]);
        }

        if (sortedRewardValues[k] < sortedRewardValues[i]) {
          accumulatedRewardCandidates[i] =
              max(accumulatedRewardCandidates[i], sortedRewardValues[k] + sortedRewardValues[i]);
        }
      }
    }

    int answer = 0;
    for (int i = 0; i < accumulatedRewardCandidates.length; i++) {
      answer = max(answer, accumulatedRewardCandidates[i]);
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
  });
}
