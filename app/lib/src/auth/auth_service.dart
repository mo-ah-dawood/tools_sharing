import 'package:cloud_firestore/cloud_firestore.dart' hide Transaction;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tools_sharing/src/auth/user.dart';

class AuthService {
  static String collection = "users";
  User? get currentUser => FirebaseAuth.instance.currentUser;
  Stream<User?> userChanges() => FirebaseAuth.instance.userChanges();
  FirebaseFirestore get db => FirebaseFirestore.instance;

  Future reloadUser() async {
    await currentUser?.reload();
  }

  Future<User> login(String email, String password) async {
    var res = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    if (res.user == null) {
      throw Exception("Can not login please try agian");
    }
    return res.user!;
  }

  Future updateUserData(UserModel user, UserModel oldUser) async {
    return db.collection(collection).doc(user.id).update(user.toMap());
  }

  Future<User> loginWithGoogle() async {
    late UserCredential res;
    if (kIsWeb ||
        defaultTargetPlatform == TargetPlatform.android ||
        defaultTargetPlatform == TargetPlatform.iOS) {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      res = await FirebaseAuth.instance.signInWithCredential(credential);
    } else {
      res = await FirebaseAuth.instance.signInWithPopup(GoogleAuthProvider());
    }

    if (res.user == null) {
      throw Exception("Can not login please try agian");
    }
    return res.user!;
  }

  Future<User> linkWithGoogle() async {
    late UserCredential res;
    if (kIsWeb ||
        defaultTargetPlatform == TargetPlatform.android ||
        defaultTargetPlatform == TargetPlatform.iOS) {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      res = await currentUser!.linkWithCredential(credential);
    } else {
      res = await currentUser!.linkWithPopup(GoogleAuthProvider());
    }

    if (res.user == null) {
      throw Exception("Can not login please try agian");
    }
    return res.user!;
  }

  Future<User> register(String email, String name, String password) async {
    final res = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    if (res.user == null) {
      throw Exception("Can not register please try agian");
    }
    db.collection(collection).doc(res.user!.uid).set({
      'name': name,
      'email': email,
    });
    return res.user!;
  }

  Future<void> sendVerificationCode() async {
    await currentUser?.sendEmailVerification();
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<void> sendForgotPasswordCode(String email) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }

  Future<void> resetPassword(String email, String code, String password) async {
    await FirebaseAuth.instance
        .confirmPasswordReset(code: code, newPassword: password);
  }
}
