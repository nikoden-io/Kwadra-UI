import 'package:equatable/equatable.dart';

class SignInResponse extends Equatable {
  final String message;

  const SignInResponse(this.message);

  @override
  List<Object> get props => [message];
}
