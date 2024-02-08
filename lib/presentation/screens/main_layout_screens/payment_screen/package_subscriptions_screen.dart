import 'package:anam/core/constants/extensions.dart';
import 'package:anam/presentation/widgets/payment_widgets/package_subscription_item.dart';
import 'package:anam/presentation/widgets/shared_widget/custom_app_bar.dart';
import 'package:anam/presentation/widgets/shared_widget/custom_sized_box.dart';
import 'package:anam/presentation/widgets/shared_widget/custom_sized_box.dart';
import 'package:flutter/material.dart';
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
        ],
      ),
    );
  }
}
