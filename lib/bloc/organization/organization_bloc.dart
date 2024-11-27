import 'package:dh/model/invitation_model.dart';
import 'package:dh/model/models.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:dh/repository/repositories.dart';

part 'organization_event.dart';
part 'organization_state.dart';

class OrganizationBloc extends Bloc<OrganizationEvent, OrganizationState> {
  OrganizationRepository organizationRepository = OrganizationRepository();
  OrganizationBloc({required this.organizationRepository})
      : super(OrganizationInitial()) {
    on<CreateOrganizationEvent>((event, emit) async {
      emit(CreateOrganizationLoading());
      try {
        await organizationRepository.createOrganization(
            event.name, event.industryId, event.regionId);
        emit(CreateOrganizationSuccess());
      } catch (e) {
        emit(CreateOrganizationFailure(e.toString()));
      }
    });
    on<CreateOrgInviteEvent>((event, emit) async {
      emit(CreateOrgInviteLoading());
      try {
        await organizationRepository.createInvitation(event.orgId);
        emit(CreateOrgInviteSuccess());
      } catch (e) {
        emit(CreateOrgInviteFailure(e.toString()));
      }
    });
    on<GetMyOrgInvitesEvent>((event, emit) async {
      emit(GetMyOrgInvitesLoading());
      try {
        var res = await organizationRepository.getMyOrgInvites();
        emit(GetMyOrgInvitesSuccess(invitations: res));
      } catch (e) {
        emit(GetMyOrgInvitesFailure(e.toString()));
      }
    });
    on<GetOrgInvitesEvent>((event, emit) async {
      emit(GetOrgInvitesLoading());
      try {
        var res = await organizationRepository.getOrgInvites(event.orgId);
        emit(GetOrgInvitesSuccess(invitations: res));
      } catch (e) {
        emit(GetOrgInvitesFailure(e.toString()));
      }
    });
    on<ChangeRequestStatusEvent>((event, emit) async {
      emit(ChangeRequestStatusLoading());
      try {
        await organizationRepository
            .changeInvitationRequestStatus(event.status,event.id);
        emit(ChangeRequestStatusSuccess());
      } catch (e) {
        emit(ChangeRequestStatusFailure(e.toString()));
      }
    });
    on<SearchOrganizationEvent>((event, emit) async {
      emit(SearchOrganizationLoading());
      try {
        var res = await organizationRepository.searchOrganizations(event.value);
        emit(SearchOrganizationSuccess(organizations: res));
      } catch (e) {
        emit(SearchOrganizationFailure(e.toString()));
      }
    });
    on<GetAllOrganizationMembersEvent>((event, emit) async {
      emit(GetAllOrganizationMembersLoading());
      try {
        var res =
            await organizationRepository.getAllOrganizationMembers(event.orgId);
        emit(GetAllOrganizationMembersSuccess(members: res));
      } catch (e) {
        emit(GetAllOrganizationMembersFailure(e.toString()));
      }
    });
    on<GetMyOrganizationsEvent>((event, emit) async {
      emit(GetMyOrganizationsLoading());
      try {
        var res = await organizationRepository.getMyOrganizations();
        emit(GetMyOrganizationsSuccess(organizations: res));
      } catch (e) {
        emit(GetMyOrganizationsFailure(e.toString()));
      }
    });
    on<RemoveMemberByOrgIdAndMemberIdEvent>((event, emit) async {
      emit(RemoveMemberByOrgIdAndMemberIdLoading());
      try {
        await organizationRepository.removeMemberByOrgIdAndMemberId(
            event.orgId, event.memberId );
        emit(RemoveMemberByOrgIdAndMemberIdSuccess());
      } catch (e) {
        emit(RemoveMemberByOrgIdAndMemberIdFailure(e.toString()));
      }
    });
    on<AddMemberEvent>((event, emit) async {
      emit(AddMemberLoading());
      try {
        await organizationRepository.addMember(
            event.orgId, event.memberId, event.role);
        emit(AddMemberSuccess());
      } catch (e) {
        emit(AddMemberFailure(e.toString()));
      }
    });
    on<GetIndustriesEvent>((event, emit) async {
      emit(GetIndustriesLoading());
      try {
        var ind = await organizationRepository.getIndustries();
        var regi = await organizationRepository.getRegions();
        emit(GetIndustriesSuccess(regions: regi, industries: ind));
      } catch (e) {
        emit(GetIndustriesFailure(e.toString()));
      }
    });
  }
}
