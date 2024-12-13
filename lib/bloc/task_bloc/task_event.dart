part of 'task_bloc.dart';

@immutable
abstract class TaskEvent {}

class CreateTaskEvent extends TaskEvent {
  final String name;
  final String description;
  final String? deadline;
  final String? priority;
  final String? status;
  final int groupId;
  final List? assignedTo;
  final int monitoredBy;

  CreateTaskEvent({
    required this.name,
    required this.description,
    required this.deadline,
    required this.assignedTo,
    required this.groupId,
    required this.monitoredBy,
    required this.priority,
    required this.status,
  });
}

class GetAllTasks extends TaskEvent {
  GetAllTasks();
}

class AssignMemberTaskEvent extends TaskEvent {
  final int taskId;
  final int memberId;
  AssignMemberTaskEvent({required this.memberId, required this.taskId});
}

class GetTaskByIdEvent extends TaskEvent {
  final int taskId;
  GetTaskByIdEvent({required this.taskId});
}

class GetTasksByGroupIdEvent extends TaskEvent {
  final int groupId;
  GetTasksByGroupIdEvent({required this.groupId});
}

class RemoveTaskByIdEvent extends TaskEvent {
  final int taskId;
  RemoveTaskByIdEvent({required this.taskId});
}

class RemoveTaskAssignedFromUserEvent extends TaskEvent {
  final int taskId;
  final int memberId;
  RemoveTaskAssignedFromUserEvent(
      {required this.taskId, required this.memberId});
}

class UpdateTaskByIdEvent extends TaskEvent {
  final int taskId;
  final String name;
  final String description;
  final String? deadline;
  final String? priority;
  final String? status;
  final int groupId;
  final List assignedTo;
  final int monitoredBy;

  UpdateTaskByIdEvent(
      {required this.name,
      required this.taskId,
      required this.description,
      required this.deadline,
      required this.assignedTo,
      required this.groupId,
      required this.monitoredBy,
      required this.priority,
      required this.status});
}

class GetMyAssignedTasks extends TaskEvent {
  GetMyAssignedTasks();
}

class GetTasksICreated extends TaskEvent {
  GetTasksICreated();
}
