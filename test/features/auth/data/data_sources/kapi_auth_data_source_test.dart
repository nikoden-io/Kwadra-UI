import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:kwadra/features/auth/data/data_sources/kapi_auth_data_source.dart';
import 'package:mocktail/mocktail.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  group('KapiAuthDataSourceImpl', () {
    late KapiAuthDataSourceImpl dataSource;
    late MockHttpClient mockHttpClient;

    setUpAll(() {
      registerFallbackValue(Uri.parse(''));
    });

    setUp(() {
      mockHttpClient = MockHttpClient();
      dataSource = KapiAuthDataSourceImpl(client: mockHttpClient);
    });

    test('should return success when the response code is 200', () async {
      // arrange
      when(() => mockHttpClient.post(
            any(),
            body: any(named: 'body'),
          )).thenAnswer((_) async => http.Response('Sign in success', 200));

      // act
      final result = await dataSource.signInWithEmailAndPassword(
          'valid@mail.com', 'password');

      // assert
      expect(result, 'Sign in success');
      verify(() => mockHttpClient.post(
            Uri.parse('https://api.kwadra.com/auth/signin'),
            body: {
              'email': 'valid@mail.com',
              'password': 'password',
            },
          )).called(1);
    });

    test('should throw an exception when the response code is not 200',
        () async {
      // arrange
      when(() => mockHttpClient.post(
            any(),
            body: any(named: 'body'),
          )).thenAnswer((_) async => http.Response('Sign in failed', 400));

      // act
      expect(
        () async => await dataSource.signInWithEmailAndPassword(
            'valid@mail.com', 'password'),
        throwsA(isA<Exception>()),
      );

      // assert
      verify(() => mockHttpClient.post(
            Uri.parse('https://api.kwadra.com/auth/signin'),
            body: {
              'email': 'valid@mail.com',
              'password': 'password',
            },
          )).called(1);
    });
  });
}
