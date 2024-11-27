part of 'organization_bloc.dart';

@immutable
abstract class OrganizationState {}

final class OrganizationInitial extends OrganizationState {}

class CreateOrganizationLoading extends OrganizationState {}

class CreateOrganizationSuccess extends OrganizationState {
  CreateOrganizationSuccess();
}

class CreateOrganizationFailure extends OrganizationState {
  final String errorMessage;
  CreateOrganizationFailure(this.errorMessage);
}

class CreateOrgInviteLoading extends OrganizationState {}

class CreateOrgInviteSuccess extends OrganizationState {
  CreateOrgInviteSuccess();
}

class CreateOrgInviteFailure extends OrganizationState {
  final String errorMessage;
  CreateOrgInviteFailure(this.errorMessage);
}

class GetOrgInvitesLoading extends OrganizationState {}

class GetOrgInvitesSuccess extends OrganizationState {
  final List<InviteDetails> invitations;
  GetOrgInvitesSuccess({required this.invitations});
}

class GetOrgInvitesFailure extends OrganizationState {
  final String errorMessage;
  GetOrgInvitesFailure(this.errorMessage);
}

class GetMyOrgInvitesLoading extends OrganizationState {}

class GetMyOrgInvitesSuccess extends OrganizationState {
  final List<Organization> invitations;
  GetMyOrgInvitesSuccess({required this.invitations});
}

class GetMyOrgInvitesFailure extends OrganizationState {
  final String errorMessage;
  GetMyOrgInvitesFailure(this.errorMessage);
}

class ChangeRequestStatusLoading extends OrganizationState {}

class ChangeRequestStatusSuccess extends OrganizationState {
  ChangeRequestStatusSuccess();
}

class ChangeRequestStatusFailure extends OrganizationState {
  final String errorMessage;
  ChangeRequestStatusFailure(this.errorMessage);
}

class SearchOrganizationLoading extends OrganizationState {}

class SearchOrganizationSuccess extends OrganizationState {
  final List<Organization> organizations;
  SearchOrganizationSuccess({required this.organizations});
}

class SearchOrganizationFailure extends OrganizationState {
  final String errorMessage;
  SearchOrganizationFailure(this.errorMessage);
}

class GetAllOrganizationMembersLoading extends OrganizationState {}

class GetAllOrganizationMembersSuccess extends OrganizationState {
  final List<MemberDetails> members;
  GetAllOrganizationMembersSuccess({required this.members});
}

class GetAllOrganizationMembersFailure extends OrganizationState {
  final String errorMessage;
  GetAllOrganizationMembersFailure(this.errorMessage);
}

class GetMyOrganizationsLoading extends OrganizationState {}

class GetMyOrganizationsSuccess extends OrganizationState {
  final List<Organization> organizations;
  GetMyOrganizationsSuccess({required this.organizations});
}

class GetMyOrganizationsFailure extends OrganizationState {
  final String errorMessage;
  GetMyOrganizationsFailure(this.errorMessage);
}

class AddMemberLoading extends OrganizationState {}

class AddMemberSuccess extends OrganizationState {
  AddMemberSuccess();
}

class AddMemberFailure extends OrganizationState {
  final String errorMessage;
  AddMemberFailure(this.errorMessage);
}
class RemoveMemberByOrgIdAndMemberIdLoading extends OrganizationState {}

class RemoveMemberByOrgIdAndMemberIdSuccess extends OrganizationState {
  RemoveMemberByOrgIdAndMemberIdSuccess();
}

class RemoveMemberByOrgIdAndMemberIdFailure extends OrganizationState {
  final String errorMessage;
  RemoveMemberByOrgIdAndMemberIdFailure(this.errorMessage);
}

class GetIndustriesLoading extends OrganizationState {}

class GetIndustriesSuccess extends OrganizationState {
  final List industries;
  final List regions;

  GetIndustriesSuccess({required this.industries, required this.regions});
}

class GetIndustriesFailure extends OrganizationState {
  final String errorMessage;
  GetIndustriesFailure(this.errorMessage);
}
