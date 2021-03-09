import 'dart:convert';

import 'package:http/http.dart' as http;

/// Inspired by the Block Kit Builder
/// https://app.slack.com/block-kit-builder/
class _Message {
  final _msg = <Map<String, dynamic>>[];
  final String _url;

  _Message(this._url);

  /// Add a header block to the message
  void addHeader(String header) {
    _msg.add({
      "type": "header",
      "text": {"type": "plain_text", "text": header, "emoji": true}
    });
  }

  /// Add a text section block to the message
  void addTextSection(String text) {
    _msg.add({
      "type": "section",
      "text": {"type": "plain_text", "text": text, "emoji": true}
    });
  }

  /// Add a markdown section block to the message
  void addMarkdownSection(String mrkdwn) {
    _msg.add({
      "type": "section",
      "text": {"type": "mrkdwn", "text": mrkdwn}
    });
  }

  /// Add a fields section block to the message
  void addFieldsSection(List<String> fields) {
    _msg.add({
      "type": "section",
      "fields": fields
          .map((txt) => {
                "type": "plain_text",
                "text": txt,
                "emoji": true,
              })
          .toList(growable: false),
    });
  }

  /// Add a divider block to the message
  void addDivider() {
    _msg.add({"type": "divider"});
  }

  /// Add a image block to the message
  void addImage(String imgURL, String altText, [String? title]) {
    _msg.add({
      "type": "image",
      if (title != null)
        "title": {
          "type": "plain_text",
          "text": title,
          "emoji": true,
        },
      "image_url": imgURL,
      "alt_text": altText,
    });
  }

  /// Generate a [SlackBot] from the message so that it can be sent to
  /// the slack channel
  SlackBot build() {
    return SlackBot._(
      _url,
      jsonEncode({
        "blocks": _msg,
      }),
    );
  }
}

/// This can be used to send messages to a Slack incoming webhook.
///
/// First you need to create a [_Message] object using [composeMsg].
/// You can use the return instance to generate a custom message.
///
/// ```dart
/// final url = 'https://hooks.slack.com/services/XXX/XXX/XXX';
/// final msg = SlackBot.composeMsg(url)
///   ..addHeader("This is header")
///   ..addTextSection("This is body");
/// ```
///
/// Then you can build it and and [send] it.
///
/// ```dart
/// final sent = await msg.build().send();
/// ```
class SlackBot {
  final String _msg;
  final String _url;

  SlackBot._(this._url, this._msg);

  /// Create a [_Message] instance that can be used to compose a custom
  /// message.
  static _Message composeMsg(String url) {
    return _Message(url);
  }

  /// Use this method to send a message to the slack incoming webhook url
  /// that was given by [composeMsg] method. Instance of [SlackBot] can be
  /// created using the [_Message.build] method. You can create [_Message]
  /// instances using [composeMsg] method.
  ///
  /// This function will return [true] if the message was sent successfully
  /// and [false] otherwise.
  Future<bool> send() async {
    final response = await http.post(
      Uri.parse(_url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: _msg,
    );
    return response.statusCode == 201 || response.statusCode == 200;
  }
}
