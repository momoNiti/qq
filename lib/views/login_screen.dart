import 'package:qq/cubit/signin/signin_cubit.dart';
import 'package:qq/router/route_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocProvider(
          create: (_) => SigninCubit(context.read()),
          child: LoginForm(),
        ),
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return BlocListener<SigninCubit, SigninState>(
      cubit: BlocProvider.of<SigninCubit>(context),
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
                const SnackBar(content: Text("Authentication Failure")));
        }
      },
      child: Container(
        color: Colors.blue[700],
        height: _size.height,
        padding: EdgeInsets.symmetric(horizontal: _size.width * 0.1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Login",
              style: TextStyle(fontSize: 22),
            ),
            SizedBox(
              height: _size.height * 0.05,
            ),
            _EmailInput(),
            SizedBox(
              height: _size.height * 0.025,
            ),
            _PasswordInput(),
            SizedBox(
              height: _size.height * 0.025,
            ),
            _SigninButton(size: _size),
            SizedBox(
              height: _size.height * 0.025,
            ),
            _SignupButton()
          ],
        ),
      ),
    );
  }
}

class _SignupButton extends StatelessWidget {
  const _SignupButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Don't have an account yet? "),
        InkWell(
          onTap: () {
            Navigator.pushNamed(context, RoutePath.signup);
          },
          child: Text(
            "Sign Up",
            style: TextStyle(
              color: Colors.yellow[300],
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}

class _SigninButton extends StatelessWidget {
  const _SigninButton({
    Key key,
    @required Size size,
  })  : _size = size,
        super(key: key);

  final Size _size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _size.width * .3,
      child: BlocBuilder<SigninCubit, SigninState>(
        buildWhen: (previous, current) => previous.status != current.status,
        // cubit: BlocProvider.of<SigninCubit>(context),
        builder: (context, state) {
          return state.status.isSubmissionInProgress
              ? const CircularProgressIndicator()
              : RaisedButton(
                  color: Colors.blue[300].withOpacity(1),
                  child: Text("Sign In"),
                  onPressed: state.status.isValidated
                      ? () => context.read<SigninCubit>().signInWithCredential()
                      : null,
                );
        },
      ),
    );
  }
}

class _PasswordInput extends StatelessWidget {
  final _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SigninCubit, SigninState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextFormField(
          key: const Key('loginForm_passwordInput_textField'),
          onChanged: (password) =>
              context.read<SigninCubit>().passwordChanged(password),
          decoration: InputDecoration(
            labelText: "Password",
            errorText: state.password.invalid ? "Invalid Password" : null,
            labelStyle: TextStyle(color: Colors.black),
            filled: true,
            isDense: true,
            fillColor: Colors.blue[300].withOpacity(1),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(13.0),
            ),
          ),
          obscureText: true,
          controller: _passwordController,
          autocorrect: false,
        );
      },
    );
  }
}

class _EmailInput extends StatelessWidget {
  final _emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SigninCubit, SigninState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextFormField(
          key: const Key('loginForm_emailInput_textField'),
          onChanged: (email) => context.read<SigninCubit>().emailChanged(email),
          decoration: InputDecoration(
            labelText: "Email",
            errorText: state.email.invalid ? "Invalid Email" : null,
            labelStyle: TextStyle(color: Colors.black),
            filled: true,
            isDense: true,
            fillColor: Colors.blue[300].withOpacity(1),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(13.0),
            ),
          ),
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
        );
      },
    );
  }
}
