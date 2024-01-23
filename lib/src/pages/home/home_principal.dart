import 'package:flutter/material.dart';
import 'package:personal_app/src/pages/login/login_init.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePrincipal extends StatelessWidget {
  const HomePrincipal({super.key});

  static const routeName = '/home-principal';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('teste'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              final prefs = await SharedPreferences.getInstance();
              prefs.setBool('showHome', false);

              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const LoginInit()));
            },
          )
        ],
      ),
      body: const Center(
        child: Text('More Information Here'),
      ),
    );
  }
}
