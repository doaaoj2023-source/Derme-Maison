import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:google_sign_in/google_sign_in.dart';

class AuthController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserCredential> login(
    String email,
    String password,
  ) async {
    return await _auth.signInWithEmailAndPassword(
      email: email.trim(),
      password: password.trim(),
    );
  }

  Future<UserCredential> signup(
    String email,
    String password,
    String name,
  ) async {
    final cred = await _auth.createUserWithEmailAndPassword(
      email: email.trim(),
      password: password.trim(),
    );

    await FirebaseFirestore.instance
        .collection('users')
        .doc(cred.user!.uid)
        .set({
      'email': cred.user!.email,
      'name': name,
      'role': 'user',
    });

    return cred;
  }

  // ============================
 
  // ============================
  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleUser =
        await googleSignIn.signIn();

    if (googleUser == null) {
      throw Exception("Google sign-in cancelled");
    }

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

    // نحفظ المستخدم في 
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userCredential.user!.uid)
        .set({
      'email': userCredential.user!.email,
      'name': userCredential.user!.displayName ?? '',
      'role': 'user',
    }, SetOptions(merge: true));

    return userCredential;
  }
}