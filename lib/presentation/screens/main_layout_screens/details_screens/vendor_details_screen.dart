import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../data/models/vendor_data_model.dart';
import '../../../../domain/controllers/profile_cubit/profile_cubit.dart';
import '../../../../domain/controllers/profile_cubit/profile_state.dart';
import '../../../../translations/locale_keys.g.dart';
import '../../../widgets/shared_widget/custom_divider.dart';
import '../../../widgets/shared_widget/custom_sized_box.dart';
import '../../../widgets/vendor_details_widgets/about_vendor_widget.dart';
import '../../../widgets/vendor_details_widgets/intro_details_container.dart';
import '../../../widgets/vendor_details_widgets/labor_component.dart';
import '../../../widgets/vendor_details_widgets/rating_component_builder.dart';
import '../../../widgets/vendor_details_widgets/van_compopnent.dart';
import '../../../widgets/vendor_details_widgets/vet_component.dart';

class VendorDetailsScreen extends StatelessWidget {
  final VendorProfileModel vendorProfileModel;

  const VendorDetailsScreen({super.key, required this.vendorProfileModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          ProfileCubit cubit = ProfileCubit.get(context);
          return SafeArea(
            child: cubit.getVendorProfileData
                ? const Center(
                    child: CircularProgressIndicator.adaptive(),
                  )
                : ListView(
                    children: [
                      const CustomSizedBox(
                        height: 20,
                      ),
                      IntroDetailsContainer(
                        vendorProfileModel: vendorProfileModel,
                      ),
                      const CustomSizedBox(
                        height: 18,
                      ),
                      AboutVendorWidget(
                        vendorProfileModel: vendorProfileModel,
                      ),
                      const CustomSizedBox(
                        height: 15,
                      ),
                      const CustomDivider(
                        hPadding: 16,
                      ),
                      const CustomSizedBox(
                        height: 15,
                      ),
                       RatingComponentBuilder(
                        componentTitle: LocaleKeys.ratings.tr(),
                        buttonTitle: LocaleKeys.addReview.tr(),
                      ),
                      const CustomSizedBox(
                        height: 15,
                      ),
                      const CustomDivider(
                        hPadding: 16,
                      ),
                      const CustomSizedBox(
                        height: 15,
                      ),
                      const CustomDivider(
                        hPadding: 16,
                      ),
                      const CustomSizedBox(
                        height: 15,
                      ),
                      LaborsComponentBuilder(
                        vendorProfileModel: vendorProfileModel,
                      ),
                      const CustomSizedBox(
                        height: 15,
                      ),
                      const CustomDivider(
                        hPadding: 16,
                      ),
                      const CustomSizedBox(
                        height: 15,
                      ),
                      VetComponentBuilder(
                        vendorProfileModel: vendorProfileModel,
                      ),
                      const CustomSizedBox(
                        height: 15,
                      ),
                      const CustomDivider(
                        hPadding: 16,
                      ),
                      const CustomSizedBox(
                        height: 15,
                      ),
                      VanComponentBuilder(
                        vendorProfileModel: vendorProfileModel,
                      ),
                      const CustomSizedBox(
                        height: 15,
                      ),
                    ],
                  ),
          );
        },
      ),
    );
  }
}
