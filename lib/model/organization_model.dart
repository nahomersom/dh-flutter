class Organization {
  final int? id;
  final String? name;
  final int? ownerId;
  final int? industryId;
  final int? regionId;
  final String? logo;
  final String? createdAt;
  final String? updatedAt;
  final Industry? industry;
  final Region? region;
  final List<Invite>? invites;

  Organization({
    this.id,
    this.name,
    this.ownerId,
    this.industryId,
    this.regionId,
    this.logo,
    this.createdAt,
    this.updatedAt,
    this.industry,
    this.region,
    this.invites,
  });

  factory Organization.fromJson(Map<String, dynamic> json) {
    return Organization(
      id: json['id'],
      name: json['name'],
      ownerId: json['ownerId'],
      industryId: json['industryId'],
      regionId: json['regionId'],
      logo: json['logo'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      industry: json['industry'] == null
          ? null
          : Industry.fromJson(json['industry']),
      region: json['region'] == null
          ? null
          : Region.fromJson(json['region']),
      invites: json['invites'] == null
          ? null
          : List<Invite>.from(json['invites'].map((x) => Invite.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'ownerId': ownerId,
      'industryId': industryId,
      'regionId': regionId,
      'logo': logo,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'industry': industry?.toJson(),
      'region': region?.toJson(),
      'invites': invites?.map((x) => x.toJson()).toList(),
    };
  }
}

class Industry {
  final String name;
  final bool isActive;

  Industry({
    required this.name,
    required this.isActive,
  });

  factory Industry.fromJson(Map<String, dynamic> json) {
    return Industry(
      name: json['name'],
      isActive: json['isActive'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'isActive': isActive,
    };
  }
}

class Region {
  final String name;
  final bool isActive;

  Region({
    required this.name,
    required this.isActive,
  });

  factory Region.fromJson(Map<String, dynamic> json) {
    return Region(
      name: json['name'],
      isActive: json['isActive'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'isActive': isActive,
    };
  }
}

class Invite {
  final int? id;
  final int? orgId;
  final int? ownerId;
  final int? inviteeId;
  final String? status;
  final String? createdAt;
  final String? updatedAt;
  final Invitee? invitee;

  Invite({
    this.id,
    this.orgId,
    this.ownerId,
    this.inviteeId,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.invitee,
  });

  factory Invite.fromJson(Map<String, dynamic> json) {
    return Invite(
      id: json['id'],
      orgId: json['orgId'],
      ownerId: json['ownerId'],
      inviteeId: json['inviteeId'],
      status: json['status'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      invitee: Invitee.fromJson(json['invitee']),
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
  final String? firstName;
  final String? lastName;
  final String? phone;

  Invitee({
    this.firstName,
    this.lastName,
    this.phone,
  });

  factory Invitee.fromJson(Map<String, dynamic> json) {
    return Invitee(
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
