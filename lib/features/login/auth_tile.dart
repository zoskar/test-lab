import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_lab/features/login/auth_cubit.dart';
import 'package:test_lab/features/login/login_page.dart';
import 'package:test_lab/widgets/tile.dart';

class AuthTile extends StatelessWidget {
  const AuthTile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, authState) {
        final bool isLoggedIn = authState is AuthLoggedInState;
        final String title = isLoggedIn ? 'Logout' : 'Login';
        final IconData icon = isLoggedIn ? Icons.logout : Icons.login;

        return TLTile(
          icon: icon,
          text: title,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),
            );
          },
        );
      },
    );
  }
}
