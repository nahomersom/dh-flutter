import 'package:dh/model/models.dart';

class NotificationModel {
  int? id;
  String? title;
  String? body;
  String? icon;
  int? userId;
  bool? isSeen;
  String? createdAt;
  String? updatedAt;
  User? user;

  NotificationModel({
    this.id,
    this.title,
    this.body,
    this.icon,
    this.userId,
    this.isSeen,
    this.createdAt,
    this.updatedAt,
    this.user,
  });

  // Factory constructor to parse JSON
  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'],
      title: json['title'],
      body: json['body'],
      icon: json['icon'],
      userId: json['userId'],
      isSeen: json['is_seen'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      user: json['user'] == null ? null : User.fromJson(json['user']),
    );
  }
}
