import 'package:bloc/bloc.dart';
import 'package:dh_flutter_v2/model/group_model.dart';
import 'package:dh_flutter_v2/repository/repositories.dart';
import 'package:meta/meta.dart';

part 'groups_event.dart';
part 'groups_state.dart';

class GroupsBloc extends Bloc<GroupsEvent, GroupsState> {
  GroupRepository groupRepository;
  GroupsBloc({required this.groupRepository}) : super(GroupsInitial()) {
    on<CreateGroup>((event, emit) async {
      emit(CreateGroupLoading());
      try {
        await groupRepository.createGroup(event.name, event.orgId, event.color);
        emit(CreateGroupSuccess());
      } catch (e) {
        emit(CreateGroupError(errorMessage: e.toString()));
      }
    });
    on<UpdateGroup>((event, emit) async {
      emit(UpdateGroupLoading());
      try {
        await groupRepository.updateGroup(event.name, event.groupId);

        emit(UpdateGroupSuccess());
      } catch (e) {
        emit(UpdateGroupError(errorMessage: e.toString()));
      }
    });
    on<GetOrganizationGroups>((event, emit) async {
      emit(GetOrganizationGroupsLoading());
      try {
        var res = await groupRepository.getOrganizationGroups(event.orgId);
        emit(GetOrganizationGroupsSuccess(groups: res));
      } catch (e) {
        emit(GetOrganizationGroupsError(errorMessage: e.toString()));
      }
    });
    on<GetMyGroups>((event, emit) async {
      emit(GetMyGroupsLoading());
      try {
        var res = await groupRepository.getMyGroups();
        emit(GetMyGroupsSuccess(groups: res));
      } catch (e) {
        emit(GetMyGroupsError(errorMessage: e.toString()));
      }
    });
    on<GetMyPersonalGroups>((event, emit) async {
      emit(GetMyPersonalGroupsLoading());
      try {
        var res = await groupRepository.getMyPersonalGroups();
        emit(GetMyPersonalGroupsSuccess(groups: res));
      } catch (e) {
        emit(GetMyPersonalGroupsError(errorMessage: e.toString()));
      }
    });
    on<GetGroupById>((event, emit) async {
      emit(GetGroupByIdLoading());
      try {
        var res = await groupRepository.getGroupById(event.id);
        emit(GetGroupByIdSuccess(group: res));
      } catch (e) {
        emit(GetGroupByIdError(errorMessage: e.toString()));
      }
    });
    on<DeleteGroup>((event, emit) async {
      emit(DeleteGroupLoading());
      try {
        await groupRepository.deleteGroup(event.id);
        emit(DeleteGroupSuccess());
      } catch (e) {
        emit(DeleteGroupError(errorMessage: e.toString()));
      }
    });
    on<AddOrgMemberToGroup>((event, emit) async {
      emit(AddOrgMemberToGroupLoading());
      try {
        await groupRepository.addOrgMemberToGroup(
            event.groupId, event.memberId);
        emit(AddOrgMemberToGroupSuccess());
      } catch (e) {
        emit(AddOrgMemberToGroupError(errorMessage: e.toString()));
      }
    });
    on<RemoveMemberFromOrgGroup>((event, emit) async {
      emit(RemoveMemberFromOrgGroupLoading());
      try {
        await groupRepository.removeMemberFromOrgGroup(
            event.groupId, event.memberId);
        emit(RemoveMemberFromOrgGroupSuccess());
      } catch (e) {
        emit(RemoveMemberFromOrgGroupError(errorMessage: e.toString()));
      }
    });
  }
}
