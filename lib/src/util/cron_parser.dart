/// Can be used to convert a cron String to a [Repeat] and
/// vice versa
abstract class CronParser {
  CronParser._();

  static String _format(List<int> value, int step) {
    final empty = value?.isEmpty ?? true;
    final s = empty
        ? '*'
        : value[0] == -1 ? '${value[1]}-${value[2]}' : value.join(",");
    if (step == null) {
      return s;
    }
    return '$s/$step';
  }

  static List _parse(String value) {
    final v = value.split("/");
    int step;
    if (v.length == 2) {
      step = int.parse(v[1]);
    }
    if (v[0] == '*') {
      return [null, step];
    }

    final range = v[0].split('-');
    if (range.length == 2) {
      return [
        [-1, int.parse(range[0]), int.parse(range[1])],
        step
      ];
    }

    final separated = v[0].split(',');
    return [separated.map(int.parse).toList(growable: false), step];
  }

  /// Format the [repeat] as a cron [String].
  static String format(Repeat repeat) {
    assert(repeat != null);
    final repeatList = repeat.asList();
    final parsed = [
      for (var i = 0; i < repeatList.length / 2; i++)
        _format(repeatList[i * 2], repeatList[i * 2 + 1]),
    ];
    return parsed.join(' ');
  }

  /// Parse the given [cron] [String] to a [Repeat] object.
  static Repeat parse(String cron) {
    final crons = cron.split(" ");
    return Repeat.fromList(
      crons.map(_parse).expand((v) => v).toList(growable: false),
    );
  }
}

/// {@template cron_repeat}
/// Store the information of a Cron String
/// Support for cron string without seconds
///
/// ## Data format of the value [List]s
///
/// [min], [hour], [dayOfMonth], [month], [dayOfWeek] all are lists.
/// If the first element of the list is -1, then 2nd and 3rd elements
/// should be there and formatted as a range
///
/// If the first element is not -1, then values will be separated by commas.
///
/// Eg:
/// * [5, 6, 11] will be formatted as '5,6,11'
/// * [-1, 8, 21] will be formatted as '8-21'
/// {@endtemplate}
class Repeat {
  /// Same as the value at first position of the cron String
  final List<int> min;

  /// Same as the step at the first position of the cron String
  final int minStep;

  /// Same as the value at second position of the cron String
  final List<int> hour;

  /// Same as the step at the second position of the cron String
  final int hourStep;

  /// Same as the value at third position of the cron String
  final List<int> dayOfMonth;

  /// Same as the step at the third position of the cron String
  final int dayOfMonthStep;

  /// Same as the value at fourth position of the cron String
  final List<int> month;

  /// Same as the step at the fourth position of the cron String
  final int monthStep;

  /// Same as the value at fifth position of the cron String
  final List<int> dayOfWeek;

  /// Same as the step at the fifth position of the cron String
  final int dayOfWeekStep;

  /// {@macro cron_repeat}
  Repeat({
    this.min,
    this.minStep,
    this.hour,
    this.hourStep,
    this.dayOfMonth,
    this.dayOfMonthStep,
    this.month,
    this.monthStep,
    this.dayOfWeek,
    this.dayOfWeekStep,
  });

  /// Create a [Repeat] from the given list of [values]. Size of the [List]
  /// should be equal to 10.
  ///
  /// Values should be ordered as:
  /// [min], [minStep], [hour], [hourStep], [dayOfMonth], [dayOfMonthStep],
  /// [month], [monthStep], [dayOfWeek], [dayOfWeekStep]
  ///
  /// It is the same order of the values in the cron String
  Repeat.fromList(List values)
      : assert(values != null && values.length == 10),
        min = values[0],
        minStep = values[1],
        hour = values[2],
        hourStep = values[3],
        dayOfMonth = values[4],
        dayOfMonthStep = values[5],
        month = values[6],
        monthStep = values[7],
        dayOfWeek = values[8],
        dayOfWeekStep = values[9];

  /// Convert this [Repeat] to a List.
  ///
  /// This list has all the properties such that it can be used to generate
  /// a [Repeat] using [Repeat.fromList].
  List asList() {
    return [
      min,
      minStep,
      hour,
      hourStep,
      dayOfMonth,
      dayOfMonthStep,
      month,
      monthStep,
      dayOfWeek,
      dayOfWeekStep,
    ];
  }
}
