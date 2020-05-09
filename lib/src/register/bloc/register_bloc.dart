import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:jobs/src/data/api/user_repository.dart';
import 'package:jobs/src/utils/validators.dart';
import 'package:rxdart/rxdart.dart';
import './bloc.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final UserRepository _userRepository;

  RegisterBloc({@required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository;

  @override
  RegisterState get initialState => RegisterState.empty();

  @override
  Stream<Transition<RegisterEvent, RegisterState>> transformEvents(
      Stream<RegisterEvent> events,
      TransitionFunction<RegisterEvent, RegisterState> transitionFn,
      ) {
    final nonDebounceStream = events.where((event) {
      return (event is! EmailChangedEvent && event is! PasswordChangedEvent);
    });
    final debounceStream = events.where((event) {
      return (event is EmailChangedEvent || event is PasswordChangedEvent);
    }).debounceTime(Duration(milliseconds: 300));
    return super.transformEvents(
      nonDebounceStream.mergeWith([debounceStream]),
      transitionFn,
    );
  }

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
        await _userRepository.signUp(
            email: event.email, password: event.password);
        yield RegisterState.success();
      } catch (e) {
        yield RegisterState.failure(e.message);
      }
    }
  }
}
