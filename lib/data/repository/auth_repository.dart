import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  Future<UserCredential> createUser(String email, String password);
  Future<UserCredential> signInUser(String email, String password);
  Future<void> signOut();
  Future<User?> getCurrentUser();
}

