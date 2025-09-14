import 'package:firebase_auth/firebase_auth.dart' as fb;


class AppUser {
  final String uid;
  final String? email;
  final String? displayName;
  final String? phoneNumber;
  final String? photoURL;
  final bool isEmailVerified;


  const AppUser({
    required this.uid,
    this.email,
    this.displayName,
    this.phoneNumber,
    this.photoURL,
    this.isEmailVerified = false,
  });


  factory AppUser.fromFirebaseUser(fb.User user) => AppUser(
    uid: user.uid,
    email: user.email,
    displayName: user.displayName,
    phoneNumber: user.phoneNumber,
    photoURL: user.photoURL,
    isEmailVerified: user.emailVerified,
  );
}