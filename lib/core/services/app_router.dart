import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/pages/sign_in_screen.dart';
import '../../features/auth/presentation/pages/sign_up_screen.dart';

final GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SignInScreen(),
    ),
    GoRoute(
      path: '/signup',
      builder: (context, state) => SignUpScreen(
        email: state.uri.queryParameters['email'] ?? '',
      ),
    ),
  ],
);
