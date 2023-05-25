import 'package:firebase_auth/firebase_auth.dart' as fa;
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:piggy_flow_mobile/helpers/firebase_code_to_message.dart';
import 'package:piggy_flow_mobile/models/user.dart';
import 'package:piggy_flow_mobile/providers/es_message_provider.dart';
import 'package:piggy_flow_mobile/providers/firebase_auth_provider.dart';
import 'package:piggy_flow_mobile/providers/http_provider.dart';

class AuthPage extends HookConsumerWidget {
  const AuthPage({Key? key}) : super(key: key);

  Duration get loginTime => const Duration(milliseconds: 2250);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future<String?> login(LoginData data) async {
      try {
        await ref.read(authProvider).login(
              context,
              data.name,
              data.password,
            );

        return null;
      } on fa.FirebaseAuthException catch (e) {
        return firebaseCodeToMessage(e);
      } catch (e) {
        ref.read(esMessageProvider.state).state = const ESMessage(
          'messages_login_error',
          Colors.red,
        );
        return 'Error';
      }
    }

    Future<String?> register(SignupData data) async {
      if (data.name != null || data.password == null) {
        try {
          await ref.read(authProvider).register(
                context,
                data.name!,
                data.password!,
              );

          User? user = await ref.read(httpProvider).authenticateUser();

          if (user != null) {
            ref.read(authProvider).sendEmailVerification();
            ref.read(authProvider).updateDisplayName(
                  data.additionalSignupData?['username'] ?? data.name,
                );

            return null;
          } else {
            ref.read(firebaseAuthProvider).currentUser!.delete();

            return 'Error';
          }
        } on fa.FirebaseAuthException catch (e) {
          return firebaseCodeToMessage(e);
        } catch (e) {
          if (ref.read(authProvider).getCurrentUser() != null) {
            ref.read(authProvider).deleteCurrentUser();
          }
          return 'Error';
        }
      }
      return null;
    }

    Future<String?> resetPassword(String name) async {
      ref.read(authProvider).sendPasswordResetEmail(name);
      return null;
    }

    return FlutterLogin(
      title: 'Piggy Flow',
      logo: 'assets/piggy-flow-icon.png',
      onLogin: login,
      onSignup: register,
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacementNamed('confirm_email');
      },
      onRecoverPassword: resetPassword,
      additionalSignupFields: const [
        UserFormField(keyName: 'displayName', displayName: 'Username'),
      ],
      theme: LoginTheme(
        primaryColor: const Color(0xFFFE3F58),
        switchAuthTextColor: Theme.of(context).primaryColor,
        // pageColorLight: const Color(0xFFFFF3F2),
      ),
    );
  }
}
