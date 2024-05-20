import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/auth_response.dart';
import '../../domain/repositories/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    on<SignInRequested>(_onSignInRequested);
    on<SignUpRequested>(_onSignUpRequested);
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

  Future<void> _onSignUpRequested(
      SignUpRequested event, Emitter<AuthState> emit) async {
    emit(const AuthLoading());
    final failureOrSuccess = await authRepository.signUpWithEmailAndPassword(
        event.email, event.password);
    emit(failureOrSuccess.fold(
      (failure) => AuthFailure(failure.message),
      (response) => AuthSuccess(response),
    ));
  }
}
