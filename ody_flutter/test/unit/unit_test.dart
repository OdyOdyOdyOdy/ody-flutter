import 'package:flutter_test/flutter_test.dart';

void main() {
  group('sample', () {
    test('one plus two is three', () {
      const one = 1;
      const two = 2;
      expect(one + two, 3);
    });
  });
}
