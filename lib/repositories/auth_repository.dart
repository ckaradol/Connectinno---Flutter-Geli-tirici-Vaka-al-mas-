import 'package:firebase_auth/firebase_auth.dart' as fb;
import '../models/app_user.dart';


abstract class AuthRepository {
  AppUser? get currentUser;


  Stream<AppUser?> authStateChanges();


  Future<AppUser?> signInWithEmailPassword(String email, String password);
  Future<AppUser?> signInWithAnonymous();
  Future<AppUser?> signUpWithEmailPassword(
      String email,
      String password, {
        String? displayName,
      });
  Future<void> sendPasswordResetEmail(String email);


  Future<AppUser?> signInWithGoogle();
  Future<bool> forgotPassword(String mail);



  Future<AppUser?> signInWithSmsCode(String verificationId, String smsCode);


  Future<void> signOut();
}