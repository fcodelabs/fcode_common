part of 'algo.dart';

final _dateFormat = DateFormat("MMM dd, yyyy", "en_US");

String _formatTime(DateTime d) {
  final now = DateTime.now();
  final difference = now.difference(d);
  final inSec = difference.inSeconds;
  if (inSec < 55) {
    return "Just Now";
  }
  if (inSec < 100) {
    return "1 minute ago";
  }
  if (inSec < 125) {
    return "2 minutes ago";
  }

  final inMin = difference.inMinutes;
  if (inMin < 15) {
    return "$inMin minutes ago";
  }
  if (inMin < 18) {
    return "15 minutes ago";
  }
  if (inMin < 25) {
    return "20 minutes ago";
  }
  if (inMin < 38) {
    return "30 minutes ago";
  }
  if (inMin < 53) {
    return "45 minutes ago";
  }
  if (inMin < 105) {
    return "1 hour ago";
  }
  if (inMin < 125) {
    return "2 hours ago";
  }

  final inH = difference.inHours;
  if (inH <= 22) {
    return "$inH hours ago";
  }
  if (inH <= 25) {
    return "1 day ago";
  }

  final inD = difference.inDays;
  if (inD <= 3) {
    return "$inD days ago";
  }
  return _dateFormat.format(d);
}
