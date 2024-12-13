import 'package:dh_flutter_v2/constants/constants.dart';
import 'package:dh_flutter_v2/model/task_model.dart';
import 'package:dh_flutter_v2/repository/repositories.dart';
import 'package:dh_flutter_v2/utils/utils.dart';
import 'package:dio/dio.dart';

class TaskRepository {
  AuthRepository authRepository = AuthRepository();

  Future createTask(
    String name,
    String description,
    String? deadline,
    String? priority,
    String? status,
    int groupId,
    List? assignedTo,
    int monitoredBy,
  ) async {
    logger("creat task ${await AuthRepository().getToken()} ", {
      "name": name,
      "desc": description,
      "deadline": deadline,
      "priority": priority,
      "status": status,
      "groupId": groupId,
      "assignedTo": assignedTo,
      "monitoredBy": monitoredBy,
    });
    Dio dio = Dio();
    dio.options.headers = await RequestHeader().authorisedHeader();

    try {
      Response response = await dio.post(EndPoints.tasks, data: {
        "name": name,
        "desc": description,
        "deadline": deadline,
        "priority": priority,
        "status": status,
        "groupId": groupId,
        "assignedTo": assignedTo,
        "monitoredBy": monitoredBy,
        // "name": "Generate Finance Report",
        // "desc": "Detailed Task Description",
        // "deadline": "2021-09-30T00:00:00.000Z",
        // "priority": "NoPriority",
        // "status": "Backlog",
        // "groupId": 11,
        // "assignedTo": [12],
        // "monitoredBy": 2
      }).timeout(AppConstants.timeout);
      if (response.statusCode == ApiResponse.requestSuccess ||
          response.statusCode == ApiResponse.requestCreated) {
        var output = response.data;
        logger("create task", output);
      }
    } catch (e) {
      print(e.toString());
      handleApiError(e);
    }
  }

  Future updateTask(
    int taskId,
    String name,
    String description,
    String? deadline,
    String? priority,
    String? status,
    int groupId,
    List assignedTo,
    int monitoredBy,
  ) async {
    logger("update task $name ", {});
    Dio dio = Dio();
    dio.options.headers = await RequestHeader().authorisedHeader();
    logger("", {
      "name": name,
      "desc": description,
      "deadline": deadline,
      "priority": priority,
      "status": status,
      "groupId": groupId,
      "assignedTo": assignedTo,
      "monitoredBy": monitoredBy,
    });
    try {
      Response response =
          await dio.patch('${EndPoints.updateTask}/$taskId', data: {
        "name": name,
        "desc": description,
        "deadline": deadline,
        "priority": priority,
        "status": status,
        "groupId": groupId,
        "assignedTo": assignedTo,
        "monitoredBy": monitoredBy,
      }).timeout(AppConstants.timeout);
      if (response.statusCode == ApiResponse.requestSuccess ||
          response.statusCode == ApiResponse.requestCreated) {
        var output = response.data;
        logger("update task", output);
      }
    } catch (e) {
      handleApiError(e);
    }
  }

  Future getMyTasks() async {
    Dio dio = Dio();
    logger("get my tasks", {});
    dio.options.headers = await RequestHeader().authorisedHeader();
    try {
      Response response = await dio
          .get(
            EndPoints.myTasks,
          )
          .timeout(AppConstants.timeout);
      if (response.statusCode == ApiResponse.requestSuccess ||
          response.statusCode == ApiResponse.requestCreated) {
        var output = response.data;
        logger("get my tasks", output);
        List<Task> tasks = [];

        for (var task in output["myAssigned"]) {
          tasks.add(Task.fromJson(task));
        }
        return tasks;
      }
    } catch (e) {
      handleApiError(e);
    }
  }

  Future getTasksByGroupId(int id) async {
    Dio dio = Dio();
    logger("get tasks by group id", {});
    logger("get tasks by group ${await AuthRepository().getToken()}", {});
    dio.options.headers = await RequestHeader().authorisedHeader();
    try {
      Response response = await dio
          .get(
            '${EndPoints.tasksGroup}/$id',
          )
          .timeout(AppConstants.timeout);
      if (response.statusCode == ApiResponse.requestSuccess ||
          response.statusCode == ApiResponse.requestCreated) {
        var output = response.data;
        logger("get tasks by group id", output);
        List<Task> tasks = [];
        for (var task in output["task"]) {
          tasks.add(Task.fromJson(task));
        }

        return tasks;
      }
    } catch (e) {
      handleApiError(e);
    }
  }

