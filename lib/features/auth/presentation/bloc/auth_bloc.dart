import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kwadra/features/auth/domain/entities/sign_in_response.dart';

import '../../domain/repositories/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    on<SignInRequested>(_onSignInRequested);
  }

  Future<void> _onSignInRequested(
    SignInRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    final failureOrSuccess = await authRepository.signInWithEmailAndPassword(
        event.email, event.password);
    emit(failureOrSuccess.fold(
      (failure) => AuthFailure(failure.message),
      (response) => AuthSuccess(response),
    ));
  }
}
