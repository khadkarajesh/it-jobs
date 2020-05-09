import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobs/src/data/api/user_repository.dart';
import 'package:jobs/src/login/bloc/login_bloc.dart';

import 'login_form.dart';

class LoginScreen extends StatelessWidget {

  final UserRepository _userRepository;

  LoginScreen({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(userRepository:_userRepository),
          child: LoginForm(userRepository: _userRepository,),
        ));
  }
}