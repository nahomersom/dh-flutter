import 'package:dh_flutter_v2/constants/constants.dart';
import 'package:dh_flutter_v2/model/models.dart';
import 'package:dh_flutter_v2/repository/repositories.dart';
import 'package:dh_flutter_v2/utils/utils.dart';
import 'package:dio/dio.dart';

class OrganizationRepository {
  AuthRepository authRepository = AuthRepository();

  Future createOrganization(String name, int industryId, int regionId) async {
    logger("creat org $name $industryId $regionId", {});
    Dio dio = Dio();
    print(await authRepository.getToken());
    dio.options.headers = await RequestHeader().authorisedHeader();

    try {
      Response response = await dio.post(EndPoints.createOrganization, data: {
        "name": name,
        "industryId": industryId,
        "regionId": regionId
      }).timeout(AppConstants.timeout);
      if (response.statusCode == ApiResponse.requestSuccess ||
          response.statusCode == ApiResponse.requestCreated) {
        var output = response.data;
        logger("", output);
      }
    } catch (e) {
      handleApiError(e);
    }
  }

  Future createInvitation(int orgId) async {
    Dio dio = Dio();
    logger("create org", {});
    dio.options.headers = await RequestHeader().authorisedHeader();
    try {
      Response response = await dio
          .post(
            '${EndPoints.orgInvite}/$orgId',
          )
          .timeout(AppConstants.timeout);
      if (response.statusCode == ApiResponse.requestSuccess ||
          response.statusCode == ApiResponse.requestCreated) {
        var output = response.data;
        logger("create invite", output);
      }
    } catch (e) {
      handleApiError(e);
    }
  }

  Future getMyOrgInvites() async {
    Dio dio = Dio();
    logger("get org invites", {});
    dio.options.headers = await RequestHeader().authorisedHeader();
    try {
      Response response = await dio
          .get(
            EndPoints.getMyOrgInvite,
          )
          .timeout(AppConstants.timeout);
      if (response.statusCode == ApiResponse.requestSuccess ||
          response.statusCode == ApiResponse.requestCreated) {
        var output = response.data;
        logger("get org invites", output);
        List<Organization> invitations = [];
        for (var invitation in output["invite"]) {
          invitations.add(Organization.fromJson(invitation));
        }

        return invitations;
      }
    } catch (e) {
      handleApiError(e);
    }
  }

  Future getOrgInvites(int orgId) async {
    Dio dio = Dio();
    logger("get org invites", {});
    dio.options.headers = await RequestHeader().authorisedHeader();
    try {
      Response response = await dio
          .get(
            '${EndPoints.orgInvite}/$orgId',
          )
          .timeout(AppConstants.timeout);
      if (response.statusCode == ApiResponse.requestSuccess ||
          response.statusCode == ApiResponse.requestCreated) {
        var output = response.data;
        logger("get org invites", output);
        List<Organization> invitations = [];
        for (var invitation in output) {
          invitations.add(Organization.fromJson(invitation));
        }

        return invitations;
      }
    } catch (e) {
      handleApiError(e);
    }
  }

  Future changeInvitationRequestStatus(String status, int id) async {
    Dio dio = Dio();
    dio.options.headers = await RequestHeader().authorisedHeader();
    try {
      logger("$id $status", {});
      Response response = await dio.patch('${EndPoints.orgInvite}/$id',
          data: {"status": status}).timeout(AppConstants.timeout);
      if (response.statusCode == ApiResponse.requestSuccess ||
          response.statusCode == ApiResponse.requestCreated) {
        var output = response.data;
        logger("", output);
      }
    } catch (e) {
      handleApiError(e);
    }
  }

  Future searchOrganizations(String value) async {
    Dio dio = Dio();
    dio.options.headers = await RequestHeader().authorisedHeader();
    try {
      Response response = await dio
          .get(
            '${EndPoints.searchOrganization}/?search=$value',
          )
          .timeout(AppConstants.timeout);
      if (response.statusCode == ApiResponse.requestSuccess ||
          response.statusCode == ApiResponse.requestCreated) {
        var output = response.data;
        logger("orgs", response.data);
        List<Organization> organizations = [];
        for (var org in output) {
          organizations.add(Organization.fromJson(org));
        }
        return organizations;
      }
    } catch (e) {
      handleApiError(e);
    }
  }

