import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubits/auth_cubit.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController(
    text: 'abc@wp.pl',
  );
  final TextEditingController passwordController = TextEditingController(
    text: 'abc@wp.pl',
  );

  LoginPage({super.key});

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
                    const SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Go Back'),
                    ),
                    const SizedBox(height: 16.0),
                    ElevatedButton(
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
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    controller: emailController,
                    decoration: const InputDecoration(labelText: 'Email'),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 16.0),
                  TextField(
                    controller: passwordController,
                    decoration: const InputDecoration(labelText: 'Password'),
                    obscureText: true,
                  ),
                  const SizedBox(height: 32.0),
                  if (state is AuthLoggingInState)
                    const CircularProgressIndicator()
                  else
                    ElevatedButton(
                      onPressed: () {
                        final email = emailController.text.trim();
                        final password = passwordController.text.trim();
                        context.read<AuthCubit>().login(email, password);
                      },
                      child: const Text('Login'),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
