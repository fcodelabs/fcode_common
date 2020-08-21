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
  }).toList(growable: false);
  return words.join(" ");
}

String _firstLetterCapital(final String text) {
  if (text == null) {
    return "";
  }
  return text[0].toUpperCase() + text.substring(1);
}

String _sentenceCapital(final String text) {
  if (text == null) {
    return "";
  }
  final sentences = text.split('.').map((s) {
    if (s.isEmpty) {
      return '';
    }
    return _firstLetterCapital(s.trim());
  }).toList(growable: false);
  return sentences.join(". ").trim();
}
