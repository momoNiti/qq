part of 'signin_cubit.dart';

class SigninState extends Equatable {
  final Email email;
  final Password password;
  final FormzStatus status;

  const SigninState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.status = FormzStatus.pure,
  });

  @override
  List<Object> get props => [email, password, status];

  SigninState copyWith({
    Email email,
    Password password,
    FormzStatus status,
  }) {
    return SigninState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
    );
  }
}
