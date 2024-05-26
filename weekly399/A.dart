class NumberOfPairs {
  bool divisible(int num1, int num2, int k) {
    return num1 % (num2 * k) == 0;
  }

  int numberOfPairs(List<int> nums1, List<int> nums2, int k) {
    int count = 0;
    for (int i = 0; i < nums1.length; i++) {
      for (int j = 0; j < nums2.length; j++) {
        if (divisible(nums1[i], nums2[j], k)) {
          count++;
        }
      }
    }

    return count;
  }
}
