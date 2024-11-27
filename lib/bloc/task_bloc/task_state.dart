part of 'task_bloc.dart';

@immutable
sealed class TaskState {}

final class TaskInitial extends TaskState {}

final class CreateTaskLoading extends TaskState {}

final class CreateTaskSuccess extends TaskState {}

final class CreateTaskError extends TaskState {
  final String errorMessage;
  CreateTaskError({required this.errorMessage});
}

final class GetAllTasksLoading extends TaskState {}

final class GetAllTasksSuccess extends TaskState {}

final class GetAllTasksError extends TaskState {
  final String errorMessage;
  GetAllTasksError({required this.errorMessage});
}

final class GetTasksByGroupIdLoading extends TaskState {}

final class GetTasksByGroupIdSuccess extends TaskState {
  final List<Task> tasks;
  GetTasksByGroupIdSuccess({required this.tasks});
}

final class GetTasksByGroupIdError extends TaskState {
  final String errorMessage;
  GetTasksByGroupIdError({required this.errorMessage});
}

final class AssignMemberTaskLoading extends TaskState {}

final class AssignMemberTaskSuccess extends TaskState {}

final class AssignMemberTaskError extends TaskState {
  final String errorMessage;
  AssignMemberTaskError({required this.errorMessage});
}

final class GetTaskByIdLoading extends TaskState {}

final class GetTaskByIdSuccess extends TaskState {
  final Task task;
  GetTaskByIdSuccess({required this.task});
}

final class GetTaskByIdError extends TaskState {
  final String errorMessage;
  GetTaskByIdError({required this.errorMessage});
}

final class RemoveTaskByIdLoading extends TaskState {}

final class RemoveTaskByIdSuccess extends TaskState {}

final class RemoveTaskByIdError extends TaskState {
  final String errorMessage;
  RemoveTaskByIdError({required this.errorMessage});
}

final class GetMyAssignedTasksLoading extends TaskState {}

final class GetMyAssignedTasksSuccess extends TaskState {
  final List<Task> tasks;
  GetMyAssignedTasksSuccess({required this.tasks});
}

final class GetMyAssignedTasksError extends TaskState {
  final String errorMessage;
  GetMyAssignedTasksError({required this.errorMessage});
}

final class GetTasksICreatedLoading extends TaskState {}

final class GetTasksICreatedSuccess extends TaskState {
  final List<Task> tasks;
  GetTasksICreatedSuccess({required this.tasks});
}

final class GetTasksICreatedError extends TaskState {
  final String errorMessage;
  GetTasksICreatedError({required this.errorMessage});
}

final class UpdateTaskByIdLoading extends TaskState {}

final class UpdateTaskByIdSuccess extends TaskState {}

final class UpdateTaskByIdError extends TaskState {
  final String errorMessage;
  UpdateTaskByIdError({required this.errorMessage});
}

final class RemoveTaskAssignedFromUserLoading extends TaskState {}

final class RemoveTaskAssignedFromUserSuccess extends TaskState {}

final class RemoveTaskAssignedFromUserError extends TaskState {
  final String errorMessage;
  RemoveTaskAssignedFromUserError({required this.errorMessage});
}
