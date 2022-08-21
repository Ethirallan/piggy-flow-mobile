import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:piggy_flow_mobile/helpers/swatch_helper.dart';
import 'package:piggy_flow_mobile/helpers/unfocus.dart';
import 'package:piggy_flow_mobile/pages/auth/auth_page.dart';
import 'package:piggy_flow_mobile/pages/auth/confirm_email_page.dart';
import 'package:piggy_flow_mobile/pages/home/home_page.dart';
import 'package:piggy_flow_mobile/providers/es_message_provider.dart';

import 'providers/firebase_auth_provider.dart';

class App extends ConsumerStatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends ConsumerState<App> {
  User? user;

  @override
  void initState() {
    super.initState();
    user = ref.read(firebaseAuthProvider).currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Neue Haas Grotesk Display Pro',
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.blue,
          height: 72,
          textTheme: ButtonTextTheme.accent,
          colorScheme: Theme.of(context).colorScheme.copyWith(
                primary: Colors.blue,
                secondary: Colors.white,
              ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 25),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            primary: Colors.blue,
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            primary: Colors.blue,
            padding: const EdgeInsets.symmetric(vertical: 25),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
          ),
        ),
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: createMaterialColor(Colors.blue),
        ).copyWith(secondary: Colors.white),
      ),
      builder: (context, child) {
        return HookConsumer(
          builder: (BuildContext context, WidgetRef ref, Widget? child) {
            ref.listen<ESMessage?>(esMessageProvider, (prev, state) {
              if (state != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: state.color,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    behavior: SnackBarBehavior.floating,
                    content: Text(
                      state.message,
                    ),
                  ),
                );
              }
            });
            return child ?? Container();
          },
          child: Unfocus(
            child: child!,
          ),
        );
      },
      routes: {
        '/': (context) => user == null
            ? const AuthPage()
            : user?.emailVerified ?? false
                ? const HomePage()
                : const ConfirmEmailPage(),
        'home': (context) => const HomePage(),
        'auth': (context) => const AuthPage(),
        'confirm_email': (context) => const ConfirmEmailPage(),
      },
    );
  }
}
