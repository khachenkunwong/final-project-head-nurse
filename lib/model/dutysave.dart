// To parse this JSON data, do
//
//     final dutySave = dutySaveFromJson(jsonString);

import 'dart:convert';

DutySave dutySaveFromJson(String str) => DutySave.fromJson(json.decode(str));

String dutySaveToJson(DutySave data) => json.encode(data.toJson());

class DutySave {
    DutySave({
        this.id,
        this.user,
        this.year,
        this.month,
        this.day,
        this.group,
        this.morning,
        this.noon,
        this.night,
        this.count,
    });

    String? id;
    String? user;
    String? year;
    String? month;
    String? day;
    String? group;
    String? morning;
    String? noon;
    String? night;
    String? count;

    factory DutySave.fromJson(Map<String, dynamic> json) => DutySave(
        id: json["_id"] == null ? null : json["_id"],
        user: json["_user"] == null ? null : json["_user"],
        year: json["year"] == null ? null : json["year"],
        month: json["month"] == null ? null : json["month"],
        day: json["day"] == null ? null : json["day"],
        group: json["group"] == null ? null : json["group"],
        morning: json["morning"] == null ? null : json["morning"],
        noon: json["noon"] == null ? null : json["noon"],
        night: json["night"] == null ? null : json["night"],
        count: json["count"] == null ? null : json["count"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "_user": user == null ? null : user,
        "year": year == null ? null : year,
        "month": month == null ? null : month,
        "day": day == null ? null : day,
        "group": group == null ? null : group,
        "morning": morning == null ? null : morning,
        "noon": noon == null ? null : noon,
        "night": night == null ? null : night,
        "count": count == null ? null : count,
    };
}
