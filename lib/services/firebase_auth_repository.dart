import 'dart:async';


import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:noteapp/services/show_toast.dart';

import '../models/app_user.dart';
import '../repositories/auth_repository.dart';
import '../views/forgot_password_screen/screen/forgot_password_screen.dart';
import '../views/home_screen/screen/home_screen.dart';
import 'navigation_service.dart';

class FirebaseAuthRepository implements AuthRepository {
  final fb.FirebaseAuth _auth;

  FirebaseAuthRepository({fb.FirebaseAuth? auth}) : _auth = auth ?? fb.FirebaseAuth.instance;

  @override
  AppUser? get currentUser => _auth.currentUser == null ? null : AppUser.fromFirebaseUser(_auth.currentUser!);

  @override
  Stream<AppUser?> authStateChanges() => _auth.authStateChanges().map((u) => u == null ? null : AppUser.fromFirebaseUser(u));

  @override
  Future<AppUser?> signInWithEmailPassword(String email, String password) async {
    try {
      final cred = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return cred.user == null ? null : AppUser.fromFirebaseUser(cred.user!);
    } on fb.FirebaseAuthException catch (e) {
      showToast("Error", e.message ?? "", true);
      return null;
    }
  }

  @override
  Future<AppUser?> signUpWithEmailPassword(String email, String password, {String? displayName}) async {
    try {
      final cred = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      if (displayName != null && cred.user != null) {
        await cred.user!.updateDisplayName(displayName);
        await cred.user!.reload();
      }
      return cred.user == null ? null : AppUser.fromFirebaseUser(cred.user!);
    } on fb.FirebaseAuthException catch (e) {
      showToast("Error", e.message ?? "", true);
      return null;
    }
  }

  @override
  Future<void> sendEmailVerification() async {
    final user = _auth.currentUser;
    if (user == null) throw StateError('No current user');
    await user.sendEmailVerification();
  }

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  @override
  Future<AppUser?> signInWithGoogle() async {
    try {
      GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      final credential = fb.GoogleAuthProvider.credential(accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);
      final userCred = await _auth.signInWithCredential(credential);
      final user = userCred.user;
      if (user?.phoneNumber == null) {
        NavigationService.push(ForgotPasswordScreen());
      } else {
        NavigationService.push(HomeScreen());
      }
      return user == null ? null : AppUser.fromFirebaseUser(user);
    } on fb.FirebaseAuthException catch (e) {
      showToast("Error", e.message ?? "", true);
      return null;
    }

  }



  @override
  Future<AppUser?> signInWithSmsCode(String verificationId, String smsCode) async {
    try{
      final credential = fb.PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode);

      final currentUser = _auth.currentUser;
      fb.UserCredential userCred;

      if (currentUser != null) {
        userCred = await currentUser.linkWithCredential(credential);
      } else {
        userCred = await _auth.signInWithCredential(credential);
      }

      return userCred.user == null ? null : AppUser.fromFirebaseUser(userCred.user!);
    }on fb.FirebaseAuthException catch (e) {
      showToast("Error", e.message ?? "", true);
      return null;
    }

  }

  @override
  Future<void> signOut() async {
    await Future.wait([_auth.signOut(), GoogleSignIn().signOut()]);
  }

  @override
  Future<AppUser?> signInWithAnonymous() async {
    try {
      final cred = await _auth.signInAnonymously();
      return cred.user == null ? null : AppUser.fromFirebaseUser(cred.user!);
    } on fb.FirebaseAuthException catch (e) {
      showToast("Error", e.message ?? "", true);
      return null;
    }
  }
}
