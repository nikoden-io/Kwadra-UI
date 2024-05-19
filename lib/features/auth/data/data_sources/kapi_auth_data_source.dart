import 'package:http/http.dart' as http;

abstract class KapiAuthDataSource {
  Future<String> signInWithEmailAndPassword(String email, String password);
}

class KapiAuthDataSourceImpl implements KapiAuthDataSource {
  final http.Client client;

  KapiAuthDataSourceImpl({required this.client});

  @override
  Future<String> signInWithEmailAndPassword(
      String email, String password) async {
    final response = await client.post(
      Uri.parse('https://api.kwadra.com/auth/signin'),
      body: {
        'email': email,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      return 'Sign in success';
    } else {
      throw Exception('Sign in failed');
    }
  }
}
