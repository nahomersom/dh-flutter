import 'package:bloc/bloc.dart';
import 'package:dh/model/task_model.dart';
import 'package:dh/repository/repositories.dart';
import 'package:meta/meta.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskRepository taskRepository = TaskRepository();
  TaskBloc({required this.taskRepository}) : super(TaskInitial()) {
    on<CreateTaskEvent>((event, emit) async {
      emit(CreateTaskLoading());
      try {
        await taskRepository.createTask(
            event.name,
            event.description,
            event.deadline,
            event.priority,
            event.status,
            event.groupId,
            event.assignedTo,
            event.monitoredBy);
        emit(CreateTaskSuccess());
      } catch (e) {
        emit(CreateTaskError(errorMessage: e.toString()));
      }
    });
    on<UpdateTaskByIdEvent>((event, emit) async {
      emit(UpdateTaskByIdLoading());
      try {
        await taskRepository.updateTask(
            event.taskId,
            event.name,
            event.description,
            event.deadline,
            event.priority,
            event.status,
            event.groupId,
            event.assignedTo,
            event.monitoredBy);
        emit(UpdateTaskByIdSuccess());
      } catch (e) {
        emit(UpdateTaskByIdError(errorMessage: e.toString()));
      }
    });
    on<GetAllTasks>((event, emit) async {
      emit(GetAllTasksLoading());
      try {
        await taskRepository.getAllTasks();
        emit(GetAllTasksSuccess());
      } catch (e) {
        emit(GetAllTasksError(errorMessage: e.toString()));
      }
    });
    on<GetTasksByGroupIdEvent>((event, emit) async {
      emit(GetTasksByGroupIdLoading());
      try {
        var res = await taskRepository.getTasksByGroupId(event.groupId);
        emit(GetTasksByGroupIdSuccess(tasks: res));
      } catch (e) {
        emit(GetTasksByGroupIdError(errorMessage: e.toString()));
      }
    });
    on<GetMyAssignedTasks>((event, emit) async {
      emit(GetMyAssignedTasksLoading());
      try {
       var res =  await taskRepository.getMyTasks();
        emit(GetMyAssignedTasksSuccess(tasks: res));
      } catch (e) {
        emit(GetMyAssignedTasksError(errorMessage: e.toString()));
      }
    });
    on<GetTasksICreated>((event, emit) async {
      emit(GetTasksICreatedLoading());
      try {
        var res = await taskRepository.getTasksIcreated();
        emit(GetTasksICreatedSuccess(tasks: res));
      } catch (e) {
        emit(GetTasksICreatedError(errorMessage: e.toString()));
      }
    });
    on<GetTaskByIdEvent>((event, emit) async {
      emit(GetTaskByIdLoading());
      try {
        var res = await taskRepository.getTaskById(event.taskId);
        emit(GetTaskByIdSuccess(task: res));
      } catch (e) {
        emit(GetTaskByIdError(errorMessage: e.toString()));
      }
    });
    on<AssignMemberTaskEvent>((event, emit) async {
      emit(AssignMemberTaskLoading());
      try {
        await taskRepository.assignMemberTask(event.taskId, event.memberId);
        emit(AssignMemberTaskSuccess());
      } catch (e) {
        emit(AssignMemberTaskError(errorMessage: e.toString()));
      }
    });
    on<RemoveTaskByIdEvent>((event, emit) async {
      emit(RemoveTaskByIdLoading());
      try {
        await taskRepository.removeTaskById(event.taskId);
        emit(RemoveTaskByIdSuccess());
      } catch (e) {
        emit(RemoveTaskByIdError(errorMessage: e.toString()));
      }
    });
    on<RemoveTaskAssignedFromUserEvent>((event, emit) async {
      emit(RemoveTaskAssignedFromUserLoading());
      try {
        await taskRepository.removeTaskAssignedFromUser(
            event.memberId, event.taskId);
        emit(RemoveTaskAssignedFromUserSuccess());
      } catch (e) {
        emit(RemoveTaskAssignedFromUserError(errorMessage: e.toString()));
      }
    });
  }
}
