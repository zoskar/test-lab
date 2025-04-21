import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthState {}

class AuthLoggedOutState extends AuthState {
  AuthLoggedOutState({this.errorMessage});
  final String? errorMessage;
}

class AuthLoggingInState extends AuthState {}

class AuthLoggedInState extends AuthState {
  AuthLoggedInState(this.user);
  final User user;
}

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._firebaseAuth) : super(AuthLoggedOutState());
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> login(String email, String password) async {
    emit(AuthLoggingInState());
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(AuthLoggedInState(userCredential.user!));
    } catch (err) {
      emit(AuthLoggedOutState(errorMessage: err.toString()));
    }
  }

  Future<void> logout() async {
    await _firebaseAuth.signOut();
    emit(AuthLoggedOutState());
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
    } catch (err) {
      emit(AuthLoggedOutState(errorMessage: err.toString()));
    }
  }
}
