import 'package:anam/core/constants/extensions.dart';
import 'package:anam/presentation/widgets/shared_widget/custom_sized_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../widgets/shared_widget/custom_app_bar.dart';
import '../../../widgets/shared_widget/custom_divider.dart';
import '../../../widgets/shared_widget/custom_elevated_button.dart';
import '../../../widgets/shared_widget/form_item_widget.dart';

class CardDetailsScreen extends StatelessWidget {
  const CardDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: AppBar().preferredSize,
        child: const CustomAppBar(title: "باقات الاشتراك"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CustomDivider(
            ),
            const CustomSizedBox(
              height: 16,
            ),
            FormItemWidget(
                title: "رقم البطاقة", hintText: "**** **** **** ****"),
            const CustomSizedBox(
              height: 16,
            ),
            Row(
              children: [
                Expanded(
                    child: FormItemWidget(
                        title: "تاريخ الصلاحية", hintText: "00/00")),
                CustomSizedBox(
                  width: 16,
                ),
                Expanded(
                    child: FormItemWidget(title: "CVV", hintText: "***")),
              ],
            ),
            const CustomSizedBox(
              height: 16,
            ),
            FormItemWidget(title: "الاسم على البطاقة", hintText: "الاسم"),
            const CustomSizedBox(
              height: 48,
            ),
            CustomElevatedButton(
              title: "تأكيد الدفع",
              onPressed: () {},
              radius: 9.r,
              buttonSize: Size(double.infinity, 48.h),
            )
          ],
        ).symmetricPadding(horizontal: 16),
      ),
    );
  }
}
