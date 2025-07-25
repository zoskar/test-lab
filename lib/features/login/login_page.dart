import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_lab/keys.dart';
import 'auth_cubit.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthLoggedOutState && state.errorMessage != null) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
          } else if (state is AuthLoggedInState) {
            Navigator.of(context).pop();
          }
        },
        child: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            if (state is AuthLoggedInState) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('You are logged in!'),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      key: keys.loginPage.goBackButton,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Go Back'),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      key: keys.loginPage.logoutButton,
                      onPressed: () {
                        context.read<AuthCubit>().logout();
                      },
                      child: const Text('Log Out'),
                    ),
                  ],
                ),
              );
            }

            // User is not logged in, show login form
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    key: keys.loginPage.loginField,
                    controller: emailController,
                    decoration: const InputDecoration(labelText: 'Email'),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    key: keys.loginPage.passwordField,
                    controller: passwordController,
                    decoration: const InputDecoration(labelText: 'Password'),
                    obscureText: true,
                  ),
                  const SizedBox(height: 32),
                  if (state is AuthLoggingInState)
                    const CircularProgressIndicator()
                  else
                    ElevatedButton(
                      key: keys.loginPage.loginButton,
                      onPressed: () {
                        final email = emailController.text.trim();
                        final password = passwordController.text.trim();
                        context.read<AuthCubit>().login(email, password);
                      },
                      child: const Text('Login'),
                    ),
                  if (Platform.isAndroid) ...[
                    const SizedBox(height: 24),
                    const Row(
                      children: [
                        Expanded(child: Divider()),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Text('OR'),
                        ),
                        Expanded(child: Divider()),
                      ],
                    ),
                    const SizedBox(height: 24),
                    OutlinedButton.icon(
                      key: keys.loginPage.googleSignInButton,
                      onPressed: () {
                        context.read<AuthCubit>().signInWithGoogle();
                      },
                      icon: Image.network(
                        'https://www.google.com/favicon.ico',
                        height: 24,
                        width: 24,
                      ),
                      label: const Text('Sign in with Google'),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 16,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
