import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kwadra/core/error/failure.dart';
import 'package:kwadra/features/auth/domain/entities/sign_in_response.dart';
import 'package:kwadra/features/auth/domain/repositories/auth_repository.dart';
import 'package:kwadra/features/auth/domain/usecases/sign_in_with_email_and_password.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  group('SignInWithEmailAndPassword', () {
    late SignInWithEmailAndPassword usecase;
    late AuthRepository mockAuthRepository;

    setUpAll(() {
      mockAuthRepository = MockAuthRepository();
    });

    test('should call once and return success', () async {
      // arrange
      when(() => mockAuthRepository.signInWithEmailAndPassword(
              'email', 'password'))
          .thenAnswer(
              (_) async => const Right(SignInResponse("Sign in success")));
      usecase = SignInWithEmailAndPassword(mockAuthRepository);

      // act
      final result = await usecase.call('email', 'password');

      // assert
      verify(() => mockAuthRepository.signInWithEmailAndPassword(
          'email', 'password')).called(1);
      expect(result, const Right(SignInResponse("Sign in success")));
    });

    test('should call once and return success', () async {
      // arrange
      when(() => mockAuthRepository.signInWithEmailAndPassword(
              'email', 'password'))
          .thenAnswer((_) async => const Left(ParamsFailure("Sign in failed")));
      usecase = SignInWithEmailAndPassword(mockAuthRepository);

      // act
      final result = await usecase.call('email', 'password');

      // assert
      verify(() => mockAuthRepository.signInWithEmailAndPassword(
          'email', 'password')).called(1);
      expect(result, const Left(ParamsFailure("Sign in failed")));
    });
  });
}
