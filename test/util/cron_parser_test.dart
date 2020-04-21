import 'package:fcode_common/fcode_common.dart';
import 'package:flutter_test/flutter_test.dart';

void checkRepeat(Repeat actual, Repeat matcher) {
  expect(actual.min, matcher.min, reason: 'Repeater min not matching');
  expect(actual.minStep, matcher.minStep,
      reason: 'Repeater minStep not matching');
  expect(actual.hour, matcher.hour, reason: 'Repeater hour not matching');
  expect(actual.hourStep, matcher.hourStep,
      reason: 'Repeater hourStep not matching');
  expect(actual.dayOfMonth, matcher.dayOfMonth,
      reason: 'Repeater dayOfMonth not matching');
  expect(actual.dayOfMonthStep, matcher.dayOfMonthStep,
      reason: 'Repeater dayOfMonthStep not matching');
  expect(actual.month, matcher.month, reason: 'Repeater month not matching');
  expect(actual.monthStep, matcher.monthStep,
      reason: 'Repeater monthStep not matching');
  expect(actual.dayOfWeek, matcher.dayOfWeek,
      reason: 'Repeater dayOfWeek not matching');
  expect(actual.dayOfWeekStep, matcher.dayOfWeekStep,
      reason: 'Repeater dayOfWeekStep not matching');
}

void main() {
  group("CronParser", () {
    final jobs = {
      '43/3 4-7 * */2 3': Repeat(
        min: [43],
        minStep: 3,
        hour: [-1, 4, 7],
        monthStep: 2,
        dayOfWeek: [3],
      ),
      '*/3 * 5,8,10/3 * 2/3': Repeat(
        minStep: 3,
        dayOfMonth: [5, 8, 10],
        dayOfMonthStep: 3,
        dayOfWeek: [2],
        dayOfWeekStep: 3,
      ),
      '30-50/3 8 10/3 */2 *': Repeat(
        min: [-1, 30, 50],
        minStep: 3,
        hour: [8],
        dayOfMonth: [10],
        dayOfMonthStep: 3,
        monthStep: 2,
      ),
    };

    for (final cron in jobs.keys) {
      final repeat = jobs[cron];
      test('Cron: $cron  - format', () {
        expect(CronParser.format(repeat), cron);
      });
      test('Cron: $cron - parse', () {
        checkRepeat(CronParser.parse(cron), repeat);
      });
    }
  });
}
