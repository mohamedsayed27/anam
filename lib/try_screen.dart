import 'dart:ffi';

import 'package:anam/core/constants/extensions.dart';
import 'package:anam/presentation/widgets/auth_widgets/custom_drop_down_button.dart';
import 'package:anam/presentation/widgets/auth_widgets/custom_text_field.dart';
import 'package:anam/presentation/widgets/auth_widgets/first_and_last_name_component.dart';
import 'package:anam/presentation/widgets/auth_widgets/phone_auth_component.dart';
import 'package:anam/presentation/widgets/bottom_sheets_widgets/chat_bottom.dart';
import 'package:anam/presentation/widgets/bottom_sheets_widgets/register_as_a_vendor_bottom_sheet.dart';
import 'package:anam/presentation/widgets/bottom_sheets_widgets/register_bottom_sheet.dart';
import 'package:anam/presentation/widgets/shared_widget/custom_elevated_button.dart';
import 'package:anam/presentation/widgets/shared_widget/custom_sized_box.dart';
import 'package:anam/presentation/widgets/shared_widget/search_bar_widget.dart';
import 'package:anam/presentation/widgets/shared_widget/title_and_body_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_paytabs_bridge/BaseBillingShippingInfo.dart';
import 'package:flutter_paytabs_bridge/PaymentSdkConfigurationDetails.dart';
import 'package:flutter_paytabs_bridge/PaymentSdkLocale.dart';
import 'package:flutter_paytabs_bridge/flutter_paytabs_bridge.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TryScreen extends StatefulWidget {
  const TryScreen({super.key});

  @override
  State<TryScreen> createState() => _TryScreenState();
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

class _TryScreenState extends State<TryScreen> {
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
                  CustomSizedBox(
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
                  FacebookAuth.instance.login(permissions: ['public_profile','email']).then((value) {
                    FacebookAuth.instance.getUserData().then((value) {
                      setState(() {
                        isLoggedIn = true;
                        userData = value;
                      });
                      print(userData);
                    });
                  }).catchError((error){
                    print(error);
                  });
                },
              ),
      ),
    );
  }
}
class PaymentPayTaps{
  var billingDetails = BillingDetails(
    "John Smith",
    "email@domain.com",
    "+97311111111",
    "st. 12",
    "eg",
    "dubai",
    "dubai",
    "12345",
  );
  var shippingDetails = ShippingDetails(
    "John Smith",
    "email@domain.com",
    "+97311111111",
    "st. 12",
    "eg",
    "dubai",
    "dubai",
    "12345",
  );
  late PaymentSdkConfigurationDetails configuration;
  void init(){
    configuration = PaymentSdkConfigurationDetails(
      profileId: "108520",
      serverKey: "S6JN6RNND9-JHR69NT2MJ-6R26LT6B69",
      clientKey: "CBKMVH-2BDG6H-RGPQ7M-6KKVKT",
      cartId: "19",
      cartDescription: "cart desc",
      merchantName: "merchant name",
      screentTitle: "Pay with Card",
      merchantCountryCode: "EG",
      currencyCode: "EGP",
      billingDetails: billingDetails,
      amount: 10.0,
      shippingDetails: shippingDetails,
      locale:
      PaymentSdkLocale.AR, //PaymentSdkLocale.AR or PaymentSdkLocale.DEFAULT
    );
  }

  void testPayCallTabs() {
    FlutterPaytabsBridge.startCardPayment(configuration, (event) {
      // setState(() {
      //   if (event["status"] == "success") {
      //     // Handle transaction details here.
      //     var transactionDetails = event["data"];
      //     print(transactionDetails);
      //
      //     if (transactionDetails["isSuccess"]) {
      //       print("successful transaction");
      //     } else {
      //       print("failed transaction");
      //     }
      //   } else if (event["status"] == "error") {
      //     // Handle error here.
      //   } else if (event["status"] == "event") {
      //     // Handle cancel events here.
      //   }
      // });
    });
  }
}