// To parse this JSON data, do
//
//     final getchangdutyV1 = getchangdutyV1FromJson(jsonString);

import 'dart:convert';

GetchangdutyV1 getchangdutyV1FromJson(String str) => GetchangdutyV1.fromJson(json.decode(str));

String getchangdutyV1ToJson(GetchangdutyV1 data) => json.encode(data.toJson());

class GetchangdutyV1 {
    GetchangdutyV1({
        this.notifications,
    });

    List<Notification>? notifications;

    factory GetchangdutyV1.fromJson(Map<String, dynamic> json) => GetchangdutyV1(
        notifications: json["notifications"] == null ? null : List<Notification>.from(json["notifications"].map((x) => Notification.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "notifications": notifications == null ? null : List<dynamic>.from(notifications!.map((x) => x.toJson())),
    };
}

class Notification {
    Notification({
        this.id,
        this.type,
        this.fields,
        this.approveBy,
        this.noift,
        this.user,
    });

    String? id;
    String? type;
    Fields? fields;
    dynamic approveBy;
    String? noift;
    NotificationUser? user;

    factory Notification.fromJson(Map<String, dynamic> json) => Notification(
        id: json["_id"] == null ? null : json["_id"],
        type: json["type"] == null ? null : json["type"],
        fields: json["fields"] == null ? null : Fields.fromJson(json["fields"]),
        approveBy: json["approve_by"],
        noift: json["noift"] == null ? null : json["noift"],
        user: json["user"] == null ? null : NotificationUser.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "type": type == null ? null : type,
        "fields": fields == null ? null : fields?.toJson(),
        "approve_by": approveBy,
        "noift": noift == null ? null : noift,
        "user": user == null ? null : user?.toJson(),
    };
}

class Fields {
    Fields({
        this.me,
        this.withoutme,
        this.user,
    });

    Me? me;
    Me? withoutme;
    FieldsUser? user;

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        me: json["me"] == null ? null : Me.fromJson(json["me"]),
        withoutme: json["withoutme"] == null ? null : Me.fromJson(json["withoutme"]),
        user: json["user"] == null ? null : FieldsUser.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "me": me == null ? null : me?.toJson(),
        "withoutme": withoutme == null ? null : withoutme?.toJson(),
        "user": user == null ? null : user?.toJson(),
    };
}

class Me {
    Me({
        this.id,
        this.userId,
        this.year,
        this.month,
        this.day,
        this.group,
        this.v,
        this.dutyString,
        this.dutyNumber,
    });

    String? id;
    String? userId;
    int? year;
    int? month;
    int? day;
    String? group;
    int? v;
    String? dutyString;
    int? dutyNumber;

    factory Me.fromJson(Map<String, dynamic> json) => Me(
        id: json["id"] == null ? null : json["id"],
        userId: json["userID"] == null ? null : json["userID"],
        year: json["year"] == null ? null : json["year"],
        month: json["month"] == null ? null : json["month"],
        day: json["day"] == null ? null : json["day"],
        group: json["group"] == null ? null : json["group"],
        v: json["v"] == null ? null : json["v"],
        dutyString: json["dutyString"] == null ? null : json["dutyString"],
        dutyNumber: json["dutyNumber"] == null ? null : json["dutyNumber"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "userID": userId == null ? null : userId,
        "year": year == null ? null : year,
        "month": month == null ? null : month,
        "day": day == null ? null : day,
        "group": group == null ? null : group,
        "v": v == null ? null : v,
        "dutyString": dutyString == null ? null : dutyString,
        "dutyNumber": dutyNumber == null ? null : dutyNumber,
    };
}

class FieldsUser {
    FieldsUser({
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

    factory FieldsUser.fromJson(Map<String, dynamic> json) => FieldsUser(
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

class NotificationUser {
    NotificationUser({
        this.fristName,
        this.lastName,
    });

    String? fristName;
    String? lastName;

    factory NotificationUser.fromJson(Map<String, dynamic> json) => NotificationUser(
        fristName: json["frist_name"] == null ? null : json["frist_name"],
        lastName: json["last_name"] == null ? null : json["last_name"],
    );

    Map<String, dynamic> toJson() => {
        "frist_name": fristName == null ? null : fristName,
        "last_name": lastName == null ? null : lastName,
    };
}
