import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qq/cubit/signup/signup_cubit.dart';
import 'package:formz/formz.dart';

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocProvider(
          create: (_) => SignupCubit(context.read()),
          child: SignupForm(),
        ),
      ),
    );
  }
}

class SignupForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return BlocListener<SignupCubit, SignupState>(
      cubit: BlocProvider.of<SignupCubit>(context),
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(const SnackBar(content: Text("SignUp Failure")));
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
              "Sign Up",
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
            _ConfirmPasswordInput(),
            SizedBox(
              height: _size.height * 0.025,
            ),
            _SignUpButton(size: _size),
            SizedBox(
              height: _size.height * 0.025,
            ),
            _LoginButton()
          ],
        ),
      ),
    );
  }
}

class _LoginButton extends StatelessWidget {
  const _LoginButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Already have an account, "),
        InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Text(
            "Login",
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

class _SignUpButton extends StatelessWidget {
  const _SignUpButton({
    Key key,
    @required Size size,
  })  : _size = size,
        super(key: key);

  final Size _size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _size.width * .3,
      child: BlocBuilder<SignupCubit, SignupState>(
        buildWhen: (previous, current) => previous.status != current.status,
        builder: (context, state) {
          return state.status.isSubmissionInProgress
              ? const CircularProgressIndicator()
              : RaisedButton(
                  color: Colors.blue[300].withOpacity(1),
                  child: Text("Sign Up"),
                  onPressed: state.status.isValidated
                      ? () => context.read<SignupCubit>().signUpWithCredential()
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
    return BlocBuilder<SignupCubit, SignupState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextFormField(
          key: const Key('registerform_passwordInput_textField'),
          onChanged: (password) =>
              context.read<SignupCubit>().passwordChanged(password),
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

class _ConfirmPasswordInput extends StatelessWidget {
  final _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextFormField(
          key: const Key('registerform_confirmpasswordInput_textField'),
          onChanged: (password) =>
              context.read<SignupCubit>().confirmPasswordChanged(password),
          decoration: InputDecoration(
            labelText: "Password",
            errorText:
                state.confirmPassword.invalid ? "Invalid Password" : null,
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
    return BlocBuilder<SignupCubit, SignupState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextFormField(
          key: const Key('registerform_emailInput_textField'),
          onChanged: (email) => context.read<SignupCubit>().emailChanged(email),
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
