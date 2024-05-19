import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../bloc/auth_bloc.dart';

class SignInForm extends StatelessWidget {
  const SignInForm({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          TextField(
            controller: emailController,
            decoration: const InputDecoration(labelText: 'Email'),
          ),
          TextField(
            controller: passwordController,
            decoration: const InputDecoration(labelText: 'Password'),
            obscureText: true,
          ),
          ElevatedButton(
            onPressed: () {
              context.read<AuthBloc>().add(
                    SignInRequested(
                      emailController.text,
                      passwordController.text,
                    ),
                  );
            },
            child: const Text('Sign In'),
          ),
          TextButton(
            onPressed: () {
              context.go('/signup?email=$emailController.text');
            },
            child: const Text('Sign Up'),
          ),
        ],
      ),
    );
  }
}
