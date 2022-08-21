import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final firebaseAuthProvider = Provider<FirebaseAuth>((ref) {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  return firebaseAuth;
});
