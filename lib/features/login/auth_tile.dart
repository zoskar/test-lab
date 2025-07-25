import 'package:common_ui/widgets/tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_lab/features/login/auth_cubit.dart';
import 'package:test_lab/features/login/login_page.dart';
import 'package:test_lab/keys.dart';

class AuthTile extends StatelessWidget {
  const AuthTile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, authState) {
        final isLoggedIn = authState is AuthLoggedInState;
        final title = isLoggedIn ? 'Logout' : 'Login';
        final IconData icon = isLoggedIn ? Icons.logout : Icons.login;

        return TLTile(
          key: keys.homePage.loginTile,
          icon: icon,
          text: title,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute<void>(builder: (context) => LoginPage()),
            );
          },
        );
      },
    );
  }
}
