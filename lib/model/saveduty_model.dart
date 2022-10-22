// To parse this JSON data, do
//
//     final saveduty = savedutyFromJson(jsonString);

import 'dart:convert';

Saveduty savedutyFromJson(String str) => Saveduty.fromJson(json.decode(str));

String savedutyToJson(Saveduty data) => json.encode(data.toJson());

class Saveduty {
  Saveduty({
    this.nameGroup,
    this.aaa,
  });

  String? aaa;
  String? nameGroup;

  Saveduty.fromJson(Map<String, dynamic> json) {
    Saveduty(
      // ignore: unnecessary_brace_in_string_interps
      aaa: json["$nameGroup"] == null ? null : json["$nameGroup"],
    );
  }

  Map<String, dynamic> toJson() => {
        "$nameGroup": aaa == null ? null : aaa,
      };
}
