import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobs/src/auth/bloc/authentication_bloc.dart';
import 'package:jobs/src/auth/bloc/authentication_event.dart';
import 'package:jobs/src/data/api/user_repository.dart';
import 'package:jobs/src/login/bloc/login_bloc.dart';
import 'package:jobs/src/login/bloc/login_event.dart';
import 'package:jobs/src/login/bloc/login_state.dart';
import 'package:jobs/src/widgets/register_screen.dart';
import 'package:nepninja/nepninja.dart';

class LoginForm extends StatefulWidget {
  final UserRepository _userRepository;

  LoginForm({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginBloc _loginBloc;

  UserRepository get _userRepository => widget._userRepository;

  bool get isPopulated =>
      _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;

  bool isLoginButtonEnabled(LoginState loginState) {
    return loginState.isFormValid && isPopulated && !loginState.isSubmitting;
  }

  Function _reset;

  @override
  void initState() {
    super.initState();
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    _emailController.addListener(_onEmailChanged);
    _passwordController.addListener(_onPasswordChanged);
  }

  void _onEmailChanged() {
    _loginBloc.add(EmailChanged(email: _emailController.text));
  }

  void _onPasswordChanged() {
    _loginBloc.add(PasswordChanged(password: _passwordController.text));
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onFormSubmitted() {
    _loginBloc.add(LoginWithCredentialsPressed(
        email: _emailController.text, password: _passwordController.text));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.isFailure) {
          _reset();
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text(state.errorMessage), Icon(Icons.error)],
                ),
                backgroundColor: Colors.red,
              ),
            );
        }
        if (state.isSuccess) {
          BlocProvider.of<AuthenticationBloc>(context).add(LoggedIn());
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return Container(
            padding: EdgeInsets.only(
              top: 64,
              left: 16,
              right: 16,
              bottom: 24,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    getHeader(),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 32,
                        bottom: 32,
                      ),
                      child: getForm(state),
                    )
                  ],
                ),
                Text("Forgot Password?"),
                SizedBox(
                  height: 32,
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 32),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: 1,
                        width: 30,
                        color: Colors.grey,
                      ),
                      Padding(
                        child: Text(
                          "OR",
                        ),
                        padding: EdgeInsets.only(
                          left: 8,
                          right: 8,
                        ),
                      ),
                      Container(
                        height: 1,
                        width: 30,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 200,
                  height: 55,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: Colors.grey,
                        width: 2.0,
                      )),
                  child: InkWell(
                    onTap: () {
                      _loginBloc.add(LoginWithGooglePressed());
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset(
                            "assets/images/google.png",
                            height: 24,
                            width: 24,
                          ),
                          Text(
                            "Sign In with Google",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
//          SizedBox(
//            height: 80,
//          ),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: RichText(
                        text: TextSpan(
                      children: [
                        TextSpan(
                            text: "Don't have an account? ",
                            style: TextStyle(color: Colors.black)),
                        TextSpan(
                            text: 'Create Now',
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                register(context);
                              },
                            style: TextStyle(
                              color: Colors.lightBlueAccent,
                              fontWeight: FontWeight.bold,
                            )),
                      ],
                    )),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  void register(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return RegisterScreen(
        userRepository: _userRepository,
      );
    }));
  }

  Widget getHeader() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Welcome Back,",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 4,
          ),
          Text(
            "Sign in to continue",
            style: TextStyle(
              color: Colors.grey,
              fontSize: 18,
            ),
          ),
          SizedBox(
            height: 56,
          ),
          Image.asset(
            "assets/images/boy.png",
            height: 60,
            width: 60,
          )
        ],
      ),
    );
  }

  Widget getForm(LoginState state) {
    return Form(
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(
              hintText: 'Enter your email',
              labelText: "Email",
            ),
            autovalidate: true,
            keyboardType: TextInputType.emailAddress,
            validator: (_) {
              return !state.isEmailValid ? "Enter valid email" : null;
            },
          ),
          TextFormField(
            controller: _passwordController,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: "Password",
              hintText: 'Enter your password',
            ),
            autovalidate: true,
            autocorrect: false,
            validator: (value) =>
                !state.isPasswordValid ? "Password can't be empty" : null,
          ),
          SizedBox(
            height: 32,
          ),
          CircularProgressButton(
            height: 55,
            width: 200,
            borderRadius: 30,
            backgroundColor: Colors.lightBlueAccent,
            fadeDurationInMilliSecond: 400,
            text: "Sign In",
            progressIndicatorColor: Colors.pinkAccent,
            fontSize: 20.0,
            onTap: (reset) {
              _reset = reset;
              _onFormSubmitted();
            },
          ),
        ],
      ),
    );
  }
}
