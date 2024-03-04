import 'package:anam/core/constants/extensions.dart';
import 'package:anam/presentation/widgets/payment_widgets/package_subscription_item.dart';
import 'package:anam/presentation/widgets/shared_widget/custom_app_bar.dart';
import 'package:anam/presentation/widgets/shared_widget/custom_elevated_button.dart';
import 'package:anam/presentation/widgets/shared_widget/custom_sized_box.dart';
import 'package:anam/presentation/widgets/shared_widget/custom_sized_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paytabs_bridge/BaseBillingShippingInfo.dart';
import 'package:flutter_paytabs_bridge/PaymentSdkConfigurationDetails.dart';
import 'package:flutter_paytabs_bridge/PaymentSdkLocale.dart';
import 'package:flutter_paytabs_bridge/flutter_paytabs_bridge.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/app_theme/custom_themes.dart';
import '../../../widgets/shared_widget/custom_divider.dart';

class PackageSubscriptionsScreen extends StatefulWidget {
  const PackageSubscriptionsScreen({super.key});

  @override
  State<PackageSubscriptionsScreen> createState() =>
      _PackageSubscriptionsScreenState();
}

class _PackageSubscriptionsScreenState
    extends State<PackageSubscriptionsScreen> {
  int currentIndex = 0;
  var billingDetails = BillingDetails(
    "Test Test",
    "email@domain.com",
    "+97311111111",
    "st. 12",
    "eg",
    "dubai",
    "dubai",
    "12345",
  );
  var shippingDetails = ShippingDetails(
    "Test Test",
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
      setState(() {
        print(event);
        if (event["status"] == "success") {
          // Handle transaction details here.


          var transactionDetails = event["data"];
          print(transactionDetails);

          if (transactionDetails["isSuccess"]) {
            print("successful transaction");
          } else {
            print("failed transaction");
          }
        } else if (event["status"] == "error") {
          // Handle error here.
        } else if (event["status"] == "event") {
          // Handle cancel events here.
        }
      });
    });
  }

  @override
  void initState() {
    init();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: AppBar().preferredSize,
        child: const CustomAppBar(title: "باقات الاشتراك"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomDivider(
            hPadding: 16,
          ),
          const CustomSizedBox(
            height: 16,
          ),
          Text(
            "لقد تم توليد هذا النص من مولد النص العربى، حيث يمكنك أن تولد مثل هذا النص أو العديد من النصوص الأخرى إضافة إلى زيادة عدد الحروف",
            style: CustomThemes.grey7DColorTextTheme(context).copyWith(
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
            ),
          ).symmetricPadding(horizontal: 16),
          const CustomSizedBox(
            height: 16,
          ),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              itemBuilder: (_, index) {
                return PackageSubscriptionItem(
                  isChecked: currentIndex == index,
                  onPressed: () {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                );
              },
              separatorBuilder: (_, index) {
                return const CustomSizedBox(
                  height: 16,
                );
              },
              itemCount: 3,
            ),
          ),
          CustomElevatedButton(
            title: "اشتراك",
            onPressed: () {
              testPayCallTabs();
            },
            buttonSize: Size(double.infinity, 48,),
          ).symmetricPadding(horizontal: 16),
          const CustomSizedBox(
            height: 32,
          ),
        ],
      ),
    );
  }
}
