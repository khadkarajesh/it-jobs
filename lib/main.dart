import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobs/src/auth/bloc/authentication_bloc.dart';
import 'package:jobs/src/auth/bloc/authentication_event.dart';
import 'package:jobs/src/auth/bloc/authentication_state.dart';
import 'package:jobs/src/login/widgets/login_screen.dart';
import 'package:jobs/src/simple_bloc_delegate.dart';
import 'package:jobs/src/data/api/user_repository.dart';
import 'package:jobs/src/widgets/home_screen.dart';
import 'package:jobs/src/widgets/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  BlocSupervisor.delegate = SimpleBlocDelegate();
  final UserRepository userRepository = UserRepository();
  runApp(
    BlocProvider(
      create: (context) =>
          AuthenticationBloc(userRepository: userRepository)..add(AppStarted()),
      child: App(userRepository: userRepository),
    ),
  );
}

class App extends StatelessWidget {
  final UserRepository _userRepository;

  App({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is Uninitialized) {
            return SplashScreen();
          }
          if (state is Authenticated) {
            return HomeScreen(name: state.displayName);
          }
          if (state is UnAuthenticated) {
            return LoginScreen(
              userRepository: _userRepository,
            );
          }
          return Container();
        },
      ),
    );
  }
}
