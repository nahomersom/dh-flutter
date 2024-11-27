import 'package:dh/model/models.dart';

class Group {
  final int? id;
  final String? name;
  final String? color;
  final int? orgId;
  final String? createdAt;
  final String? updatedAt;
  final List<GroupMember>? orgGroupMembers;
  final User? personal;

  Group({
    this.id,
    this.name,
    this.orgId,
    this.color,
    this.createdAt,
    this.updatedAt,
    this.personal,
    this.orgGroupMembers,
  });

  factory Group.fromJson(Map<String, dynamic> json) {
    var list =
        json['OrgGroupMember'] == null ? [] : json['OrgGroupMember'] as List;
    List<GroupMember> membersList =
        list.map((i) => GroupMember.fromJson(i)).toList();
    print("####$json");
    return Group(
      id: json['id'],
      name: json['name'],
      color: json['color'],
      orgId: json['orgId'] == null
          ? json["org"] == null
              ? null
              : json["org"]["id"]
          : json["orgId"],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      personal:
          json['personal'] == null ? null : User.fromJson(json["personal"]),
      orgGroupMembers: membersList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'orgId': orgId,
      'color': color,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'OrgGroupMember':
          orgGroupMembers?.map((member) => member.toJson()).toList(),
    };
  }
}

class GroupMember {
  final int? groupId;
  final int? memberId;
  final String? createdAt;
  final String? updatedAt;
  final Member? member;

  GroupMember({
    this.groupId,
    this.memberId,
    this.createdAt,
    this.updatedAt,
    this.member,
  });

  factory GroupMember.fromJson(Map<String, dynamic> json) {
    return GroupMember(
      groupId: json['groupId'],
      memberId: json['memberId'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      member: json['member'] == null ? null : Member.fromJson(json['member']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'groupId': groupId,
      'memberId': memberId,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'member': member?.toJson(),
    };
  }
}

class Member {
  final int? id;
  final String? firstName;
  final String? lastName;
  final String? phone;

  Member({
    this.id,
    this.firstName,
    this.lastName,
    this.phone,
  });

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      phone: json['phone'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'phone': phone,
    };
  }
}
