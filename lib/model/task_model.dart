class Task {
  int? id;
  String? name;
  String? desc;
  String? deadline;
  String? priority;
  String? status;
  int? groupId;
  int? monitoredBy;
  int? createdBy;
  String? createdAt;
  String? updatedAt;
  bool? isEditing;
  List<TaskAssignee>? taskAssignee;

  Task({
    this.id,
    this.name,
    this.desc,
    this.deadline,
    this.priority,
    this.isEditing,
    this.status,
    this.groupId,
    this.monitoredBy,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
    this.taskAssignee,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      name: json['name'],
      desc: json['desc'] ?? '',
      deadline: json['deadline'],
      priority: json['priority'],
      status: json['status'],
      groupId: json['groupId'],
      monitoredBy: json['monitoredBy'],
      createdBy: json['createdBy'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      taskAssignee: (json['TaskAsignee'] as List)
          .map((assignee) => TaskAssignee.fromJson(assignee))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'desc': desc,
      'deadline': deadline,
      'priority': priority,
      'status': status,
      'groupId': groupId,
      'monitoredBy': monitoredBy,
      'createdBy': createdBy,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'TaskAsignee':
          taskAssignee?.map((assignee) => assignee.toJson()).toList(),
    };
  }
}

class TaskAssignee {
  int? memberId;
  Member? member;

  TaskAssignee({
    this.memberId,
    this.member,
  });

  factory TaskAssignee.fromJson(Map<String, dynamic> json) {
    return TaskAssignee(
      memberId: json['memberId'],
      member: json['member'] == null ? null : Member.fromJson(json['member']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'memberId': memberId,
      'member': member?.toJson(),
    };
  }
}

class Member {
  String? firstName;
  String? lastName;
  String? phone;

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
