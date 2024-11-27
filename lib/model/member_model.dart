class MemberDetails {
  final int? orgId;
  final int? memberId;
  final String? role;
  final String? createdAt;
  final String? updatedAt;
  final Member? member;

  MemberDetails({
    this.orgId,
    this.memberId,
    this.role,
    this.createdAt,
    this.updatedAt,
    this.member,
  });

  factory MemberDetails.fromJson(Map<String, dynamic> json) {
    return MemberDetails(
      orgId: json['orgId'],
      memberId: json['memberId'],
      role: json['role'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      member: Member.fromJson(json['member']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'orgId': orgId,
      'memberId': memberId,
      'role': role,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'member': member?.toJson(),
    };
  }
}


class Member {
  final String? firstName;
  final String? lastName;
  final String? phone;

  Member({
    this.firstName,
    this.lastName,
    this.phone,
  });

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      firstName: json['firstName'],
      lastName: json['lastName'],
      phone: json['phone'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'phone': phone,
    };
  }
}
