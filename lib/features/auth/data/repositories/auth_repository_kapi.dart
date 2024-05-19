import 'package:dartz/dartz.dart';
import 'package:kwadra/features/auth/data/data_sources/kapi_auth_data_source.dart';

import '../../../../core/error/failure.dart';
import '../../domain/entities/sign_in_response.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryKwadraApi implements AuthRepository {
  final KapiAuthDataSource _kapiAuthDataSource;
  final validEmailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

  AuthRepositoryKwadraApi(this._kapiAuthDataSource);

  @override
  Future<Either<Failure, SignInResponse>> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      if (password.length < 8) {
        return const Left(ParamsFailure("Invalid password length"));
      }

      if (!_isValidEmail(email)) {
        return const Left(ParamsFailure("Invalid email format"));
      }

      String response =
          await _kapiAuthDataSource.signInWithEmailAndPassword(email, password);
      if (response == 'Sign in failed') return Left(ParamsFailure(response));
      return Right(SignInResponse(response));
    } catch (error) {
      return Left(ParamsFailure(error.toString()));
    }
  }

  bool _isValidEmail(String email) {
    final regex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    return regex.hasMatch(email);
  }
}
