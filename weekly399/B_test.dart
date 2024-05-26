import 'package:test/test.dart';
import 'dart:collection';

typedef Cache = HashMap<String, int>;

class CompressorCache {
  Cache cache;

  CompressorCache(this.cache);

  void flush() {
    cache.clear();
  }

  void increment(String key) {
    if (cache.containsKey(key)) {
      cache.update(key, (value) => value + 1);
    } else {
      cache[key] = 1;
    }
  }

  int fetch(String key) {
    return cache[key] ?? 0;
  }
}

class StringCompressor {
  final Cache cache;
  final String result;
  final String str;

  const StringCompressor({
    required this.cache,
    required this.result,
    required this.str,
  });

  String compress() {
    CompressorCache hash = CompressorCache(cache);
    String value = result;

    for (int i = 0; i < str.length; i++) {
      final String currentChar = str[i];
      if (hash.cache.containsKey(currentChar)) {
        if (hash.cache[currentChar] == 9) {
          value += hash.cache[currentChar].toString() + currentChar;
          hash.flush();
          hash.increment(currentChar);
        } else {
          hash.increment(currentChar);
        }
      } else {
        for (String key in hash.cache.keys) {
          value += hash.fetch(key).toString() + key;
        }
        hash.flush();
        hash.increment(currentChar);
      }
    }

    for (String key in hash.cache.keys) {
      value += hash.fetch(key).toString() + key;
    }

    return value;
  }
}

class Solution {
  String compressedString(String str) {
    HashMap<String, int> hash = HashMap<String, int>();
    StringCompressor compressor = StringCompressor(cache: hash, result: '', str: str);
    return compressor.compress();
  }
}

void main() {
  test("", () {
    expect(Solution().compressedString("abcde"), equals("1a1b1c1d1e"));
  });

  test("", () {
    expect(Solution().compressedString("aaaaaaaaaaaaaabb"), equals("9a5a2b"));
  });
}
