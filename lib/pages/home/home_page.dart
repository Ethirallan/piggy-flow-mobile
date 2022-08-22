import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:piggy_flow_mobile/providers/firebase_auth_provider.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home page'),
        actions: [
          IconButton(
            onPressed: () async {
              ref.read(authProvider).logout();
              Navigator.of(context).pushReplacementNamed('auth');
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed('account_list');
              },
              child: const Text('Account list'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed('shop_list');
              },
              child: const Text('Shop list'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed('category_list');
              },
              child: const Text('Category list'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed('bill_list');
              },
              child: const Text('Bill list'),
            ),
          ],
        ),
      ),
    );
  }
}
