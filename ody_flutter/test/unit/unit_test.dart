import "package:flutter_test/flutter_test.dart";

void main() {
  group("sample", () {
    test("one plus two is three", () {
      const int one = 1;
      const int two = 2;
      expect(one + two, 3);
    });
  });
}
