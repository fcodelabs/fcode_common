abstract class CronParser {
  CronParser._();

  static String _format(List<int> value, int step) {
    final s = (value?.isEmpty ?? true) ? '*' : value.join(",");
    if (step == null) {
      return s;
    }
    return '$s/$step';
  }

  static List<int> _parse(String value) {
    final v = value.split("/");
    if (v.length == 1) {
      return [int.parse(value), null];
    }
    return v.map((s) => int.parse(s)).toList(growable: false);
  }

  static String format(Repeat repeat) {
    assert(repeat != null);
    final repeatList = repeat.asList();
    final parsed = [
      for (var i = 0; i < repeatList.length / 2; i++)
        _format(repeatList[i * 2], repeatList[i * 2 + 1]),
    ];
    return parsed.join(' ');
  }

  static Repeat parse(String cron) {
    final crons = cron.split(" ");
    return Repeat.fromList(
      crons.map((c) => _parse(c)).expand((v) => v).toList(growable: false),
    );
  }
}

class Repeat {
  final List<int> min;
  final int minStep;
  final List<int> hour;
  final int hourStep;
  final List<int> dayOfMonth;
  final int dayOfMonthStep;
  final List<int> month;
  final int monthStep;
  final List<int> dayOfWeek;
  final int dayOfWeekStep;

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
