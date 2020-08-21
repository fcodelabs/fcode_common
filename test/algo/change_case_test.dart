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

    test("Test Sentence Capital", () {
      final text = "my name is R.P. Rathnayake. i work in Fcode Labs.I "
          "like coding.";
      final actual = Algo.toSentenceCapital(text);
      final matcher = 'My name is R. P. Rathnayake. I work in Fcode Labs. I '
          'like coding.';
      expect(actual, matcher);
    });
  });
}
