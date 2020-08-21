part of 'algo.dart';

String _toTitleCase(final String text) {
  if (text == null) {
    return "";
  }
  var words = text.toLowerCase().split(" ");
  words = words.map((word) {
    if (word.isEmpty) {
      return "";
    }
    return word[0].toUpperCase() + word.substring(1);
  }).toList();
  return words.join(" ");
}

String _firstLetterCapital(final String text) {
  if (text == null) {
    return "";
  }
  final t = text.toLowerCase();
  return t[0].toUpperCase() + t.substring(1);
}
