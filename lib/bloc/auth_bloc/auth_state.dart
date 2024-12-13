// ignore_for_file: must_be_immutable
part of 'auth_bloc.dart';

abstract class AuthState {
  const AuthState();
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class ResetPasswordLoading extends AuthState {}

class ResetPasswordSuccess extends AuthState {}

class ResetPasswordFailure extends AuthState {
  final String errorMessage;
  const ResetPasswordFailure(this.errorMessage);
}

class ChangePasswordLoading extends AuthState {}

class ChangePasswordSuccess extends AuthState {}

class ChangePasswordFailure extends AuthState {
  final String errorMessage;
  const ChangePasswordFailure(this.errorMessage);
}

class CheckPhoneNumberLoading extends AuthState {}

class CheckPhoneNumberSuccess extends AuthState {
  bool doesExist;
  CheckPhoneNumberSuccess(this.doesExist);
}

class CheckPhoneNumberFailure extends AuthState {
  final String errorMessage;
  const CheckPhoneNumberFailure(this.errorMessage);
}

class SendOTPLoading extends AuthState {}

class SendOTPSuccess extends AuthState {
  const SendOTPSuccess();
}

class SendOTPFailure extends AuthState {
  final String errorMessage;
  const SendOTPFailure(this.errorMessage);
}

class VerifyOTPLoading extends AuthState {}

class VerifyOTPSuccess extends AuthState {
  const VerifyOTPSuccess();
}

class VerifyOTPFailure extends AuthState {
  final String errorMessage;
  const VerifyOTPFailure(this.errorMessage);
}

class CompleteProfileLoading extends AuthState {}

class CompleteProfileSuccess extends AuthState {
  const CompleteProfileSuccess();
}

class CompleteProfileFailure extends AuthState {
  final String errorMessage;
  const CompleteProfileFailure(this.errorMessage);
}

class GetMyProfileLoading extends AuthState {}

class GetMyProfileSuccess extends AuthState {
  User user;
  GetMyProfileSuccess({required this.user});
}

class GetMyProfileFailure extends AuthState {
  final String errorMessage;
  const GetMyProfileFailure(this.errorMessage);
}

class SearchUserLoading extends AuthState {}

class SearchUserSuccess extends AuthState {
  List<User> users;
  SearchUserSuccess({required this.users});
}

class SearchUserFailure extends AuthState {
  final String errorMessage;
  const SearchUserFailure(this.errorMessage);
}
class GetAllUsersLoading extends AuthState {}

class GetAllUsersSuccess extends AuthState {
  List<User> users;
  GetAllUsersSuccess({required this.users});
}

class GetAllUsersFailure extends AuthState {
  final String errorMessage;
  const GetAllUsersFailure(this.errorMessage);
}

class LogoutLoading extends AuthState {}

class LogoutSuccess extends AuthState {
  const LogoutSuccess();
}

class LogoutFailure extends AuthState {
  final String errorMessage;
  const LogoutFailure(this.errorMessage);
}
