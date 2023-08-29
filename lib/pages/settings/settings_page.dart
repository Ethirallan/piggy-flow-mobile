import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:piggy_flow_mobile/providers/firebase_auth_provider.dart';

class SettingsPage extends HookConsumerWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          Card(
            child: ListTile(
              leading: const Icon(Icons.account_circle),
              title: const Text('Accounts'),
              onTap: () {
                Navigator.of(context).pushNamed('account_list');
              },
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.category),
              title: const Text('Categories'),
              onTap: () {
                Navigator.of(context).pushNamed('category_list');
              },
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.shop),
              title: const Text('Shops'),
              onTap: () {
                Navigator.of(context).pushNamed('shop_list');
              },
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.subscriptions),
              title: const Text('Subscriptions'),
              onTap: () {
                Navigator.of(context).pushNamed('subscription_list');
              },
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
                ref.read(firebaseAuthProvider).signOut();
                Navigator.of(context).pushReplacementNamed('auth');
              },
            ),
          ),
        ],
      ),
    );
  }
}
