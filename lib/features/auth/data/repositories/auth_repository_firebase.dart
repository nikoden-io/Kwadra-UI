import 'package:dartz/dartz.dart';
import 'package:kwadra/features/auth/data/data_sources/firebase_auth_data_source.dart';

import '../../../../core/error/failure.dart';
import '../../domain/entities/auth_response.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryFirebase implements AuthRepository {
  final FirebaseAuthDataSource firebaseAuthDataSource;
  final validEmailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

  AuthRepositoryFirebase(this.firebaseAuthDataSource);

  @override
  Future<Either<Failure, AuthResponse>> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      if (password.length < 8) {
        return const Left(ParamsFailure("Invalid password length"));
      }

      if (!_isValidEmail(email)) {
        return const Left(ParamsFailure("Invalid email format"));
      }

      final user = await firebaseAuthDataSource.signInWithEmailAndPassword(
          email, password);
      if (user == null) return const Left(ParamsFailure("Sign in failed"));

      return const Right(AuthResponse('Sign in success'));
    } catch (error) {
      return Left(ParamsFailure(error.toString()));
    }
  }

  @override
  Future<Either<Failure, AuthResponse>> signUpWithEmailAndPassword(
      String email, String password) async {
    try {
      if (password.length < 8) {
        return const Left(ParamsFailure("Invalid password length"));
      }

      if (!_isValidEmail(email)) {
        return const Left(ParamsFailure("Invalid email format"));
      }

      final user = await firebaseAuthDataSource.signUpWithEmailAndPassword(
          email, password);
      if (user == null) return const Left(ParamsFailure("Sign up failed"));
      return const Right(AuthResponse('Sign up success'));
    } catch (error) {
      return Left(ParamsFailure(error.toString()));
    }
  }

  bool _isValidEmail(String email) {
    final regex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    return regex.hasMatch(email);
  }
}
