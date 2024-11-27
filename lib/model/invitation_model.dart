class InviteDetails {
  final int? id;
  final int? orgId;
  final int? ownerId;
  final int? inviteeId;
  final String? status;
  final String? createdAt;
  final String? updatedAt;
  final Invitee? invitee;

  InviteDetails({
    this.id,
    this.orgId,
    this.ownerId,
    this.inviteeId,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.invitee,
  });

  factory InviteDetails.fromJson(Map<String, dynamic> json) {
    return InviteDetails(
      id: json['id'],
      orgId: json['orgId'],
      ownerId: json['ownerId'],
      inviteeId: json['inviteeId'],
      status: json['status'] ?? "",
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      invitee:
          json['invitee'] == null ? null : Invitee.fromJson(json['invitee']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orgId': orgId,
      'ownerId': ownerId,
      'inviteeId': inviteeId,
      'status': status,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'invitee': invitee?.toJson(),
    };
  }
}

class Invitee {
  final int? id;
  final String? firstName;
  final String? lastName;
  final String? phone;

  Invitee({
    this.id,
    this.firstName,
    this.lastName,
    this.phone,
  });

  factory Invitee.fromJson(Map<String, dynamic> json) {
    return Invitee(
      id: json['id'],
      firstName: json['firstName'] ?? "",
      lastName: json['lastName'] ?? "",
      phone: json['phone'] ?? "",
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
