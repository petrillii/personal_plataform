import 'package:flutter/material.dart';
import 'package:personal_app/src/pages/onboarding.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Displays detailed information about a SampleItem.
class SampleItemDetailsView extends StatelessWidget {
  const SampleItemDetailsView({super.key});

  static const routeName = '/sample_item';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Item Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              final prefs = await SharedPreferences.getInstance();
              prefs.setBool('showHome', false);

              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const OnBoarding()));
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
