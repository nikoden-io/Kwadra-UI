import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/sign_in_response.dart';

abstract class AuthRepository {
  Future<Either<Failure, SignInResponse>> signInWithEmailAndPassword(
      String email, String password);
}
