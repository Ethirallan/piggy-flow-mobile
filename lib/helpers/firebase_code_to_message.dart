import 'package:firebase_auth/firebase_auth.dart';

String firebaseCodeToMessage(FirebaseAuthException error) {
  switch (error.code) {
    case 'account-exists-with-different-credential':
      return 'An account already exists.';
    case 'email-already-in-use':
      return 'Email is already used. Please, log in.';
    case 'wrong-password':
      return 'Wrong password! Please, try again.';
    case 'user-not-found':
      return 'User does not exist!';
    case 'user-disabled':
      return 'User is blocked. Please, contact support.';
    case 'operation-not-allowed':
      return 'An error occurred while communicating with the server!';
    case 'invalid-email':
      return 'Invalid email address!';
    default:
      return 'Error logging in! Please try again.';
  }
}
