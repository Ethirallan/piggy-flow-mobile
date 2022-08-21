import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart';
import 'package:piggy_flow_mobile/helpers/api_helper.dart';
import 'package:piggy_flow_mobile/helpers/firebase_code_to_message.dart';
import 'package:piggy_flow_mobile/providers/es_message_provider.dart';
import 'package:piggy_flow_mobile/providers/firebase_auth_provider.dart';
import 'package:piggy_flow_mobile/providers/http_provider.dart';

class AuthPage extends HookConsumerWidget {
  const AuthPage({Key? key}) : super(key: key);

  Duration get loginTime => const Duration(milliseconds: 2250);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future<String?> _login(LoginData data) async {
      try {
        await ref.read(firebaseAuthProvider).signInWithEmailAndPassword(
              email: data.name,
              password: data.password,
            );

        return null;
      } on FirebaseAuthException catch (e) {
        return firebaseCodeToMessage(e);
      } catch (e) {
        ref.read(esMessageProvider.state).state = const ESMessage(
          'messages_login_error',
          Colors.red,
        );
        return 'Error';
      }
    }

    Future<String?> _register(SignupData data) async {
      if (data.name != null || data.password == null) {
        try {
          await ref.read(firebaseAuthProvider).createUserWithEmailAndPassword(
                email: data.name!,
                password: data.password!,
              );

          Response res = await createNewUser(ref.read(httpProvider));

          if (res.statusCode == 200 || res.statusCode == 201) {
            ref.read(firebaseAuthProvider).currentUser!.sendEmailVerification();
            ref.read(firebaseAuthProvider).currentUser!.updateDisplayName(
                  data.additionalSignupData?['username'] ?? data.name,
                );

            return null;
          } else {
            ref.read(firebaseAuthProvider).currentUser!.delete();

            return 'Error';
          }
        } on FirebaseAuthException catch (e) {
          return firebaseCodeToMessage(e);
        } catch (e) {
          if (ref.read(firebaseAuthProvider).currentUser != null) {
            ref.read(firebaseAuthProvider).currentUser?.delete();
          }
          return 'Error';
        }
      }
      return null;
    }

    Future<String?> _resetPassword(String name) async {
      ref.read(firebaseAuthProvider).sendPasswordResetEmail(email: name);
      return null;
    }

    return FlutterLogin(
      title: 'Piggy Flow',
      onLogin: _login,
      onSignup: _register,
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacementNamed('confirm_email');
      },
      onRecoverPassword: _resetPassword,
      additionalSignupFields: const [
        UserFormField(keyName: 'displayName', displayName: 'Username'),
      ],
    );
  }
}
