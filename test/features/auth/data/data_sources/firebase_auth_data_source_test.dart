import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kwadra/features/auth/data/data_sources/firebase_auth_data_source.dart';
import 'package:mocktail/mocktail.dart';

class MockUserCredential extends Mock implements UserCredential {}

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockUser extends Mock implements User {}

void main() {
  group('KapiAuthDataSourceImpl', () {
    late FirebaseAuthDataSourceImpl dataSource;
    late MockUserCredential mockUserCredential;
    late MockFirebaseAuth mockFirebaseAuth;
    late MockUser mockUser;

    setUpAll(() {
      registerFallbackValue(Uri.parse(''));
    });

    setUp(() {
      mockUserCredential = MockUserCredential();
      mockUser = MockUser();
      mockFirebaseAuth = MockFirebaseAuth();
      dataSource = FirebaseAuthDataSourceImpl(firebaseAuth: mockFirebaseAuth);
    });

    //// SIGN IN ////
    test('should return success when the response code is 200', () async {
      // arrange
      when(() => mockFirebaseAuth.signInWithEmailAndPassword(
          email: 'valid@mail.com',
          password: 'password')).thenAnswer((_) async => mockUserCredential);

      when(() => mockUserCredential.user).thenReturn(mockUser);

      // act
      final result = await dataSource.signInWithEmailAndPassword(
          'valid@mail.com', 'password');

      // assert
      expect(result, mockUser);
      verify(() => mockFirebaseAuth.signInWithEmailAndPassword(
          email: 'valid@mail.com', password: 'password')).called(1);
    });

    test('should throw an exception when the response code is not 200',
        () async {
      // arrange
      when(() => mockFirebaseAuth.signInWithEmailAndPassword(
              email: 'valid@mail.com', password: 'password'))
          .thenThrow(FirebaseAuthException(code: 'wrong-password'));

      // act
      expect(
        () async => await dataSource.signInWithEmailAndPassword(
            'valid@mail.com', 'password'),
        throwsA(isA<FirebaseAuthException>()),
      );

      // assert
      verify(() => mockFirebaseAuth.signInWithEmailAndPassword(
          email: 'valid@mail.com', password: 'password')).called(1);
    });

    //// SIGN UP ////
    test('should return success when the response code is 200', () async {
      // arrange
      when(() => mockFirebaseAuth.createUserWithEmailAndPassword(
          email: 'valid@mail.com',
          password: 'password')).thenAnswer((_) async => mockUserCredential);

      when(() => mockUserCredential.user).thenReturn(mockUser);

      // act
      final result = await dataSource.signUpWithEmailAndPassword(
          'valid@mail.com', 'password');

      // assert
      expect(result, mockUser);
      verify(() => mockFirebaseAuth.createUserWithEmailAndPassword(
          email: 'valid@mail.com', password: 'password')).called(1);
    });

    test('should throw an exception when the response code is not 200',
        () async {
      // arrange
      when(() => mockFirebaseAuth.createUserWithEmailAndPassword(
              email: 'valid@mail.com', password: 'password'))
          .thenThrow(FirebaseAuthException(code: 'wrong-password'));

      // act
      expect(
        () async => await dataSource.signUpWithEmailAndPassword(
            'valid@mail.com', 'password'),
        throwsA(isA<FirebaseAuthException>()),
      );

      // assert
      verify(() => mockFirebaseAuth.createUserWithEmailAndPassword(
          email: 'valid@mail.com', password: 'password')).called(1);
    });
  });
}
