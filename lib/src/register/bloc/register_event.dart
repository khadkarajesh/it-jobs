import 'package:meta/meta.dart';

@immutable
abstract class RegisterEvent {}

class NameChangedEvent extends RegisterEvent {
  final String name;

  NameChangedEvent({this.name});
}

class EmailChangedEvent extends RegisterEvent {
  final String email;

  EmailChangedEvent({this.email});
}

class PasswordChangedEvent extends RegisterEvent {
  final String password;
  final String confirmPassword;

  PasswordChangedEvent({this.password, this.confirmPassword});
}

class ConfirmPasswordChanged extends RegisterEvent {
  final String password;
  final String confirmPassword;

  ConfirmPasswordChanged({this.password, this.confirmPassword});
}

class SubmitFormEvent extends RegisterEvent {
  final String name;
  final String password;
  final String confirmPassword;
  final String email;

  SubmitFormEvent({this.name, this.password, this.confirmPassword, this.email});
}
