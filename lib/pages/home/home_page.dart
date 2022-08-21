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
              ref.read(firebaseAuthProvider).signOut();
              Navigator.of(context).pushReplacementNamed('auth');
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Container(),
    );
  }
}
