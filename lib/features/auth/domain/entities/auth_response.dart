import 'package:equatable/equatable.dart';

class AuthResponse extends Equatable {
  final String message;

  const AuthResponse(this.message);

  @override
  List<Object> get props => [message];
}