  Future getAllOrganizationMembers(int orgId) async {
    Dio dio = Dio();
    dio.options.headers = await RequestHeader().authorisedHeader();
    try {
      logger("org members ${EndPoints.orgMember}/$orgId", {});
      Response response = await dio
          .get(
            '${EndPoints.orgMember}/$orgId',
          )
          .timeout(AppConstants.timeout);
      if (response.statusCode == ApiResponse.requestSuccess ||
          response.statusCode == ApiResponse.requestCreated) {
        var output = response.data["orgMembers"]["members"];
        logger("all members", response.data);
        List<MemberDetails> members = [];
        for (var member in output) {
          members.add(MemberDetails.fromJson(member));
        }
        return members;
      }
    } catch (e) {
      handleApiError(e);
    }
  }

  Future addMember(int orgId, int memberId, String role) async {
    Dio dio = Dio();
    dio.options.headers = await RequestHeader().authorisedHeader();
    try {
      logger("add members req $memberId", {});
      Response response = await dio.post(EndPoints.orgMember, data: {
        "orgId": orgId,
        "memberId": memberId,
        "role": role
      }).timeout(AppConstants.timeout);
      if (response.statusCode == ApiResponse.requestSuccess ||
          response.statusCode == ApiResponse.requestCreated) {
        // var output = response.data;
        logger("add member", response.data);
      }
    } catch (e) {
      handleApiError(e);
    }
  }

  Future removeMemberByOrgIdAndMemberId(int orgId, int memberId) async {
    Dio dio = Dio();
    dio.options.headers = await RequestHeader().authorisedHeader();
    try {
      logger("removeMemberByOrgIdAndMemberId req $memberId", {});
      Response response = await dio
          .delete(
            '${EndPoints.orgMember}/$orgId/$memberId',
          )
          .timeout(AppConstants.timeout);
      if (response.statusCode == ApiResponse.requestSuccess ||
          response.statusCode == ApiResponse.requestCreated) {
        // var output = response.data;
        logger("removeMemberByOrgIdAndMemberId", response.data);
      }
    } catch (e) {
      handleApiError(e);
    }
  }

  Future getMyOrganizations() async {
    logger("my org req", {});
    Dio dio = Dio();
    dio.options.headers = await RequestHeader().authorisedHeader();
    try {
      Response response = await dio
          .get(
            EndPoints.getMyOrganizations,
          )
          .timeout(AppConstants.timeout);
      if (response.statusCode == ApiResponse.requestSuccess ||
          response.statusCode == ApiResponse.requestCreated) {
        var output = response.data;
        logger("my org", response.data);
        List<Organization> organizations = [];
        for (var org in output) {
          organizations.add(Organization.fromJson(org));
        }
        return organizations;
      }
    } catch (e) {
      handleApiError(e);
    }
  }

  Future getIndustries() async {
    Dio dio = Dio();
    dio.options.headers = await RequestHeader().authorisedHeader();
    try {
      Response response = await dio
          .get(
            EndPoints.getIndustries,
          )
          .timeout(AppConstants.timeout);
      if (response.statusCode == ApiResponse.requestSuccess ||
          response.statusCode == ApiResponse.requestCreated) {
        var output = response.data;
        List industries = [];
        logger("orgs", output);
        for (var industry in output) {
          industries.add(industry);
        }
        return industries;
      }
    } catch (e) {
      handleApiError(e);
    }
  }

  Future getRegions() async {
    Dio dio = Dio();
    dio.options.headers = await RequestHeader().authorisedHeader();
    try {
      Response response = await dio
          .get(
            EndPoints.getRegions,
          )
          .timeout(AppConstants.timeout);
      if (response.statusCode == ApiResponse.requestSuccess ||
          response.statusCode == ApiResponse.requestCreated) {
        var output = response.data;
        List regions = [];
        for (var region in output) {
          regions.add(region);
        }
        logger("regions", output);

        return regions;
      }
    } catch (e) {
      handleApiError(e);
    }
  }
}
