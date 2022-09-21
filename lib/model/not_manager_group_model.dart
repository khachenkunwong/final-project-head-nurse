// To parse this JSON data, do
//
//     final getNotManagerGroup = getNotManagerGroupFromJson(jsonString);

import 'dart:convert';

GetNotManagerGroup getNotManagerGroupFromJson(String str) => GetNotManagerGroup.fromJson(json.decode(str));

String getNotManagerGroupToJson(GetNotManagerGroup data) => json.encode(data.toJson());

class GetNotManagerGroup {
    GetNotManagerGroup({
        this.members,
    });

    List<MemberNotManagerGroup>? members;

    factory GetNotManagerGroup.fromJson(Map<String, dynamic> json) => GetNotManagerGroup(
        members: json["members"] == null ? null : List<MemberNotManagerGroup>.from(json["members"].map((x) => MemberNotManagerGroup.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "members": members == null ? null : List<dynamic>.from(members!.map((x) => x.toJson())),
    };
}

class MemberNotManagerGroup {
    MemberNotManagerGroup({
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

    factory MemberNotManagerGroup.fromJson(Map<String, dynamic> json) => MemberNotManagerGroup(
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
