part of 'organization_bloc.dart';

@immutable
abstract class OrganizationEvent {}

class CreateOrganizationEvent extends OrganizationEvent {
  // final String phoneNumber;
  final String name;
  final int industryId;
  final int regionId;
  // final String email;
  CreateOrganizationEvent(this.name, this.industryId, this.regionId);
}

class CreateOrgInviteEvent extends OrganizationEvent {
  final int orgId;

  CreateOrgInviteEvent(this.orgId);
}

class GetOrgInvitesEvent extends OrganizationEvent {
  final int orgId;

  GetOrgInvitesEvent(this.orgId);
}

class GetMyOrgInvitesEvent extends OrganizationEvent {
  GetMyOrgInvitesEvent();
}

class ChangeRequestStatusEvent extends OrganizationEvent {
  final int id;
  final String status;

  ChangeRequestStatusEvent({required this.id, required this.status});
}

class SearchOrganizationEvent extends OrganizationEvent {
  final String value;
  SearchOrganizationEvent(this.value);
}

class GetAllOrganizationMembersEvent extends OrganizationEvent {
  final int orgId;
  GetAllOrganizationMembersEvent({required this.orgId});
}

class AddMemberEvent extends OrganizationEvent {
  final int orgId;
  final int memberId;
  final String role;
  AddMemberEvent(
      {required this.orgId, required this.memberId, required this.role});
}

class RemoveMemberByOrgIdAndMemberIdEvent extends OrganizationEvent {
  final int orgId;
  final int memberId;

  RemoveMemberByOrgIdAndMemberIdEvent(
      {required this.orgId, required this.memberId});
}

class GetMyOrganizationsEvent extends OrganizationEvent {
  GetMyOrganizationsEvent();
}

class GetIndustriesEvent extends OrganizationEvent {
  GetIndustriesEvent();
}
