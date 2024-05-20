import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kwadra/core/error/failure.dart';
import 'package:kwadra/features/auth/domain/entities/auth_response.dart';
import 'package:kwadra/features/auth/domain/repositories/auth_repository.dart';
import 'package:kwadra/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late AuthRepository authRepository;
  late AuthBloc authBloc;

  setUp(() {
    authRepository = MockAuthRepository();
    authBloc = AuthBloc(authRepository: authRepository);
  });

  tearDown(() {
    authBloc.close();
  });

  group('AuthBloc', () {
    const email = 'test@example.com';
    const password = 'password123';
    const signInResponse = AuthResponse('Test User');
    const signUpResponse = AuthResponse('Test User');

    //// SIGN IN ////
    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthSuccess] when signInWithEmailAndPassword succeeds',
      build: () {
        when(() => authRepository.signInWithEmailAndPassword(email, password))
            .thenAnswer((_) async => const Right(signInResponse));
        return authBloc;
      },
      act: (bloc) => bloc.add(const SignInRequested(email, password)),
      expect: () => [
        const AuthLoading(),
        const AuthSuccess(signInResponse),
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthFailure] when signInWithEmailAndPassword fails',
      build: () {
        when(() => authRepository.signInWithEmailAndPassword(email, password))
            .thenAnswer(
                (_) async => const Left(ParamsFailure('Invalid credentials')));
        return authBloc;
      },
      act: (bloc) => bloc.add(const SignInRequested(email, password)),
      expect: () => [
        const AuthLoading(),
        const AuthFailure('Invalid credentials'),
      ],
    );

    //// SIGN UP ////
    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthSuccess] when signUpWithEmailAndPassword succeeds',
      build: () {
        when(() => authRepository.signUpWithEmailAndPassword(email, password))
            .thenAnswer((_) async => const Right(signUpResponse));
        return authBloc;
      },
      act: (bloc) => bloc.add(const SignUpRequested(email, password)),
      expect: () => [
        const AuthLoading(),
        const AuthSuccess(signUpResponse),
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthFailure] when signUpWithEmailAndPassword fails',
      build: () {
        when(() => authRepository.signUpWithEmailAndPassword(email, password))
            .thenAnswer(
                (_) async => const Left(ParamsFailure('Invalid credentials')));
        return authBloc;
      },
      act: (bloc) => bloc.add(const SignUpRequested(email, password)),
      expect: () => [
        const AuthLoading(),
        const AuthFailure('Invalid credentials'),
      ],
    );
  });
}
