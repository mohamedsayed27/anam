import 'dart:convert';
import 'dart:developer';

import 'package:anam/core/cache_helper/cache_keys.dart';
import 'package:anam/core/cache_helper/shared_pref_methods.dart';
import 'package:anam/core/constants/constants.dart';
import 'package:anam/core/constants/extensions.dart';
import 'package:anam/data/models/packages_model/packages_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_paytabs_bridge/BaseBillingShippingInfo.dart';
import 'package:flutter_paytabs_bridge/PaymentSdkConfigurationDetails.dart';
import 'package:flutter_paytabs_bridge/PaymentSdkLocale.dart';
import 'package:flutter_paytabs_bridge/flutter_paytabs_bridge.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/app_theme/custom_themes.dart';
import '../../../../domain/controllers/packages_cubit/packages_cubit.dart';
import '../../../widgets/payment_widgets/package_subscription_item.dart';
import '../../../widgets/shared_widget/custom_app_bar.dart';
import '../../../widgets/shared_widget/custom_divider.dart';
import '../../../widgets/shared_widget/custom_elevated_button.dart';
import '../../../widgets/shared_widget/custom_sized_box.dart';

class PackageSubscriptionsScreen extends StatefulWidget {
  const PackageSubscriptionsScreen({super.key});

  @override
  State<PackageSubscriptionsScreen> createState() =>
      _PackageSubscriptionsScreenState();
}

class _PackageSubscriptionsScreenState
    extends State<PackageSubscriptionsScreen> {
  int? currentIndex;
  var billingDetails = BillingDetails(
    CacheHelper.getData(key: CacheKeys.userName) ?? "Not Found",
    CacheHelper.getData(key: CacheKeys.userEmail) ?? "email@email.com",
    CacheHelper.getData(key: CacheKeys.phone) ?? "+97311111111",
    "st. 12 street",
    "sa",
    "saudi arabia",
    "saudi arabia",
    "52472",
  );

  late PaymentSdkConfigurationDetails configuration;

  void init() {
    configuration = PaymentSdkConfigurationDetails(
      profileId: "104890",
      serverKey: "STJN6RNNDG-JHD2LZRKTJ-TBD9H6BZLR",
      clientKey: "CPKMVH-2BBD6H-DMB9RK-6TRB6K",
      cartId: "${monthlyPackage?.id}",
      cartDescription:
          "user with id $userId subscribed in package that its id is ${monthlyPackage?.id}",
      screentTitle: "Pay with Card",
      merchantCountryCode: "SA",
      // transactionType: PaymentSdkTransactionType.SALE,
      currencyCode: "SAR",
      billingDetails: billingDetails,
      amount: monthlyPackage?.price ?? 0.0,

      locale:
          PaymentSdkLocale.EN, //PaymentSdkLocale.AR or PaymentSdkLocale.DEFAULT
    );
    testPayCallTabs();
  }

  void testPayCallTabs() {
    FlutterPaytabsBridge.startCardPayment(configuration, (event) {
      setState(() {
        print(event);
        print("jsonDecodejsonDecodejsonDecodejsonDecodejsonDecode");
        if (event["status"] == "success") {
          // Handle transaction details here.

          var transactionDetails = event["data"];

          if (transactionDetails["isSuccess"]) {
            PackagesCubit.get(context).subscribeAPackage(
              tranRef: transactionDetails["transactionReference"],
              packageId: transactionDetails["cartID"],
            );
            print("successful transaction");
            print(transactionDetails["paymentResult"]);
            // log(transactionDetails);
            log(jsonEncode(transactionDetails));
          } else {
            print("failed transaction");
          }
        } else if (event["status"] == "error") {
          print(event["status"]);
          print("event[status]error");
          // Handle error here.
        } else if (event["status"] == "event") {
          print(event["status"]);
          print("event[status] event");
          // Handle cancel events here.
        }
      });
    });
  }

  MonthlyPackage? monthlyPackage;

  @override
  void initState() {
    // init();
    PackagesCubit.get(context).getAllPackages();
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
          BlocConsumer<PackagesCubit, PackagesState>(
            listener: (context, state) {
              // TODO: implement listener
            },
            builder: (context, state) {
              PackagesCubit cubit = PackagesCubit.get(context);
              return Expanded(
                child: state is GetAllPackagesLoadingState
                    ? const Center(
                        child: CircularProgressIndicator.adaptive(),
                      )
                    : ListView.separated(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 16.h),
                        itemBuilder: (_, index) {
                          return PackageSubscriptionItem(
                            isChecked: currentIndex == index,
                            onPressed: () {
                              setState(() {
                                currentIndex = index;
                                monthlyPackage = cubit.monthlyPackage?[index];
                              });
                            },
                            monthlyPackage: cubit.monthlyPackage?[index],
                          );
                        },
                        separatorBuilder: (_, index) {
                          return const CustomSizedBox(
                            height: 16,
                          );
                        },
                        itemCount: cubit.monthlyPackage?.length ?? 0,
                      ),
              );
            },
          ),
          CustomElevatedButton(
            title: "اشتراك",
            onPressed: () {
              init();
            },
            buttonSize: const Size(
              double.infinity,
              48,
            ),
          ).symmetricPadding(horizontal: 16),
          const CustomSizedBox(
            height: 32,
          ),
        ],
      ),
    );
  }
}
