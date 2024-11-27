// ignore_for_file: depend_on_referenced_packages

import 'dart:io';

import 'package:dh/model/models.dart';
import 'package:dh/repository/auth_repository.dart';
// import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthRepository authRepository;
  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    on<SendOTPEvent>((event, emit) async {
      emit(SendOTPLoading());
      try {
        await authRepository.sendOtp(event.phoneNumber);
        emit(const SendOTPSuccess());
      } catch (e) {
        emit(SendOTPFailure(e.toString()));
      }
    });
    on<CheckPhoneNumberEvent>((event, emit) async {
      emit(CheckPhoneNumberLoading());
      try {
        var res = await authRepository.checkPhoneNumber(event.phoneNumber);

        emit(CheckPhoneNumberSuccess(res));
      } catch (e) {
        emit(CheckPhoneNumberFailure(e.toString()));
      }
    });
    on<VerifyOTPEvent>((event, emit) async {
      emit(VerifyOTPLoading());
      try {
        await authRepository.verifyOtp(event.phoneNumber, event.otp);
        emit(const VerifyOTPSuccess());
      } catch (e) {
        emit(VerifyOTPFailure(e.toString()));
      }
    });

    on<ChangePasswordEvent>((event, emit) async {
      emit(ChangePasswordLoading());
      try {
        await authRepository.changePassword(
            event.password, event.currentPassword, event.confirmPassword);
        emit(ChangePasswordSuccess());
      } catch (e) {
        emit(ChangePasswordFailure(e.toString()));
      }
    });
    on<ResetPasswordEvent>((event, emit) async {
      emit(ResetPasswordLoading());
      try {
        await authRepository.resetPassword(event.phoneNumber, event.password,
            event.confirmPassword, event.type);
        emit(ResetPasswordSuccess());
      } catch (e) {
        emit(ResetPasswordFailure(e.toString()));
      }
    });
    on<CompleteProfileEvent>((event, emit) async {
      emit(CompleteProfileLoading());
      try {
        await authRepository.completeProfile(event.firstName, event.middleName,
            event.lastName, event.profileImage);
        emit(const CompleteProfileSuccess());
      } catch (e) {
        emit(CompleteProfileFailure(e.toString()));
      }
    });
    on<GetMyProfileEvent>((event, emit) async {
      emit(GetMyProfileLoading());
      try {
        var res = await authRepository.getUserProfile();
        emit(GetMyProfileSuccess(user: res));
      } catch (e) {
        emit(GetMyProfileFailure(e.toString()));
      }
    });
    on<SearchUserEvent>((event, emit) async {
      emit(SearchUserLoading());
      try {
        var res = await authRepository.searchUsers(event.value);
        emit(SearchUserSuccess(users: res));
      } catch (e) {
        emit(SearchUserFailure(e.toString()));
      }
    });
    on<GetAllUsersEvent>((event, emit) async {
      emit(GetAllUsersLoading());
      try {
        var res = await authRepository.getAllUsers();
        emit(GetAllUsersSuccess(users: res));
      } catch (e) {
        emit(GetAllUsersFailure(e.toString()));
      }
    });
    on<LogoutEvent>((event, emit) async {
      emit(LogoutLoading());
      try {
        await authRepository.logout(event.context);
        emit(const LogoutSuccess());
      } catch (e) {
        emit(LogoutFailure(e.toString()));
      }
    });
  }
}
