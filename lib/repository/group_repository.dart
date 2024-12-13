import 'package:dh_flutter_v2/constants/constants.dart';
import 'package:dh_flutter_v2/model/group_model.dart';
import 'package:dh_flutter_v2/repository/repositories.dart';
import 'package:dh_flutter_v2/utils/utils.dart';
import 'package:dio/dio.dart';

class GroupRepository {
  AuthRepository authRepository = AuthRepository();

  Future createGroup(String name, int? orgId, String color) async {
    logger("create group $orgId ", {});
    Dio dio = Dio();
    dio.options.headers = await RequestHeader().authorisedHeader();

    try {
      Response response = await dio.post(EndPoints.orgGroup, data: {
        "name": name,
        "color": color,
        "orgId": orgId,
      }).timeout(AppConstants.timeout);
      if (response.statusCode == ApiResponse.requestSuccess ||
          response.statusCode == ApiResponse.requestCreated) {
        var output = response.data;
        logger("create group", output);
      }
    } catch (e) {
      if (e is DioException &&
          e.response != null &&
          e.response!.statusCode == ApiResponse.unAuthorized) {
        await authRepository.refreshToken();
        return createGroup(name, orgId, color);
      } else {
        handleApiError(e);
      }
    }
  }

  Future updateGroup(String name, int groupId) async {
    logger("update group'${EndPoints.orgGroup}/$groupId' $name ", {});
    Dio dio = Dio();
    dio.options.headers = await RequestHeader().authorisedHeader();

    try {
      Response response =
          await dio.patch('${EndPoints.orgGroup}/$groupId', data: {
        "name": name,
      }).timeout(AppConstants.timeout);
      if (response.statusCode == ApiResponse.requestSuccess ||
          response.statusCode == ApiResponse.requestCreated) {
        var output = response.data;
        logger("update group", output);
      }
    } catch (e) {
      handleApiError(e);
    }
  }

  Future getGroupById(int id) async {
    Dio dio = Dio();
    logger("get group by id", {});
    dio.options.headers = await RequestHeader().authorisedHeader();
    try {
      Response response = await dio
          .get(
            '${EndPoints.orgGroup}/$id',
          )
          .timeout(AppConstants.timeout);
      if (response.statusCode == ApiResponse.requestSuccess ||
          response.statusCode == ApiResponse.requestCreated) {
        var output = response.data;
        Group group = Group.fromJson(output["group"]);
        logger("get group by id", output);
        return group;
      }
    } catch (e) {
      handleApiError(e);
    }
  }

  Future getMyGroups() async {
    Dio dio = Dio();
    logger("get my groups", {});
    dio.options.headers = await RequestHeader().authorisedHeader();
    try {
      Response response = await dio
          .get(
            EndPoints.getMyOrgGroups,
          )
          .timeout(AppConstants.timeout);
      if (response.statusCode == ApiResponse.requestSuccess ||
          response.statusCode == ApiResponse.requestCreated) {
        var output = response.data;
        logger("get my groups", output);

        List<Group> groups = [];
        for (var group in output["groups"]["groups"] ?? []) {
          groups.add(Group.fromJson(group));
        }
        for (var group in output["groups"]["myGroups"] ?? []) {
          groups.add(Group.fromJson(group));
        }
        // print(groups);
        // List<Map<String, dynamic>> groupsList = [];
        // for (var org in output["groups"]) {
        //   logger("get my groups", org["groups"]);
        //   for (var group in org["groups"]) {
        //     groups.add(Group.fromJson(group));
        //   }
        // }

        logger("get my groups22", groups);
        return groups;
      }
    } catch (e) {
      handleApiError(e);
    }
  }

  Future getMyPersonalGroups() async {
    Dio dio = Dio();
    logger("get my personal groups", {});
    dio.options.headers = await RequestHeader().authorisedHeader();
    try {
      Response response = await dio
          .get(
            EndPoints.getMyPersonalGroups,
          )
          .timeout(AppConstants.timeout);
      if (response.statusCode == ApiResponse.requestSuccess ||
          response.statusCode == ApiResponse.requestCreated) {
        var output = response.data;
        logger("get my personal groups", output);

        List<Group> groups = [];
        for (var group in output["mygroups"]["myPersonalGroups"] ?? []) {
          groups.add(Group.fromJson(group));
        }
        // for (var group in output["groups"]["myGroups"] ?? []) {
        //   groups.add(Group.fromJson(group));
        // }

        logger("get my groups22", groups);
        return groups;
      }
    } catch (e) {
      handleApiError(e);
    }
  }

  Future getOrganizationGroups(int orgId) async {
    Dio dio = Dio();
    logger("get org groups '${EndPoints.orgGroup}/$orgId'", {});
    dio.options.headers = await RequestHeader().authorisedHeader();
    try {
      Response response = await dio
          .get(
            '${EndPoints.orgGroup}/org/$orgId',
          )
          .timeout(AppConstants.timeout);
      if (response.statusCode == ApiResponse.requestSuccess ||
          response.statusCode == ApiResponse.requestCreated) {
        var output = response.data;
        List<Group> groups = [];
        logger("get org groups ", output["orgGroups"]["groups"]);
        for (var group in output["orgGroups"]["groups"] ?? []) {
          groups.add(Group.fromJson(group));
        }
        return groups;
      }
    } catch (e) {
      handleApiError(e);
    }
  }

  Future deleteGroup(int id) async {
    Dio dio = Dio();
    logger("delete group $id", {});
    dio.options.headers = await RequestHeader().authorisedHeader();
    try {
      Response response = await dio
          .delete(
            '${EndPoints.orgGroup}/$id',
          )
          .timeout(AppConstants.timeout);
      if (response.statusCode == ApiResponse.requestSuccess ||
          response.statusCode == ApiResponse.requestCreated) {
        var output = response.data;
        logger("delete group", output);
      }
    } catch (e) {
      handleApiError(e);
    }
  }

  Future addOrgMemberToGroup(int groupId, int memberId) async {
    Dio dio = Dio();
    logger("addOrgMemberToGroup $groupId $memberId", {});
    dio.options.headers = await RequestHeader().authorisedHeader();
    try {
      Response response = await dio.post(EndPoints.orgGroupMembers, data: {
        "groupId": groupId,
        "memberId": memberId
      }).timeout(AppConstants.timeout);
      if (response.statusCode == ApiResponse.requestSuccess ||
          response.statusCode == ApiResponse.requestCreated) {
        var output = response.data;
        logger("addOrgMemberToGroup", output);
      }
    } catch (e) {
      handleApiError(e);
    }
  }

  Future removeMemberFromOrgGroup(int groupId, int memberId) async {
    Dio dio = Dio();
    logger("removeMemberFromOrgGroup $groupId/$memberId", {});
    dio.options.headers = await RequestHeader().authorisedHeader();
    try {
      Response response = await dio
          .delete(
            '${EndPoints.orgGroupMembers}/$groupId/$memberId',
          )
          .timeout(AppConstants.timeout);
      if (response.statusCode == ApiResponse.requestSuccess ||
          response.statusCode == ApiResponse.requestCreated) {
        var output = response.data;
        logger("removeMemberFromOrgGroup", output);
      }
    } catch (e) {
      handleApiError(e);
    }
  }
}
