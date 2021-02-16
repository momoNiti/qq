import 'package:meta/meta.dart';
import 'package:formz/formz.dart';

enum ValidatorError { invalid }

class Email extends FormzInput<String, ValidatorError> {
  const Email.pure() : super.pure('');
  const Email.dirty([String value = '']) : super.dirty(value);

  static final RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );

  @override
  ValidatorError validator(value) {
    return _emailRegExp.hasMatch(value) ? null : ValidatorError.invalid;
  }
}

class Password extends FormzInput<String, ValidatorError> {
  const Password.pure() : super.pure('');
  const Password.dirty([String value = '']) : super.dirty(value);

  static final _passwordRegExp =
      RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$');

  @override
  ValidatorError validator(value) {
    // TODO: implement validator
    return _passwordRegExp.hasMatch(value) ? null : ValidatorError.invalid;
  }
}

class ConfirmPassword extends FormzInput<String, ValidatorError> {
  final String password;
  const ConfirmPassword.pure({this.password = ''}) : super.pure('');
  const ConfirmPassword.dirty({@required this.password, String value = ''})
      : super.dirty(value);

  @override
  ValidatorError validator(value) {
    // TODO: implement validator
    return password == value ? null : ValidatorError.invalid;
  }
}
