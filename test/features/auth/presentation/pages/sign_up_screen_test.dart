import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kwadra/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:kwadra/features/auth/presentation/pages/sign_up_screen.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthBloc extends MockBloc<AuthEvent, AuthState> implements AuthBloc {}

void main() {
  testWidgets('SignUpScreen displays email and triggers sign up',
      (WidgetTester tester) async {
    final mockAuthBloc = MockAuthBloc();
    when(() => mockAuthBloc.state).thenReturn(AuthInitial());

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<AuthBloc>.value(
          value: mockAuthBloc,
          child: const SignUpScreen(email: 'test@example.com'),
        ),
      ),
    );

    expect(find.text('Sign Up Page'), findsOneWidget);
    expect(find.text('Email: test@example.com'), findsOneWidget);

    await tester.tap(find.byKey(const Key('signUpButton')));
    await tester.pump();

    verify(() => mockAuthBloc.add(
        const SignUpRequested('test@example.com', 'password123'))).called(1);
  });
}
