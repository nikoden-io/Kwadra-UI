import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kwadra/core/error/failure.dart';
import 'package:kwadra/features/auth/data/data_sources/kapi_auth_data_source.dart';
import 'package:kwadra/features/auth/data/repositories/auth_repository_kapi.dart';
import 'package:kwadra/features/auth/domain/entities/sign_in_response.dart';
import 'package:mocktail/mocktail.dart';

class MockKapiAuthDataSource extends Mock implements KapiAuthDataSource {}

void main() {
  group('AuthRepositoryKapi', () {
    late AuthRepositoryKwadraApi authRepositoryKwadraApi;
    late KapiAuthDataSource mockKapiAuthDataSource;

    setUpAll(() {
      mockKapiAuthDataSource = MockKapiAuthDataSource();
      authRepositoryKwadraApi = AuthRepositoryKwadraApi(mockKapiAuthDataSource);
    });

    test('should call once and return success', () async {
      // arrange
      when(() => mockKapiAuthDataSource.signInWithEmailAndPassword(
              'valid@mail.com', 'password'))
          .thenAnswer((_) async => 'Sign in success');

      // act
      final result = await authRepositoryKwadraApi.signInWithEmailAndPassword(
          'valid@mail.com', 'password');

      // assert
      verify(() => authRepositoryKwadraApi.signInWithEmailAndPassword(
          'valid@mail.com', 'password')).called(1);
      expect(result, const Right(SignInResponse("Sign in success")));
    });

    test('should return an error with invalid email', () async {
      // arrange

      // act
      final result = await authRepositoryKwadraApi.signInWithEmailAndPassword(
          'invalid-email', 'password');

      // assert
      verifyNever(() =>
          mockKapiAuthDataSource.signInWithEmailAndPassword(any(), any()));
      expect(result, const Left(ParamsFailure("Invalid email format")));
    });

    test('should return an error when password is not at least 8 character',
        () async {
      // arrange

      // act
      final result = await authRepositoryKwadraApi.signInWithEmailAndPassword(
          'valid@mail.com', 'short');

      // assert
      verifyNever(() =>
          mockKapiAuthDataSource.signInWithEmailAndPassword(any(), any()));
      expect(result, const Left(ParamsFailure("Invalid password length")));
    });
  });
}
