import 'package:equatable/equatable.dart';

class SignInData extends Equatable {
  final String email;
  final String password;

  const SignInData({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [email, password];
}
