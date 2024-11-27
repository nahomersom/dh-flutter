part of 'groups_bloc.dart';

@immutable
abstract class GroupsEvent {}

class CreateGroup extends GroupsEvent {
  final String name;
  final String color;
  final int? orgId;
  CreateGroup({required this.name, required this.orgId, required this.color});
}

class UpdateGroup extends GroupsEvent {
  final String name;
  final int groupId;
  UpdateGroup({required this.name, required this.groupId});
}

class GetGroupById extends GroupsEvent {
  final int id;
  GetGroupById({required this.id});
}

class GetMyGroups extends GroupsEvent {
  GetMyGroups();
}
class GetMyPersonalGroups extends GroupsEvent {
  GetMyPersonalGroups();
}

class GetOrganizationGroups extends GroupsEvent {
  final int orgId;
  GetOrganizationGroups({required this.orgId});
}
class DeleteGroup extends GroupsEvent {
  final int id;
  DeleteGroup({required this.id});
}
class AddOrgMemberToGroup extends GroupsEvent {
  final int groupId;
  final int memberId;
  AddOrgMemberToGroup({required this.groupId, required this.memberId});
}
class RemoveMemberFromOrgGroup extends GroupsEvent {
  final int groupId;
  final int memberId;
  RemoveMemberFromOrgGroup({required this.groupId, required this.memberId});
}