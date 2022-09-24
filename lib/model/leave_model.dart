// To parse this JSON data, do
//
//     final getLeave = getLeaveFromJson(jsonString);

import 'dart:convert';

GetLeave getLeaveFromJson(String str) => GetLeave.fromJson(json.decode(str));

String getLeaveToJson(GetLeave data) => json.encode(data.toJson());

class GetLeave {
    GetLeave({
        this.data,
    });

    List<DatumLeave>? data;

    factory GetLeave.fromJson(Map<String, dynamic> json) => GetLeave(
        data: json["data"] == null ? null : List<DatumLeave>.from(json["data"].map((x) => DatumLeave.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class DatumLeave {
    DatumLeave({
        this.id,
        this.location,
        this.user,
        this.type,
        this.detail,
        this.duty,
        this.shift,
        this.show,
        this.approve,
        this.v,
    });

    String? id;
    String? location;
    User? user;
    String? type;
    String? detail;
    String? duty;
    Shift? shift;
    bool? show;
    bool? approve;
    int? v;

    factory DatumLeave.fromJson(Map<String, dynamic> json) => DatumLeave(
        id: json["_id"] == null ? null : json["_id"],
        location: json["location"] == null ? null : json["location"],
        user: json["_user"] == null ? null : User.fromJson(json["_user"]),
        type: json["type"] == null ? null : json["type"],
        detail: json["detail"] == null ? null : json["detail"],
        duty: json["_duty"] == null ? null : json["_duty"],
        shift: json["shift"] == null ? null : Shift.fromJson(json["shift"]),
        show: json["show"] == null ? null : json["show"],
        approve: json["approve"] == null ? null : json["approve"],
        v: json["__v"] == null ? null : json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "location": location == null ? null : location,
        "_user": user == null ? null : user!.toJson(),
        "type": type == null ? null : type,
        "detail": detail == null ? null : detail,
        "_duty": duty == null ? null : duty,
        "shift": shift == null ? null : shift!.toJson(),
        "show": show == null ? null : show,
        "approve": approve == null ? null : approve,
        "__v": v == null ? null : v,
    };
}

class Shift {
    Shift({
        this.noon,
    });

    int? noon;

    factory Shift.fromJson(Map<String, dynamic> json) => Shift(
        noon: json["noon"] == null ? null : json["noon"],
    );

    Map<String, dynamic> toJson() => {
        "noon": noon == null ? null : noon,
    };
}

class User {
    User({
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

    factory User.fromJson(Map<String, dynamic> json) => User(
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
