import 'package:fcode_common/src/util/slack_bot.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("Check Slack Bot", () async {
    final url = 'https://hooks.slack.com/services/TEMBB9C86/'
        'B019DLJ8FQB/s4UK9wdto8lr4ehyth9lobAD';
    final msg = SlackBot.composeMsg(url)
      ..addHeader("This is header")
      ..addTextSection("This is body");
    final sent = await msg.build().send();
    expect(sent, true);
  });
}
