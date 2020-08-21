part of 'algo.dart';

final _dateFormat = DateFormat("MMM dd, yyyy", "en_US");

/// Create a object that holds the String options that can be used
/// format a [DateTime]
@immutable
class Formatter {
  // Formatter initializer types
  /// Use large format type. Eg: minutes, hours
  static const large = Formatter(
    yesterday: 'yesterday',
    justNow: 'just now',
    minute: 'minute',
    minutes: 'minutes',
    hour: 'hour',
    hours: 'hours',
    day: 'day',
    days: 'days',
  );

  /// Use small format type. Eg: mins, hrs
  static const small = Formatter(
    yesterday: 'yesterday',
    justNow: 'now',
    minute: 'min',
    minutes: 'mins',
    hour: 'hr',
    hours: 'hrs',
    day: 'day',
    days: 'days',
  );

  /// Eg: just now
  final String justNow;

  /// Eg: 1 minute ago
  final String minute;

  /// Eg: 3 minutes ago
  final String minutes;

  /// Eg: 1 hour ago
  final String hour;

  /// Eg: 2 hours ago
  final String hours;

  /// Eg: 1 day ago
  final String day;

  /// Eg: 3 days ago
  final String days;

  /// Eg: yesterday
  final String yesterday;

  /// Create a object that holds the String options that can be used
  /// format a [DateTime]
  const Formatter({
    @required this.yesterday,
    @required this.justNow,
    @required this.minute,
    @required this.minutes,
    @required this.hour,
    @required this.hours,
    @required this.day,
    @required this.days,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Formatter &&
          runtimeType == other.runtimeType &&
          yesterday == other.yesterday &&
          justNow == other.justNow &&
          minute == other.minute &&
          minutes == other.minutes &&
          hour == other.hour &&
          hours == other.hours &&
          day == other.day &&
          days == other.days;

  @override
  int get hashCode =>
      yesterday.hashCode ^
      justNow.hashCode ^
      minute.hashCode ^
      minutes.hashCode ^
      hour.hashCode ^
      hours.hashCode ^
      day.hashCode ^
      days.hashCode;
}

String _formatTime(
  DateTime d, {
  Formatter formatter,
  bool showAgo,
  bool showYesterday,
  DateFormat df,
}) {
  final now = DateTime.now();
  if (showYesterday) {
    final yesterday = DateTime(now.year, now.month, now.day - 1);
    final interested = DateTime(d.year, d.month, d.day);
    if (yesterday == interested) {
      return formatter.yesterday;
    }
  }
  final difference = now.difference(d);

  addAgo(str) => showAgo ? '$str ago' : str;

  final inSec = difference.inSeconds;
  if (inSec < 55) {
    return formatter.justNow;
  }
  if (inSec < 100) {
    return addAgo("1 ${formatter.minute}");
  }
  if (inSec < 125) {
    return addAgo("2 ${formatter.minutes}");
  }

  final inMin = difference.inMinutes;
  if (inMin < 15) {
    return addAgo("$inMin ${formatter.minutes}");
  }
  if (inMin < 18) {
    return addAgo("15 ${formatter.minutes}");
  }
  if (inMin < 25) {
    return addAgo("20 ${formatter.minutes}");
  }
  if (inMin < 38) {
    return addAgo("30 ${formatter.minutes}");
  }
  if (inMin < 53) {
    return addAgo("45 ${formatter.minutes}");
  }
  if (inMin < 105) {
    return addAgo("1 ${formatter.hour}");
  }
  if (inMin < 125) {
    return addAgo("2 ${formatter.hours}");
  }

  final inH = difference.inHours;
  if (inH <= 22) {
    return addAgo("$inH ${formatter.hours}");
  }
  if (inH <= 40) {
    return addAgo("1 ${formatter.day}");
  }
  if (inH <= 50) {
    return addAgo("2 ${formatter.days}");
  }

  final inD = difference.inDays;
  if (inD <= 3) {
    return addAgo("$inD ${formatter.days}");
  }
  return (df ?? _dateFormat).format(d);
}
