import 'package:bloc/bloc.dart';
import 'package:formz/formz.dart';
import 'package:qq/models/form_validation.dart';
import 'package:qq/net/authentication_repository.dart';
import 'package:equatable/equatable.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  final AuthenticationRepository _authenticationRepository;
  SignupCubit(this._authenticationRepository)
      : assert(_authenticationRepository != null),
        super(const SignupState());

  void emailChanged(String value) {
    final email = Email.dirty(value);
    emit(
      state.copyWith(
        email: email,
        status: Formz.validate([email, state.password, state.confirmPassword]),
      ),
    );
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value);
    emit(
      state.copyWith(
        password: password,
        status: Formz.validate([password, state.email, state.confirmPassword]),
      ),
    );
  }

  void confirmPasswordChanged(String value) {
    final confirmPassword =
        ConfirmPassword.dirty(password: state.password.value, value: value);
    emit(
      state.copyWith(
        confirmPassword: confirmPassword,
        status: Formz.validate([confirmPassword, state.email, state.password]),
      ),
    );
  }

  Future<void> signUpWithCredential() async {
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      await _authenticationRepository.signUp(
          email: state.email.value, password: state.password.value);
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on Exception {
      emit(state.copyWith(status: FormzStatus.submissionFailure));
    }
  }
}
