extension StringExtension on String {
  String capitalizeSentence() {
    return '${this[0].toUpperCase()}${substring(1)}';
  }
}