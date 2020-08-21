import 'package:fcode_common/fcode_common.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Test Change Case", () {
    test("Test Title Case", () {
      final text = 'my nAme IS Ramesh';
      final actual = Algo.toTitleCase(text);
      final matcher = 'My Name Is Ramesh';
      expect(actual, matcher);
    });

    test("Test First Letter Capital", () {
      final text = "fcode bloc";
      final actual = Algo.toFirstLetterCapital(text);
      final matcher = 'Fcode bloc';
      expect(actual, matcher);
    });
  });
}
