import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SignUpScreen extends StatelessWidget {
  final String email;

  const SignUpScreen({Key? key, required this.email}) : super(key: key);

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
