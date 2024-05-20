import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/auth_response.dart';

abstract class AuthRepository {
  Future<Either<Failure, AuthResponse>> signInWithEmailAndPassword(
      String email, String password);

  Future<Either<Failure, AuthResponse>> signUpWithEmailAndPassword(
      String email, String password);
}
