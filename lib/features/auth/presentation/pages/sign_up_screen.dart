import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../bloc/auth_bloc.dart';

class SignUpScreen extends StatelessWidget {
  final String email;

  const SignUpScreen({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign Up')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Sign Up Page'),
            if (email.isNotEmpty) Text('Email: $email'),
            ElevatedButton(
              key: const Key('signUpButton'),
              onPressed: () {
                BlocProvider.of<AuthBloc>(context)
                    .add(SignUpRequested(email, 'password123'));
              },
              child: const Text('Sign Up'),
            ),
            ElevatedButton(
              key: const Key('backToSignInButton'),
              onPressed: () {
                if (GoRouter.of(context).canPop()) {
                  context.pop();
                } else {
                  context.go('/');
                }
              },
              child: const Text('Back to Sign In'),
            ),
          ],
        ),
      ),
    );
  }
}
