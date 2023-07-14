import 'package:flutter/material.dart';

class PrivacyPolicy extends StatelessWidget {
  PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          surfaceTintColor: Colors.white,
          title: Image.asset(
            'assets/images/Logo.png',
            height: 40,
          ),
          centerTitle: true,
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Privacy Policy',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  updatedDate,
                  style: TextStyle(fontSize: 17),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  privacy,
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
        ));
  }

  String updatedDate = '13 July 2023';
  String privacy =
      "First things first - your privacy is important to us. That might be the kind of thing all these notices say, but we mean it. You place our trust in us by using LIN Stays services and we value that trust. that means we're committed to protecting and safeguarding your personal data. We act in our customers' best interest and we aere transparent about the processing of your personal data. \n\nThis document ('this Privacy Statement' or 'our Privacy Statement') describes how we use and process your personal data, provided in a readable and transparent manner. It also tells you what rihgts you can exersice in relation to your personal data and how you can contact us. \n\nIf you've used us before, youknow that LIN Stays offers online booking related services through our own appliations. We'd lke to point out that all the information you are about to read, generally applies to not one, not two but all of these platforms. \n\nIn fact, this single privacy statement applies to any kind of customer information we collect through all of the above platforms or by any other means conncected to these platforms (such as when you contact our customer service team by email.)";
}
