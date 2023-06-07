import 'package:flutter/material.dart';
import 'package:lin_stays/pages/settings/admin_page.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 20, top: 10, bottom: 20),
              child: Text(
                'Settings',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: ListView(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.admin_panel_settings_outlined),
                      title: const Text(
                        'Admin Page',
                        style: TextStyle(fontSize: 18),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AdminPage()));
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.groups_2_outlined),
                      title: const Text(
                        'About us',
                        style: TextStyle(fontSize: 18),
                      ),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: const Icon(Icons.privacy_tip_outlined),
                      title: const Text(
                        'Privacy Policy',
                        style: TextStyle(fontSize: 18),
                      ),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: const Icon(Icons.cookie_outlined),
                      title: const Text(
                        'Cookie Policy',
                        style: TextStyle(fontSize: 18),
                      ),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: const Icon(Icons.info_outline),
                      title: const Text(
                        'Terms of Use',
                        style: TextStyle(fontSize: 18),
                      ),
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ),
          ],
        )));
  }
}
