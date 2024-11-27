class User {
  int? id;
  String? orgId;
  String? userName;
  String? firstName;
  String? middleName;
  String? lastName;
  String? email;
  String? phone;
  bool? isActive;
  bool? isVerified;
  String? profileImage;
  String? createdAt; // String instead of DateTime
  String? updatedAt; // String instead of DateTime
  String? otpCode;
  String? otpExpiresAt; // String instead of DateTime

  User({
    this.id,
    this.orgId,
    this.userName,
    this.firstName,
    this.middleName,
    this.lastName,
    this.email,
    this.phone,
    this.isActive,
    this.isVerified,
    this.profileImage,
    this.createdAt,
    this.updatedAt,
    this.otpCode,
    this.otpExpiresAt,
  });

  // Factory constructor to create a User instance from a JSON map
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      userName: json['userName'],
      firstName: json['firstName'],
      middleName: json['middleName'],
      lastName: json['lastName'],
      email: json['email'],
      phone: json['phone'],
      isActive: json['isActive'],
      isVerified: json['isVerified'],
      profileImage: json['profile'],
      createdAt: json['createdAt'], // As String
      updatedAt: json['updatedAt'], // As String
      otpCode: json['otpCode'],
      otpExpiresAt: json['otpExpiresAt'], // As String
    );
  }

  // Method to convert a User instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userName': userName,
      'firstName': firstName,
      'middleName': middleName,
      'lastName': lastName,
      'email': email,
      'phone': phone,
      'isActive': isActive,
      'isVerified': isVerified,
      'profile': profileImage,
      'createdAt': createdAt, // As String
      'updatedAt': updatedAt, // As String
      'otpCode': otpCode,
      'otpExpiresAt': otpExpiresAt, // As String
    };
  }

  factory User.fromStorage(Map<String, dynamic> json) {
    return User(
        id: json['id'] == "null" || json['id'] == null
            ? null
            : int.parse(json['id']),
        firstName: json['firstName'],
        lastName: json['lastName'],
        email: json['email'],
        phone: json['phone'],
        isActive: json['isActive'],
        profileImage: json['profile'],
        createdAt: json['createdAt'],
        updatedAt: json['updatedAt'],
        otpCode: json['otpCode'],
        orgId: json['orgId'],
        otpExpiresAt: json['otpExpiresAt']);
  }
}

class AuthResponse {
  final String accessToken;
  final User user;
  final bool isActive;

  AuthResponse({
    required this.accessToken,
    required this.user,
    required this.isActive,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      accessToken: json['accessToken'],
      user: User.fromJson(json['user']),
      isActive: json['isActive'],
    );
  }
}
