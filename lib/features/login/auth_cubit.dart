import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
  final GoogleSignIn _googleSignIn = GoogleSignIn();

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
      emit(AuthLoggedOutState());
    } catch (_) {
      // Handle logout failure if necessary
    }
  }

  Future<void> signInWithGoogle() async {
    emit(AuthLoggingInState());
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        emit(AuthLoggedOutState());
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await _firebaseAuth
          .signInWithCredential(credential);

      emit(AuthLoggedInState(userCredential.user!));
    } catch (e) {
      emit(AuthLoggedOutState(errorMessage: e.toString()));
    }
  }
}
