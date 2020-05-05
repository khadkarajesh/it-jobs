import 'package:meta/meta.dart';

@immutable
class RegisterState {
  final bool isValidEmail;
  final bool isValidPassword;
  final bool isValidConfirmPassword;
  final bool isPasswordMatch;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;

  bool get isFormValid =>
      isValidEmail &&
      isValidPassword &&
      isValidConfirmPassword &&
      isPasswordMatch;

  RegisterState(
      {this.isValidEmail,
      this.isValidPassword,
      this.isValidConfirmPassword,
      this.isPasswordMatch,
      this.isSubmitting,
      this.isSuccess,
      this.isFailure});

  factory RegisterState.empty() {
    return RegisterState(
        isValidEmail: false,
        isValidPassword: false,
        isValidConfirmPassword: false,
        isPasswordMatch: false,
        isSubmitting: false,
        isFailure: false,
        isSuccess: false);
  }

  factory RegisterState.loading() {
    return RegisterState(
        isValidEmail: true,
        isValidPassword: true,
        isValidConfirmPassword: true,
        isPasswordMatch: false,
        isSubmitting: true,
        isFailure: false,
        isSuccess: false);
  }

  factory RegisterState.failure() {
    return RegisterState(
        isValidEmail: true,
        isValidPassword: true,
        isValidConfirmPassword: true,
        isPasswordMatch: true,
        isSubmitting: false,
        isFailure: true,
        isSuccess: false);
  }

  factory RegisterState.success() {
    return RegisterState(
        isValidEmail: true,
        isValidPassword: true,
        isValidConfirmPassword: true,
        isPasswordMatch: true,
        isSubmitting: false,
        isFailure: false,
        isSuccess: true);
  }

  RegisterState update(
      {bool isValidName,
      bool isValidEmail,
      bool isValidPassword,
      bool isValidConfirmPassword,
      bool isPasswordMatch}) {
    return copyWith(
        isValidName: isValidName,
        isValidEmail: isValidEmail,
        isValidPassword: isValidPassword,
        isValidConfirmPassword: isValidConfirmPassword,
        isPasswordMatch: isPasswordMatch);
  }

  RegisterState copyWith(
      {bool isValidName,
      bool isValidEmail,
      bool isValidPassword,
      bool isValidConfirmPassword,
      bool isPasswordMatch,
      bool isSubmitting,
      bool isSuccess,
      bool isFailure}) {
    return RegisterState(
        isValidEmail: isValidEmail ?? this.isValidEmail,
        isValidPassword: isValidPassword ?? this.isValidPassword,
        isValidConfirmPassword:
            isValidConfirmPassword ?? this.isValidConfirmPassword,
        isPasswordMatch: isPasswordMatch?? this.isPasswordMatch,
        isSubmitting: isSubmitting ?? this.isSubmitting,
        isSuccess: isSuccess ?? this.isSuccess,
        isFailure: isFailure ?? this.isFailure);
  }
}
