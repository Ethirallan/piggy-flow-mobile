import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:piggy_flow_mobile/helpers/swatch_helper.dart';
import 'package:piggy_flow_mobile/helpers/unfocus.dart';
import 'package:piggy_flow_mobile/pages/auth/auth_page.dart';
import 'package:piggy_flow_mobile/pages/auth/confirm_email_page.dart';
import 'package:piggy_flow_mobile/pages/bill/bill_list_page.dart';
import 'package:piggy_flow_mobile/pages/category/category_list_page.dart';
import 'package:piggy_flow_mobile/pages/setttings/settings_page.dart';
import 'package:piggy_flow_mobile/pages/account/account_list_page.dart';
import 'package:piggy_flow_mobile/pages/shop/shop_list_page.dart';
import 'package:piggy_flow_mobile/pages/statistics/statistic_page.dart';
import 'package:piggy_flow_mobile/providers/account_provider.dart';
import 'package:piggy_flow_mobile/providers/category_provider.dart';
import 'package:piggy_flow_mobile/providers/es_message_provider.dart';
import 'package:piggy_flow_mobile/providers/shop_provider.dart';

import 'providers/firebase_auth_provider.dart';

class App extends ConsumerStatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  AppState createState() => AppState();
}

class AppState extends ConsumerState<App> {
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
        // buttonTheme: ButtonThemeData(
        //   buttonColor: Colors.blue,
        //   height: 72,
        //   textTheme: ButtonTextTheme.accent,
        //   colorScheme: Theme.of(context).colorScheme.copyWith(
        //         primary: Colors.blue,
        //         secondary: Colors.white,
        //       ),
        //   shape: RoundedRectangleBorder(
        //     borderRadius: BorderRadius.circular(50),
        //   ),
        // ),
        // textButtonTheme: TextButtonThemeData(
        //   style: TextButton.styleFrom(),
        // ),
        textTheme: Theme.of(context).textTheme.apply(
              bodyColor: const Color(0xFF574141),
              displayColor: const Color(0xFF574141),
            ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 80),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            // backgroundColor: Colors
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 25),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
          ),
        ),
        scaffoldBackgroundColor: const Color(0xFFFFF3F2),
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: createMaterialColor(const Color(0xFFFE3F58)),
        ).copyWith(
          secondary: const Color(0xFFBD8180),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0xFFFE3F58),
          foregroundColor: Colors.white,
        ),
      ),
      builder: (context, child) {
        return HookConsumer(
          builder: (BuildContext context, WidgetRef ref, Widget? child) {
            if (ref.read(firebaseAuthProvider).currentUser != null) {
              ref.read(accountProvider);
              ref.read(shopProvider);
              ref.read(categoryProvider);
            }
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
                ? const StatisticsPage()
                : const ConfirmEmailPage(),
        'statistics': (context) => const StatisticsPage(),
        'auth': (context) => const AuthPage(),
        'confirm_email': (context) => const ConfirmEmailPage(),
        'account_list': (context) => const AccountListPage(),
        'shop_list': (context) => const ShopListPage(),
        'category_list': (context) => const CategoryListPage(),
        'bill_list': (context) => const BillListPage(),
        'settings': (constext) => const SettingsPage(),
      },
    );
  }
}
