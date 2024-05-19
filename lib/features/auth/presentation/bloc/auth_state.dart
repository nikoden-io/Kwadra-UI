part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  final bool isLoading;

  const AuthState({this.isLoading = false});

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {
  const AuthLoading() : super(isLoading: true);
}

class AuthSuccess extends AuthState {
  final SignInResponse response;

  const AuthSuccess(this.response) : super(isLoading: false);

  @override
  List<Object> get props => [response];
}

class AuthFailure extends AuthState {
  final String message;

  const AuthFailure(this.message) : super(isLoading: false);

  @override
  List<Object> get props => [message];
}
