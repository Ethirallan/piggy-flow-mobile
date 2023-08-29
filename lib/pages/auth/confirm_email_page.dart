import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:piggy_flow_mobile/providers/es_message_provider.dart';
import 'package:piggy_flow_mobile/providers/firebase_auth_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfirmEmailPage extends ConsumerStatefulWidget {
  const ConfirmEmailPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConfirmEmailPage> createState() => _ConfirmEmailPageState();
}

class _ConfirmEmailPageState extends ConsumerState<ConfirmEmailPage> {
  late Timer timer;

  void sendEmailVarificationEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? oldTs = prefs.getInt('emailLock');
    int ts = DateTime.now().millisecondsSinceEpoch;

    oldTs ??= ts - 80000;

    if (ts - oldTs <= 70000) {
      ref.read(esMessageProvider.state).state = ESMessage(
        'Email was just sent. Please try again after ${70 - (((ts - oldTs) / 1000).floor())} s.',
        Colors.red,
      );
      return;
    }

    ref.read(firebaseAuthProvider).currentUser!.sendEmailVerification();
    ts = DateTime.now().millisecondsSinceEpoch;

    prefs.setInt('emailLock', ts);

    ref.read(esMessageProvider.state).state = const ESMessage(
      'Email address conformation email has been successfully sent.',
      Colors.green,
    );
  }

  void checkIfConfirmed() async {
    await ref.read(firebaseAuthProvider).currentUser?.reload();
    bool? varified = ref.read(firebaseAuthProvider).currentUser?.emailVerified;
    if (varified ?? false) {
      ref.read(firebaseAuthProvider).currentUser;

      if (!mounted) return;
      Navigator.pushNamedAndRemoveUntil(
          context, 'statistics', (route) => false);
      ref.read(esMessageProvider.state).state = const ESMessage(
        'Successfully confirmed the email address.',
        Colors.green,
      );
    }
  }

  @override
  void initState() {
    timer = Timer.periodic(
      const Duration(seconds: 5),
      (Timer t) => checkIfConfirmed(),
    );
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: (context, constraints) {
        return SafeArea(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 26),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height -
                          72 -
                          MediaQuery.of(context).padding.vertical,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          height: 105,
                          width: 105,
                          decoration: const BoxDecoration(
                            color: Colors.blue,
                            shape: BoxShape.circle,
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.email_rounded,
                              size: 44,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 32.5,
                        ),
                        const Text(
                          'Email confirmation required',
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 16.5,
                        ),
                        const Padding(
                          padding: EdgeInsets.fromLTRB(9.5, 16.5, 9.5, 43),
                          child: Text(
                            'We have sent you an email for confirming your email address.',
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(
                          height: 68,
                        ),
                        ElevatedButton(
                          onPressed: sendEmailVarificationEmail,
                          child: const Text(
                            'Send again',
                          ),
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.clear();
                      ref.read(firebaseAuthProvider).signOut();
                      if (!mounted) return;
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        'auth',
                        (route) => false,
                      );
                    },
                    child: const Row(
                      children: [
                        Icon(
                          Icons.logout,
                          size: 21,
                          color: Colors.black,
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Text(
                          'Logout',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
