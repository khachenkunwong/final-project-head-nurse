// To parse this JSON data, do
//
//     final memberCall = memberCallFromJson(jsonString);

import 'dart:convert';

MemberCall memberCallFromJson(String str) => MemberCall.fromJson(json.decode(str));

String memberCallToJson(MemberCall data) => json.encode(data.toJson());

class MemberCall {
    MemberCall({
        this.group,
    });

    List<Group>? group;

    factory MemberCall.fromJson(Map<String, dynamic> json) => MemberCall(
        group: json["group"] == null ? null : List<Group>.from(json["group"].map((x) => Group.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "group": group == null ? null : List<dynamic>.from(group!.map((x) => x.toJson())),
    };
}

class Group {
    Group({
        this.id,
        this.location,
        this.nameGroup,
        this.leader,
        this.member,
        this.v,
    });

    String? id;
    String? location;
    String? nameGroup;
    List<Leader>? leader;
    List<Leader>? member;
    int? v;

    factory Group.fromJson(Map<String, dynamic> json) => Group(
        id: json["_id"] == null ? null : json["_id"],
        location: json["location"] == null ? null : json["location"],
        nameGroup: json["name_group"] == null ? null : json["name_group"],
        leader: json["_leader"] == null ? null : List<Leader>.from(json["_leader"].map((x) => Leader.fromJson(x))),
        member: json["_member"] == null ? null : List<Leader>.from(json["_member"].map((x) => Leader.fromJson(x))),
        v: json["__v"] == null ? null : json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "location": location == null ? null : location,
        "name_group": nameGroup == null ? null : nameGroup,
        "_leader": leader == null ? null : List<dynamic>.from(leader!.map((x) => x.toJson())),
        "_member": member == null ? null : List<dynamic>.from(member!.map((x) => x.toJson())),
        "__v": v == null ? null : v,
    };
}

class Leader {
    Leader({
        this.id,
        this.fristName,
        this.lastName,
        this.email,
        this.actor,
        this.location,
    });

    String? id;
    String? fristName;
    String? lastName;
    String? email;
    String? actor;
    String? location;

    factory Leader.fromJson(Map<String, dynamic> json) => Leader(
        id: json["_id"] == null ? null : json["_id"],
        fristName: json["frist_name"] == null ? null : json["frist_name"],
        lastName: json["last_name"] == null ? null : json["last_name"],
        email: json["email"] == null ? null : json["email"],
        actor: json["actor"] == null ? null : json["actor"],
        location: json["location"] == null ? null : json["location"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "frist_name": fristName == null ? null : fristName,
        "last_name": lastName == null ? null : lastName,
        "email": email == null ? null : email,
        "actor": actor == null ? null : actor,
        "location": location == null ? null : location,
    };
}
