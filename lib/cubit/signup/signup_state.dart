part of 'signup_cubit.dart';

class SignupState extends Equatable {
  final Email email;
  final Password password;
  final ConfirmPassword confirmPassword;
  final FormzStatus status;

  const SignupState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.confirmPassword = const ConfirmPassword.pure(),
    this.status = FormzStatus.pure,
  });

  @override
  List<Object> get props => [email, password, confirmPassword, status];
  SignupState copyWith({
    Email email,
    Password password,
    ConfirmPassword confirmPassword,
    FormzStatus status,
  }) {
    return SignupState(
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      status: status ?? this.status,
    );
  }
}
