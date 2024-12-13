part of 'groups_bloc.dart';

@immutable
sealed class GroupsState {}

final class GroupsInitial extends GroupsState {}

final class CreateGroupLoading extends GroupsState {}

final class CreateGroupSuccess extends GroupsState {}

final class CreateGroupError extends GroupsState {
  final String errorMessage;
  CreateGroupError({required this.errorMessage});
}

final class UpdateGroupLoading extends GroupsState {}

final class UpdateGroupSuccess extends GroupsState {}

final class UpdateGroupError extends GroupsState {
  final String errorMessage;
  UpdateGroupError({required this.errorMessage});
}

final class GetOrganizationGroupsLoading extends GroupsState {}

final class GetOrganizationGroupsSuccess extends GroupsState {
  final List<Group> groups;
  GetOrganizationGroupsSuccess({required this.groups});
}

final class GetOrganizationGroupsError extends GroupsState {
  final String errorMessage;
  GetOrganizationGroupsError({required this.errorMessage});
}

final class GetGroupByIdLoading extends GroupsState {}

final class GetGroupByIdSuccess extends GroupsState {
  final Group group;
  GetGroupByIdSuccess({required this.group});
}

final class GetGroupByIdError extends GroupsState {
  final String errorMessage;
  GetGroupByIdError({required this.errorMessage});
}

final class GetMyGroupsLoading extends GroupsState {}

final class GetMyGroupsSuccess extends GroupsState {
  final List<Group> groups;
  GetMyGroupsSuccess({required this.groups});
}

final class GetMyGroupsError extends GroupsState {
  final String errorMessage;
  GetMyGroupsError({required this.errorMessage});
}

final class GetMyPersonalGroupsLoading extends GroupsState {}

final class GetMyPersonalGroupsSuccess extends GroupsState {
  final List<Group> groups;
  GetMyPersonalGroupsSuccess({required this.groups});
}

final class GetMyPersonalGroupsError extends GroupsState {
  final String errorMessage;
  GetMyPersonalGroupsError({required this.errorMessage});
}

final class DeleteGroupLoading extends GroupsState {}

final class DeleteGroupSuccess extends GroupsState {}

final class DeleteGroupError extends GroupsState {
  final String errorMessage;
  DeleteGroupError({required this.errorMessage});
}

final class AddOrgMemberToGroupLoading extends GroupsState {}

final class AddOrgMemberToGroupSuccess extends GroupsState {}

final class AddOrgMemberToGroupError extends GroupsState {
  final String errorMessage;
  AddOrgMemberToGroupError({required this.errorMessage});
}

final class RemoveMemberFromOrgGroupLoading extends GroupsState {}

final class RemoveMemberFromOrgGroupSuccess extends GroupsState {}

final class RemoveMemberFromOrgGroupError extends GroupsState {
  final String errorMessage;
  RemoveMemberFromOrgGroupError({required this.errorMessage});
}
