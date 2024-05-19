import 'package:dartz/dartz.dart';
import 'package:kwadra/features/auth/domain/repositories/auth_repository.dart';

import '../../../../core/error/failure.dart';
import '../entities/sign_in_response.dart';

class SignInWithEmailAndPassword {
  final AuthRepository _authRepository;

  SignInWithEmailAndPassword(this._authRepository);

  Future<Either<Failure, SignInResponse>> call(String email, String password) {
    return _authRepository.signInWithEmailAndPassword(email, password);
  }
}
