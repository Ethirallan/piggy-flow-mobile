import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final firebaseAuthProvider = Provider<FirebaseAuth>((ref) {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  return firebaseAuth;
});

final authProvider = Provider<AuthUtility>((ref) {
  final firebaseAuth = ref.watch(firebaseAuthProvider);
  return AuthUtility(firebaseAuth: firebaseAuth);
});

class AuthUtility {
  AuthUtility({
    required this.firebaseAuth,
  });

  final FirebaseAuth firebaseAuth;

  Future<UserCredential?> login(BuildContext context, email, password) async {
    UserCredential? user;
    try {
      user = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      print(e);
    }
    return user;
  }

  Future<UserCredential?> register(BuildContext context, email, password) async {
    UserCredential? user;
    try {
      user = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      print(e);
    }
    return user;
  }

  Future<bool> logout() async {
    try {
      firebaseAuth.signOut();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> sendEmailVerification() async {
    try {
      firebaseAuth.currentUser?.sendEmailVerification();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> sendPasswordResetEmail(String email) async {
    try {
      firebaseAuth.sendPasswordResetEmail(email: email);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> updateDisplayName(String? name) async {
    try {
      firebaseAuth.currentUser?.updateDisplayName(name);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<String> getToken() async {
    String token = '';
    try {
      token = await firebaseAuth.currentUser!.getIdToken();
    } catch (e) {
      print(e);
    }
    return token;
  }

  User? getCurrentUser() {
    User? user;
    try {
      user = firebaseAuth.currentUser;
    } catch (e) {
      print(e);
    }
    return user;
  }

  void deleteCurrentUser() {
    try {
      firebaseAuth.currentUser?.delete();
    } catch (e) {
      print(e);
    }
  }
}
