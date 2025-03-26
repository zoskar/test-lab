import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_lab/cubits/auth_cubit.dart';
import 'package:test_lab/pages/login/login_page.dart';

class AuthTile extends StatelessWidget {
  const AuthTile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, authState) {
        final bool isLoggedIn = authState is AuthLoggedInState;
        final String title = isLoggedIn ? 'Logout' : 'Login';
        final IconData icon = isLoggedIn ? Icons.logout : Icons.login;

        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: isLoggedIn ? Colors.green.shade100 : Colors.blue.shade100,
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(
                color:
                    isLoggedIn ? Colors.green.shade300 : Colors.blue.shade300,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: 40.0,
                  color:
                      isLoggedIn ? Colors.green.shade700 : Colors.blue.shade700,
                ),
                const SizedBox(height: 8.0),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
