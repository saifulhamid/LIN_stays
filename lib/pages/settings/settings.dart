import 'package:flutter/material.dart';
import 'package:lin_stays/pages/settings/about.dart';
import 'dart:io';
import 'package:lin_stays/pages/settings/admin/admin_view.dart';
import 'package:lin_stays/pages/settings/privacypolicy.dart';
import 'package:lin_stays/pages/settings/termsOfUse.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({Key? key});

  final TextEditingController _userEnteredPassword = TextEditingController();

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
                        adminKey(context);
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.groups_2_outlined),
                      title: const Text(
                        'About us',
                        style: TextStyle(fontSize: 18),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AboutUs(),
                            ));
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.privacy_tip_outlined),
                      title: const Text(
                        'Privacy Policy',
                        style: TextStyle(fontSize: 18),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PrivacyPolicy(),
                            ));
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.info_outline),
                      title: const Text(
                        'Terms of Use',
                        style: TextStyle(fontSize: 18),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TermsOfUse(),
                            ));
                      },
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.exit_to_app,
                        color: Colors.red,
                      ),
                      title: const Text(
                        'Exit',
                        style: TextStyle(fontSize: 18, color: Colors.red),
                      ),
                      onTap: () {
                        onClickBackButton(context);
                      },
                    ),
                    SizedBox(
                      height: 300,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'version 1.0.0',
                          style: TextStyle(fontSize: 17, color: Colors.grey),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        )));
  }

  adminKey(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('Enter Admin Key'),
              content: TextField(
                controller: _userEnteredPassword,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    gapPadding: 2,
                    borderSide: BorderSide(
                      width: 1,
                    ),
                  ),
                  fillColor: Colors.white70,
                ),
              ),
              actions: [
                TextButton(
                    onPressed: () async {
                      String password = '1234';
                      if (password == _userEnteredPassword.text) {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => adminEdit()));
                      } else {
                        Navigator.pop(context);
                      }
                      _userEnteredPassword.clear();
                    },
                    child: const Text(
                      'Log In',
                      style: TextStyle(color: Colors.black),
                    ))
              ],
            ));
  }

  Future onClickBackButton(BuildContext context) async {
    await showDialog(
        context: context,
        builder: ((BuildContext context) {
          return AlertDialog(
            title: Text('Are you sure?'),
            content: Text('Do you want exit from the App?'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'No',
                    style: TextStyle(color: Colors.black),
                  )),
              TextButton(
                  onPressed: () {
                    exit(0);
                  },
                  child: Text(
                    'Yes',
                    style: TextStyle(color: Colors.red),
                  )),
            ],
          );
        }));
  }
}
