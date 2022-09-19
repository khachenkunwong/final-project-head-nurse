// To parse this JSON data, do
//
//     final getChangDuty = getChangDutyFromJson(jsonString);

import 'dart:convert';

GetChangDuty getChangDutyFromJson(String str) =>
    GetChangDuty.fromJson(json.decode(str));

String getChangDutyToJson(GetChangDuty data) => json.encode(data.toJson());

class GetChangDuty {
  GetChangDuty({
    this.data,
  });

  List<Datum>? data;

  factory GetChangDuty.fromJson(Map<String, dynamic> json) => GetChangDuty(
        data: json["data"] == null
            ? null
            : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.id,
    this.group1,
    this.group2,
    this.member1,
    this.member2,
    this.duty1,
    this.duty2,
    this.memberShift1,
    this.memberShift2,
    this.memberApprove,
    this.show,
    this.approve,
    this.v,
  });

  String? id;
  String? group1;
  String? group2;
  Member? member1;
  Member? member2;
  Duty? duty1;
  Duty? duty2;
  List<MemberShift1>? memberShift1;
  List<MemberShift2>? memberShift2;
  bool? memberApprove;
  bool? show;
  bool? approve;
  int? v;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"] == null ? null : json["_id"],
        group1: json["_group1"] == null ? null : json["_group1"],
        group2: json["_group2"] == null ? null : json["_group2"],
        member1:
            json["member1"] == null ? null : Member.fromJson(json["member1"]),
        member2:
            json["member2"] == null ? null : Member.fromJson(json["member2"]),
        duty1: json["_duty1"] == null ? null : Duty.fromJson(json["_duty1"]),
        duty2: json["_duty2"] == null ? null : Duty.fromJson(json["_duty2"]),
        memberShift1: json["member_shift1"] == null
            ? null
            : List<MemberShift1>.from(
                json["member_shift1"].map((x) => MemberShift1.fromJson(x))),
        memberShift2: json["member_shift2"] == null
            ? null
            : List<MemberShift2>.from(
                json["member_shift2"].map((x) => MemberShift2.fromJson(x))),
        memberApprove:
            json["member_approve"] == null ? null : json["member_approve"],
        show: json["show"] == null ? null : json["show"],
        approve: json["approve"] == null ? null : json["approve"],
        v: json["__v"] == null ? null : json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "_group1": group1 == null ? null : group1,
        "_group2": group2 == null ? null : group2,
        "member1": member1 == null ? null : member1!.toJson(),
        "member2": member2 == null ? null : member2!.toJson(),
        "_duty1": duty1 == null ? null : duty1!.toJson(),
        "_duty2": duty2 == null ? null : duty2!.toJson(),
        "member_shift1": memberShift1 == null
            ? null
            : List<dynamic>.from(memberShift1!.map((x) => x.toJson())),
        "member_shift2": memberShift2 == null
            ? null
            : List<dynamic>.from(memberShift2!.map((x) => x.toJson())),
        "member_approve": memberApprove == null ? null : memberApprove,
        "show": show == null ? null : show,
        "approve": approve == null ? null : approve,
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

class Member {
  Member({
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

  factory Member.fromJson(Map<String, dynamic> json) => Member(
        id: json["_id"] == null ? null : json["_id"],
        fristName: json["frist_name"] == null ? null : json["frist_name"],
        lastName: json["last_name"] == null ? null : json["last_name"],
        email: json["email"] == null ? null : json["email"],
        password: json["password"] == null ? null : json["password"],
        actor: json["actor"] == null ? null : json["actor"],
        location: json["location"] == null ? null : json["location"],
        tokenVersion:
            json["tokenVersion"] == null ? null : json["tokenVersion"],
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

class MemberShift1 {
  MemberShift1({
    this.morning,
    this.noon,
    this.night,
  });
  int? morning;
  int? noon;
  int? night;

  factory MemberShift1.fromJson(Map<String, dynamic> json) => MemberShift1(
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

class MemberShift2 {
  MemberShift2({
    this.morning,
    this.noon,
    this.night,
  });
  int? morning;
  int? noon;
  int? night;

  factory MemberShift2.fromJson(Map<String, dynamic> json) => MemberShift2(
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
