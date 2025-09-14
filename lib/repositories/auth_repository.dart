import 'package:firebase_auth/firebase_auth.dart' as fb;
import '../models/app_user.dart';


abstract class AuthRepository {
  /// Current user or null
  AppUser? get currentUser;


  /// Stream of auth state changes (sign-in/sign-out)
  Stream<AppUser?> authStateChanges();


  /// Email & password
  Future<AppUser?> signInWithEmailPassword(String email, String password);
  Future<AppUser?> signUpWithEmailPassword(
      String email,
      String password, {
        String? displayName,
      });
  Future<void> sendEmailVerification();
  Future<void> sendPasswordResetEmail(String email);


  /// Google
  Future<AppUser?> signInWithGoogle();


  /// Phone
  Future<void> verifyPhoneNumber({
    required String phoneNumber,
    Duration timeout = const Duration(seconds: 60),
    required void Function(String verificationId, int? resendToken) codeSent,
    required void Function(AppUser user) verificationCompleted,
    required void Function(String verificationId) codeAutoRetrievalTimeout,
    int? forceResendingToken,
  });
  Future<AppUser?> signInWithSmsCode(String verificationId, String smsCode);


  /// Sign out
  Future<void> signOut();
}