class MessageModel {
  String id;
  String body;
  String senderId;
  String? senderName;
  String receiverId;
  String? receiverName;
  bool isSeen;
  List<dynamic> attachments;
  String createdBy;
  DateTime createdAt;

  MessageModel({
    required this.id,
    required this.body,
    required this.senderId,
    this.senderName,
    required this.receiverId,
    this.receiverName,
    required this.isSeen,
    required this.attachments,
    required this.createdBy,
    required this.createdAt,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id'],
      body: json['body'],
      senderId: json['senderId'],
      senderName: json['senderName'],
      receiverId: json['receiverId'],
      receiverName: json['receiverName'],
      isSeen: json['isSeen'],
      attachments: json['attachments'],
      createdBy: json['createdBy'],
      createdAt: DateTime.parse(json['createdAt']).toLocal(),
    );
  }
}
