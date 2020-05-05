import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:jobs/src/data/api/user_repository.dart';
import 'package:jobs/src/utils/validators.dart';
import './bloc.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final UserRepository _userRepository;

  RegisterBloc({@required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository;

  @override
  RegisterState get initialState => RegisterState.empty();

  @override
  Stream<RegisterState> mapEventToState(
    RegisterEvent event,
  ) async* {
    if (event is NameChangedEvent) {
      yield state.update(isValidName: event.name.isNotEmpty);
    } else if (event is EmailChangedEvent) {
      yield state.update(isValidEmail: Validators.isValidEmail(event.email));
    } else if (event is PasswordChangedEvent) {
      yield state.update(isValidPassword: event.password.isNotEmpty);
    } else if (event is ConfirmPasswordChanged) {
      yield state.update(
          isValidConfirmPassword: event.password.isNotEmpty,
          isPasswordMatch: event.password == event.confirmPassword);
    } else if (event is SubmitFormEvent) {
      yield RegisterState.loading();
      try {
        _userRepository.signUp(email: event.email, password: event.password);
        yield RegisterState.success();
      } catch (_) {
        yield RegisterState.failure();
      }
    }
  }
}
