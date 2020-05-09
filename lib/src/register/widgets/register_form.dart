import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobs/src/auth/bloc/authentication_bloc.dart';
import 'package:jobs/src/auth/bloc/authentication_event.dart';
import 'package:jobs/src/register/bloc/bloc.dart';
import 'package:jobs/src/register/bloc/register_bloc.dart';

class RegisterForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  RegisterBloc _bloc;

  bool get isPopulated =>
      _emailController.text.isNotEmpty &&
      _passwordController.text.isNotEmpty &&
      _confirmPasswordController.text.isNotEmpty;

  bool isRegisteredButtonEnabled(RegisterState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<RegisterBloc>(context);
    _emailController.addListener(_onEmailChanged);
    _passwordController.addListener(_onPasswordChanged);
    _confirmPasswordController.addListener(_onConfirmPasswordChanged);
  }

  void _onEmailChanged() {
    _bloc.add(EmailChangedEvent(email: _emailController.text));
  }

  void _onPasswordChanged() {
    _bloc.add(PasswordChangedEvent(
        password: _passwordController.text,
        confirmPassword: _confirmPasswordController.text));
  }

  void _onConfirmPasswordChanged() {
    _bloc.add(ConfirmPasswordChanged(
        password: _passwordController.text,
        confirmPassword: _confirmPasswordController.text));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state.isSubmitting) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Registering...'),
                    CircularProgressIndicator(),
                  ],
                ),
              ),
            );
        }
        if (state.isSuccess) {
          BlocProvider.of<AuthenticationBloc>(context).add(LoggedIn());
          Navigator.of(context).pop();
        }
        if (state.isFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(state.errorMessage),
                    Icon(Icons.error),
                  ],
                ),
                backgroundColor: Colors.red,
              ),
            );
        }
      },
      child: BlocBuilder<RegisterBloc, RegisterState>(
        builder: (context, state) {
          return Form(
              child: ListView(
            children: <Widget>[
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 32,
                    bottom: 32,
                  ),
                  child: Column(
                    children: <Widget>[
                      Text(
                        "Let's get started",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Create account to get hired by your dream company",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 50,),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  hintText: "Enter your email",
                  labelText: "Email",
                ),
                keyboardType: TextInputType.emailAddress,
                autovalidate: true,
                validator: (_) {
                  return !state.isValidEmail ? "Enter valid email" : null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(
                    hintText: "Enter password", labelText: "Password"),
                obscureText: true,
                autocorrect: false,
                autovalidate: true,
                validator: (_) {
                  return !state.isValidPassword
                      ? "Password can't be empty"
                      : null;
                },
              ),
              TextFormField(
                controller: _confirmPasswordController,
                decoration: const InputDecoration(
                    hintText: "Confirm Password",
                    labelText: "Confirm Password"),
                obscureText: true,
                autocorrect: false,
                autovalidate: true,
                validator: (_) {
                  if (!state.isValidConfirmPassword) {
                    return "Password can not empty";
                  } else if (!state.isPasswordMatch) {
                    return "Password should match";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 32,
              ),
              Center(
                child: RegisterButton(
                  onPressed: isRegisteredButtonEnabled(state)
                      ? _onFormSubmitted
                      : null,
                ),
              ),
            ],
          ));
        },
      ),
    );
  }

  void register(Function reset) {
    _onFormSubmitted();
  }

  void _onFormSubmitted() {
    _bloc.add(SubmitFormEvent(
        email: _emailController.text, password: _passwordController.text));
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}

class RegisterButton extends StatelessWidget {
  final VoidCallback _onPressed;

  RegisterButton({Key key, VoidCallback onPressed})
      : _onPressed = onPressed,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      padding: const EdgeInsets.only(top: 20, bottom: 20, right: 70, left: 70),
      color: Colors.lightBlueAccent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      onPressed: _onPressed,
      child: Text(
        'Register',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
