import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kwadra/core/error/failure.dart';
import 'package:kwadra/features/auth/domain/entities/auth_response.dart';
import 'package:kwadra/features/auth/domain/repositories/auth_repository.dart';
import 'package:kwadra/features/auth/domain/usecases/sign_up_with_email_and_password.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  group('SignUpWithEmailAndPassword', () {
    late SignUpWithEmailAndPassword usecase;
    late AuthRepository mockAuthRepository;

    setUpAll(() {
      mockAuthRepository = MockAuthRepository();
    });

    test('should call once and return success', () async {
      // arrange
      when(() => mockAuthRepository.signUpWithEmailAndPassword(
              'email', 'password'))
          .thenAnswer(
              (_) async => const Right(AuthResponse("Sign up success")));
      usecase = SignUpWithEmailAndPassword(mockAuthRepository);

      // act
      final result = await usecase.call('email', 'password');

      // assert
      verify(() => mockAuthRepository.signUpWithEmailAndPassword(
          'email', 'password')).called(1);
      expect(result, const Right(AuthResponse("Sign up success")));
    });

    test('should call once and return success', () async {
      // arrange
      when(() => mockAuthRepository.signUpWithEmailAndPassword(
              'email', 'password'))
          .thenAnswer((_) async => const Left(ParamsFailure("Sign up failed")));
      usecase = SignUpWithEmailAndPassword(mockAuthRepository);

      // act
      final result = await usecase.call('email', 'password');

      // assert
      verify(() => mockAuthRepository.signUpWithEmailAndPassword(
          'email', 'password')).called(1);
      expect(result, const Left(ParamsFailure("Sign up failed")));
    });
  });
}
