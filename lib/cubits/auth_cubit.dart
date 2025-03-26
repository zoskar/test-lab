import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthState {}

class AuthLoggedOutState extends AuthState {
  final String? errorMessage;

  AuthLoggedOutState({this.errorMessage});
}

class AuthLoggingInState extends AuthState {}

class AuthLoggedInState extends AuthState {
  final User user;

  AuthLoggedInState(this.user);
}

class AuthCubit extends Cubit<AuthState> {
  final FirebaseAuth _firebaseAuth;

  AuthCubit(this._firebaseAuth) : super(AuthLoggedOutState());

  Future<void> login(String email, String password) async {
    emit(AuthLoggingInState());
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(AuthLoggedInState(userCredential.user!));
    } catch (e) {
      emit(AuthLoggedOutState(errorMessage: e.toString()));
    }
  }

  Future<void> logout() async {
    try {
      await _firebaseAuth.signOut();
      emit(AuthLoggedOutState()); // Emit logged out state
    } catch (_) {
      // Handle logout failure if necessary
    }
  }
}
