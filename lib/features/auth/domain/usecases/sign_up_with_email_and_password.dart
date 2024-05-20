import 'package:dartz/dartz.dart';
import 'package:kwadra/features/auth/domain/repositories/auth_repository.dart';

import '../../../../core/error/failure.dart';
import '../entities/auth_response.dart';

class SignUpWithEmailAndPassword {
  final AuthRepository _authRepository;

  SignUpWithEmailAndPassword(this._authRepository);

  Future<Either<Failure, AuthResponse>> call(String email, String password) {
    return _authRepository.signUpWithEmailAndPassword(email, password);
  }
}
