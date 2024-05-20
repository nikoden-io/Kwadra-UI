import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kwadra/core/error/failure.dart';
import 'package:kwadra/features/auth/data/data_sources/firebase_auth_data_source.dart';
import 'package:kwadra/features/auth/data/repositories/auth_repository_firebase.dart';
import 'package:kwadra/features/auth/domain/entities/auth_response.dart';
import 'package:mocktail/mocktail.dart';

class MockFirebaseAuthDataSource extends Mock
    implements FirebaseAuthDataSource {}

class MockUser extends Mock implements User {}

void main() {
  group('AuthRepositoryFirebase', () {
    late AuthRepositoryFirebase authRepositoryKwadraApi;
    late FirebaseAuthDataSource mockKapiAuthDataSource;
    late User mockUser;

    setUpAll(() {
      mockKapiAuthDataSource = MockFirebaseAuthDataSource();
      authRepositoryKwadraApi = AuthRepositoryFirebase(mockKapiAuthDataSource);
      mockUser = MockUser();
    });

    //// SIGN IN ////
    test('should call once and return success', () async {
      // arrange
      when(() => mockKapiAuthDataSource.signInWithEmailAndPassword(
          'valid@mail.com', 'password')).thenAnswer((_) async => mockUser);

      // act
      final result = await authRepositoryKwadraApi.signInWithEmailAndPassword(
          'valid@mail.com', 'password');

      // assert
      verify(() => authRepositoryKwadraApi.signInWithEmailAndPassword(
          'valid@mail.com', 'password')).called(1);
      expect(result, const Right(AuthResponse("Sign in success")));
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

    //// SIGN UP////
    test('should call once and return success', () async {
      // arrange
      when(() => mockKapiAuthDataSource.signUpWithEmailAndPassword(
          'valid@mail.com', 'password')).thenAnswer((_) async => mockUser);

      // act
      final result = await authRepositoryKwadraApi.signUpWithEmailAndPassword(
          'valid@mail.com', 'password');

      // assert
      verify(() => authRepositoryKwadraApi.signUpWithEmailAndPassword(
          'valid@mail.com', 'password')).called(1);
      expect(result, const Right(AuthResponse("Sign up success")));
    });

    test('should return an error with invalid email', () async {
      // arrange

      // act
      final result = await authRepositoryKwadraApi.signUpWithEmailAndPassword(
          'invalid-email', 'password');

      // assert
      verifyNever(() =>
          mockKapiAuthDataSource.signUpWithEmailAndPassword(any(), any()));
      expect(result, const Left(ParamsFailure("Invalid email format")));
    });

    test('should return an error when password is not at least 8 character',
        () async {
      // arrange

      // act
      final result = await authRepositoryKwadraApi.signUpWithEmailAndPassword(
          'valid@mail.com', 'short');

      // assert
      verifyNever(() =>
          mockKapiAuthDataSource.signUpWithEmailAndPassword(any(), any()));
      expect(result, const Left(ParamsFailure("Invalid password length")));
    });
  });
}
