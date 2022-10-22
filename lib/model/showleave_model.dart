// To parse this JSON data, do
//
//     final shownotificationLeave = shownotificationLeaveFromJson(jsonString);

import 'dart:convert';

ShownotificationLeave shownotificationLeaveFromJson(String str) => ShownotificationLeave.fromJson(json.decode(str));

String shownotificationLeaveToJson(ShownotificationLeave data) => json.encode(data.toJson());

class ShownotificationLeave {
    ShownotificationLeave({
        this.notifications,
    });

    List<Notification>? notifications;

    factory ShownotificationLeave.fromJson(Map<String, dynamic> json) => ShownotificationLeave(
        notifications: json["notifications"] == null ? null : List<Notification>.from(json["notifications"].map((x) => Notification.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "notifications": notifications == null ? null : List<dynamic>.from(notifications!.map((x) => x.toJson())),
    };
}

class Notification {
    Notification({
        this.type,
        this.id,
        this.noift,
        this.fields,
    });

    String? type;
    String? id;
    String? noift;
    Fields? fields;

    factory Notification.fromJson(Map<String, dynamic> json) => Notification(
        type: json["type"] == null ? null : json["type"],
        id: json["_id"] == null ? null : json["_id"],
        noift: json["noift"] == null ? null : json["noift"],
        fields: json["fields"] == null ? null : Fields.fromJson(json["fields"]),
    );

    Map<String, dynamic> toJson() => {
        "type": type == null ? null : type,
        "_id": id == null ? null : id,
        "noift": noift == null ? null : noift,
        "fields": fields == null ? null : fields!.toJson(),
    };
}

class Fields {
    Fields({
        this.createdBy,
        this.duty,
        this.shift,
        this.approve,
        this.leader,
    });

    CreatedBy? createdBy;
    Duty? duty;
    Shift? shift;
    bool? approve;
    String? leader;

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        createdBy: json["createdBy"] == null ? null : CreatedBy.fromJson(json["createdBy"]),
        duty: json["duty"] == null ? null : Duty.fromJson(json["duty"]),
        shift: json["shift"] == null ? null : Shift.fromJson(json["shift"]),
        approve: json["approve"] == null ? null : json["approve"],
        leader: json["leader"] == null ? null : json["leader"],
    );

    Map<String, dynamic> toJson() => {
        "createdBy": createdBy == null ? null : createdBy!.toJson(),
        "duty": duty == null ? null : duty!.toJson(),
        "shift": shift == null ? null : shift!.toJson(),
        "approve": approve == null ? null : approve,
        "leader": leader == null ? null : leader,
    };
}

class CreatedBy {
    CreatedBy({
        this.id,
        this.fristName,
        this.lastName,
        this.email,
        this.password,
        this.actor,
        this.location,
        this.tokenVersion,
        this.v,
    });

    String? id;
    String? fristName;
    String? lastName;
    String? email;
    String? password;
    String? actor;
    String? location;
    int? tokenVersion;
    int? v;

    factory CreatedBy.fromJson(Map<String, dynamic> json) => CreatedBy(
        id: json["_id"] == null ? null : json["_id"],
        fristName: json["frist_name"] == null ? null : json["frist_name"],
        lastName: json["last_name"] == null ? null : json["last_name"],
        email: json["email"] == null ? null : json["email"],
        password: json["password"] == null ? null : json["password"],
        actor: json["actor"] == null ? null : json["actor"],
        location: json["location"] == null ? null : json["location"],
        tokenVersion: json["tokenVersion"] == null ? null : json["tokenVersion"],
        v: json["__v"] == null ? null : json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "frist_name": fristName == null ? null : fristName,
        "last_name": lastName == null ? null : lastName,
        "email": email == null ? null : email,
        "password": password == null ? null : password,
        "actor": actor == null ? null : actor,
        "location": location == null ? null : location,
        "tokenVersion": tokenVersion == null ? null : tokenVersion,
        "__v": v == null ? null : v,
    };
}

class Duty {
    Duty({
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
        this.v,
    });

    String? id;
    String? user;
    String? year;
    String? month;
    String? day;
    String? group;
    int? morning;
    int? noon;
    int? night;
    int? count;
    int? v;

    factory Duty.fromJson(Map<String, dynamic> json) => Duty(
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
        v: json["__v"] == null ? null : json["__v"],
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
        "__v": v == null ? null : v,
    };
}

class Shift {
    Shift({
        this.morning,
        this.noon,
        this.night,
    });

    int? morning;
    int? noon;
    int? night;

    factory Shift.fromJson(Map<String, dynamic> json) => Shift(
        morning: json["morning"] == null ? null : json["morning"],
        noon: json["noon"] == null ? null : json["noon"],
        night: json["night"] == null ? null : json["night"],
    );

    Map<String, dynamic> toJson() => {
        "morning": morning == null ? null : morning,
        "noon": noon == null ? null : noon,
        "night": night == null ? null : night,
    };
}