  Future getAllTasks() async {
    Dio dio = Dio();
    logger("get all tasks", {});
    dio.options.headers = await RequestHeader().authorisedHeader();
    try {
      Response response = await dio
          .get(
            EndPoints.tasks,
          )
          .timeout(AppConstants.timeout);
      if (response.statusCode == ApiResponse.requestSuccess ||
          response.statusCode == ApiResponse.requestCreated) {
        var output = response.data;
        logger("get all tasks", output);
        // List<Organization> invitations = [];
        // for (var invitation in output["invite"]) {
        //   invitations.add(Organization.fromJson(invitation));
        // }

        // return invitations;
      }
    } catch (e) {
      handleApiError(e);
    }
  }

  Future getTasksIcreated() async {
    Dio dio = Dio();
    logger("get tasks i created", {});
    dio.options.headers = await RequestHeader().authorisedHeader();
    try {
      Response response = await dio
          .get(
            EndPoints.getTasksICreated,
          )
          .timeout(AppConstants.timeout);
      if (response.statusCode == ApiResponse.requestSuccess ||
          response.statusCode == ApiResponse.requestCreated) {
        var output = response.data;
        logger("get tasks i created", output);
        List<Task> tasks = [];
        for (var task in output["tasks"]) {
          tasks.add(Task.fromJson(task));
        }

        return tasks;
      }
    } catch (e) {
      handleApiError(e);
    }
  }

  Future getTaskById(int id) async {
    Dio dio = Dio();
    logger("get task by id", {});
    dio.options.headers = await RequestHeader().authorisedHeader();
    try {
      Response response = await dio
          .get(
            '${EndPoints.tasks}/$id',
          )
          .timeout(AppConstants.timeout);
      if (response.statusCode == ApiResponse.requestSuccess ||
          response.statusCode == ApiResponse.requestCreated) {
        var output = response.data;
        logger("get task by id", output);
        Task task = Task.fromJson(output);

        return task;
      }
    } catch (e) {
      handleApiError(e);
    }
  }

  Future removeTaskById(int id) async {
    Dio dio = Dio();
    logger("remove task by id $id", {});
    dio.options.headers = await RequestHeader().authorisedHeader();
    try {
      Response response = await dio
          .delete(
            '${EndPoints.tasks}/$id',
          )
          .timeout(AppConstants.timeout);
      if (response.statusCode == ApiResponse.requestSuccess ||
          response.statusCode == ApiResponse.requestCreated) {
        var output = response.data;
        logger("remove task by id", output);
      }
    } catch (e) {
      handleApiError(e);
    }
  }

  Future removeTaskAssignedFromUser(int memberId, int taskId) async {
    Dio dio = Dio();
    logger("remove task by id", {});
    dio.options.headers = await RequestHeader().authorisedHeader();
    try {
      Response response = await dio
          .delete(
            '${EndPoints.tasks}/$taskId/assign/$memberId',
          )
          .timeout(AppConstants.timeout);
      if (response.statusCode == ApiResponse.requestSuccess ||
          response.statusCode == ApiResponse.requestCreated) {
        var output = response.data;
        logger("remove task by id", output);
      }
    } catch (e) {
      handleApiError(e);
    }
  }

  Future assignMemberTask(
    int taskId,
    int memberId,
  ) async {
    logger("assign member task $taskId ", {});
    Dio dio = Dio();
    dio.options.headers = await RequestHeader().authorisedHeader();

    try {
      Response response = await dio
          .post(
            '${EndPoints.assignTask}/$taskId/$memberId',
          )
          .timeout(AppConstants.timeout);
      if (response.statusCode == ApiResponse.requestSuccess ||
          response.statusCode == ApiResponse.requestCreated) {
        var output = response.data;
        logger("create task", output);
      }
    } catch (e) {
      handleApiError(e);
    }
  }
}
