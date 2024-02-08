import 'package:anam/presentation/widgets/shared_widget/custom_elevated_button.dart';
import 'package:anam/presentation/widgets/shared_widget/custom_sized_box.dart';
import 'package:anam/presentation/widgets/shared_widget/title_and_body_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class FacebookAuthTest extends StatefulWidget {
  const FacebookAuthTest({super.key});

  @override
  State<FacebookAuthTest> createState() => _FacebookAuthTestState();
}

List<String> items = [
  "dummy1",
  "dummy2",
  "dummy3",
  "dummy4",
  "dummy5",
];
String? stateOrRegionValue;
String? cityValue;
String? mainCategoryValue;
String? subcategoryValue;

class _FacebookAuthTestState extends State<FacebookAuthTest> {
  List<String> items = [
    "dummy1",
    "dummy2",
    "dummy3",
    "dummy4",
    "dummy5",
  ];
  String? value;

  bool isLoggedIn = false;
  Map userData = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: isLoggedIn
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TileAndBodyTextWidget(
                    titleText: userData['name'],
                    bodyText: userData['email'],
                    titleFontSize: 20,
                    bodyFontSize: 15,
                    spaceBetweenTitleAndBody: 10,
                  ),
                  const CustomSizedBox(
                    height: 15,
                  ),
                  CustomElevatedButton(
                    title: "logout",
                    onPressed: () {
                      FacebookAuth.instance.logOut().then((value) {
                        setState(() {
                          isLoggedIn = false;
                          userData = {};
                        });
                      });
                    },
                  )
                ],
              )
            : CustomElevatedButton(
                title: "login",
                onPressed: () {
                  FacebookAuth.instance.login(
                      permissions: ['public_profile', 'email']).then((value) {
                    FacebookAuth.instance.getUserData().then((value) {
                      setState(() {
                        isLoggedIn = true;
                        userData = value;
                      });
                      print(userData);
                    });
                  }).catchError((error) {
                    print(error);
                  });
                },
              ),
      ),
    );
  }
}
