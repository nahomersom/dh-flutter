class ChatModel {
  String? id;
  String? name;
  String? email;
  String? phoneNumber;
  String? type;
  bool? isActive;
  bool? isOnline;
  String? gender;
  dynamic address;
  dynamic profileImage;
  String? planTypeId;
  int? planTypeDuration;
  bool? verified;
  bool? notifyMe;
  bool? isPaid;
  String? fcmId;
  String? createdBy;
  String? updatedBy;
  String? deletedBy;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? latestMessage;
  String? latestSender;
  String? latestMessageDate;
  int? numberOfUnseenChats;
  List? kids;
  ChatModel({
    this.id,
    this.name,
    this.email,
    this.phoneNumber,
    this.type,
    this.isActive,
    this.isOnline,
    this.gender,
    this.address,
    this.profileImage,
    this.planTypeId,
    this.planTypeDuration,
    this.verified,
    this.notifyMe,
    this.isPaid,
    this.fcmId,
    this.createdBy,
    this.updatedBy,
    this.deletedBy,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.latestMessage,
    this.latestSender,
    this.kids,
    this.numberOfUnseenChats,
    this.latestMessageDate,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      type: json['type'],
      isActive: json['isActive'],
      isOnline: json['isOnline'],
      gender: json['gender'],
      address: json['address'],
      profileImage: json['profileImage'],
      planTypeId: json['planTypeId'],
      planTypeDuration: json['planTypeDuration'],
      verified: json['verified'],
      notifyMe: json['notifyMe'],
      isPaid: json['isPaid'],
      fcmId: json['fcmId'],
      createdBy: json['createdBy'],
      updatedBy: json['updatedBy'],
      deletedBy: json['deletedBy'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      deletedAt: json['deletedAt'],
      latestMessageDate: json['latestMessageDate'],
      latestMessage: json['latestMessage'],
      latestSender: json['latestSender'],
      numberOfUnseenChats: json['numberOfUnseenChats'],
      kids: json['kids'],
    );
  }
}
