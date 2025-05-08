import 'package:firebase_auth/firebase_auth.dart';
import 'package:ifgf_apps/data/repository/auth_repository.dart';

class FirebaseAuthService implements AuthRepository {
  final FirebaseAuth _auth;

  FirebaseAuthService({FirebaseAuth? auth}) : _auth = auth ?? FirebaseAuth.instance;

  @override
  Future<UserCredential> createUser(String? email, String? password) async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(
        email: email ?? "",
        password: password ?? "",
      );
      return result;
    } on FirebaseAuthException catch (e) {
      throw Exception(_mapCreateUserError(e.code));
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<UserCredential> signInUser(String? email, String? password) async {
    try {
      final result = await _auth.signInWithEmailAndPassword(
        email: email ?? "",
        password: password ?? "",
      );
      return result;
    } on FirebaseAuthException catch (e) {
      throw Exception(_mapSignInError(e.code));
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      throw Exception("Logout failed. Please try again.");
    }
  }

  @override
  Future<User?> getCurrentUser() async {
    return _auth.userChanges().first;
  }

  String _mapCreateUserError(String code) {
    return switch (code) {
      "email-already-in-use" => "There already exists an account with the given email address.",
      "invalid-email" => "The email address is not valid.",
      "operation-not-allowed" => "Server error, please try again later.",
      "weak-password" => "The password is not strong enough.",
      _ => "Register failed. Please try again.",
    };
  }

  String _mapSignInError(String code) {
    return switch (code) {
      "invalid-email" => "The email address is not valid.",
      "user-disabled" => "User disabled.",
      "user-not-found" => "No user found with this email.",
      "wrong-password" => "Wrong email/password combination.",
      _ => "Login failed. Please try again.",
    };
  }
}
