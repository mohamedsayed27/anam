import 'package:anam/presentation/widgets/auth_widgets/custom_text_field.dart';
import 'package:anam/presentation/widgets/order_widgets/order_type_drop_down_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../translations/locale_keys.g.dart';
import '../shared_widget/custom_divider.dart';
import '../shared_widget/custom_elevated_button.dart';
import '../shared_widget/custom_sized_box.dart';
import 'base_bottom_sheet_widget.dart';
import '../shared_widget/bottom_sheet_title_text_widget.dart';

class AddOrderBottomSheet extends StatelessWidget {
  const AddOrderBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseBottomSheetWidget(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const ScreenTitleTextWidget(
              title: LocaleKeys.uploadOrderForm,
            ),
            const CustomSizedBox(
              height: 1,
            ),
            const CustomDivider(),
            const CustomSizedBox(
              height: 29,
            ),
            CustomTextField(
              hintText: "${LocaleKeys.fullName.tr()}*",
              height: 45,
            ),
            const CustomSizedBox(
              height: 14,
            ),
            const OrderTypeDropDownButtonWidget(),
            const CustomSizedBox(
              height: 14,
            ),
            CustomTextField(
              hintText: "${LocaleKeys.description.tr()}*",
              minLines: null,
              maxLines: null,
              expands: true,
              textAlignVertical: TextAlignVertical.top,
              keyboardType: TextInputType.multiline,
              height: 140,
            ),
            const CustomSizedBox(
              height: 14,
            ),
            CustomTextField(
              hintText: "${LocaleKeys.priceInSaudiRiyals.tr()}*",
              height: 45,
            ),
            const CustomSizedBox(
              height: 14,
            ),
            CustomTextField(
              hintText: LocaleKeys.comments.tr(),
              height: 45,
            ),
            const CustomSizedBox(
              height: 14,
            ),
            CustomElevatedButton(
              title: LocaleKeys.continueText.tr(),
              onPressed: () {
                Navigator.of(context).pop();
              },
              buttonSize: Size(double.infinity, 40.h),
            ),
          ],
        ),
      ),
    );
  }
}
