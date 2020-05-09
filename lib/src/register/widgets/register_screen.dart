import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobs/src/data/api/user_repository.dart';
import 'package:jobs/src/register/bloc/bloc.dart';
import 'package:jobs/src/register/widgets/register_form.dart';

class RegisterScreen extends StatelessWidget {
  final UserRepository _userRepository;

  RegisterScreen({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.grey),
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ),
      body: BlocProvider<RegisterBloc>(
        create: (context) => RegisterBloc(userRepository: _userRepository),
        child: Padding(
          child: RegisterForm(),
          padding: const EdgeInsets.all(16),
        ),
      ),
    );
  }
}
