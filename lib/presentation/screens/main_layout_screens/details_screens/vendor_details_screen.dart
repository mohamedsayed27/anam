import 'package:anam/data/models/vendor_data_model.dart';
import 'package:anam/data/models/vendor_info_model.dart';
import 'package:anam/presentation/widgets/shared_widget/custom_divider.dart';
import 'package:anam/presentation/widgets/shared_widget/custom_sized_box.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../domain/controllers/profile_cubit/profile_cubit.dart';
import '../../../../domain/controllers/profile_cubit/profile_state.dart';
import '../../../widgets/vendor_details_widgets/about_vendor_widget.dart';
import '../../../widgets/vendor_details_widgets/ads_component_builder.dart';
import '../../../widgets/vendor_details_widgets/intro_details_container.dart';
import '../../../widgets/vendor_details_widgets/labor_component.dart';
import '../../../widgets/vendor_details_widgets/rating_component_builder.dart';
import '../../../widgets/vendor_details_widgets/van_compopnent.dart';
import '../../../widgets/vendor_details_widgets/vendor_orders_component.dart';
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
                      const RatingComponentBuilder(
                        componentTitle: 'التقييمات',
                        buttonTitle: 'اضافة تقييم',
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
