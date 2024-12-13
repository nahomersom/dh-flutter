part of 'auth_bloc.dart';

abstract class AuthEvent {
  const AuthEvent();
  List<Object> get props => [];
}

class ResetPasswordEvent extends AuthEvent {
  final String phoneNumber;
  final String password;
  final String confirmPassword;
  final String type;
  const ResetPasswordEvent(
      this.phoneNumber, this.password, this.confirmPassword, this.type);
}

class ChangePasswordEvent extends AuthEvent {
  final String password;
  final String currentPassword;
  final String confirmPassword;
  final BuildContext cxt;

  const ChangePasswordEvent(
      this.password, this.confirmPassword, this.currentPassword, this.cxt);
}

class SendOTPEvent extends AuthEvent {
  final String phoneNumber;
  const SendOTPEvent(this.phoneNumber);
}

class VerifyOTPEvent extends AuthEvent {
  final String phoneNumber;
  final String otp;
  const VerifyOTPEvent(this.phoneNumber, this.otp);
}

class CompleteProfileEvent extends AuthEvent {
  // final String phoneNumber;
  final String firstName;
  final String lastName;
  final String middleName;
  final File? profileImage;
  const CompleteProfileEvent(
    this.firstName,
    this.middleName,
    this.lastName,
    this.profileImage,
  );
}

class CheckPhoneNumberEvent extends AuthEvent {
  final String phoneNumber;

  const CheckPhoneNumberEvent(
    this.phoneNumber,
  );
}

class SearchUserEvent extends AuthEvent {
  final String value;

  const SearchUserEvent(
    this.value,
  );
}

class GetAllUsersEvent extends AuthEvent {
  const GetAllUsersEvent();
}

class GetMyProfileEvent extends AuthEvent {
  const GetMyProfileEvent();
}

class LogoutEvent extends AuthEvent {
  final BuildContext context;
  const LogoutEvent({required this.context});
}
