import 'package:anam/core/constants/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/app_theme/app_colors.dart';
import '../../../core/app_theme/custom_themes.dart';
import '../../../core/cache_helper/cache_keys.dart';
import '../../../core/cache_helper/shared_pref_methods.dart';
import '../../../core/enums/services_type_enum.dart';
import '../../../core/enums/user_type_enum.dart';
import '../../../domain/controllers/services_cubit/services_cubit.dart';
import '../../../domain/controllers/services_cubit/services_state.dart';
import '../../screens/main_layout_screens/home_screen/search_screen.dart';
import '../../screens/main_layout_screens/services_screens/add_laborer_screen.dart';
import '../../screens/main_layout_screens/services_screens/add_store_screen.dart';
import '../../screens/main_layout_screens/services_screens/add_vet_store_screen.dart';
import '../shared_widget/custom_outlined_button.dart';
import '../shared_widget/custom_sized_box.dart';
import '../shared_widget/search_bar_widget.dart';

class SearchBarAndServicesButtonsWidget extends StatelessWidget {
  final bool mapButton;

  const SearchBarAndServicesButtonsWidget({super.key, required this.mapButton});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Hero(
            tag: "searchField",
            child: Material(
              color: Colors.transparent,
              child: SearchBarWidget(
                readOnly: true,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const SearchScreen(),
                    ),
                  );
                },
                enabled: true,
              ),
            ),
          ),
        ),
        if (mapButton == false &&
            CacheHelper.getData(key: CacheKeys.userType) != null &&
            CacheHelper.getData(key: CacheKeys.userType) !=
                UserTypeEnum.user.name)
          const CustomSizedBox(
            width: 8,
          ),
        if (mapButton == false &&
            CacheHelper.getData(key: CacheKeys.userType) != null &&
            CacheHelper.getData(key: CacheKeys.userType) !=
                UserTypeEnum.user.name)
          BlocConsumer<ServicesCubit, ServicesState>(
            listener: (context, state) {},
            builder: (context, state) {
              ServicesCubit cubit = ServicesCubit.get(context);
              return cubit.selectedServicesValue != null
                  ? CustomOutlinedButton(
                      height: 40.h,
                      onPressed: () {
                        if (cubit.selectedServicesValue!.type ==
                            ServicesTypeEnum.veterinary.name) {
                          cubit.vetImage = null;
                          cubit.vetNameAr.clear();
                          cubit.vetNameEn.clear();
                          cubit.vetPhone.clear();
                          cubit.vetAddressAr.clear();
                          cubit.vetAddressEn.clear();
                          cubit.mapCoordinates;
                          cubit.mapLocation;
                          cubit.vetEmail.clear();
                          cubit.chosenCity = null;
                          cubit.chosenCity = null;
                          cubit.qualificationsAr.clear();
                          cubit.qualificationsEn.clear();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const AddVetScreen(),
                            ),
                          );
                        } else if (cubit.selectedServicesValue!.type ==
                            ServicesTypeEnum.livestock_transportation.name) {
                          cubit.storeImage = null;
                          cubit.storeNameAr.clear();
                          cubit.storeNameEn.clear();
                          cubit.storePhone.clear();
                          cubit.chosenCity = null;
                          cubit.trunkTypeEn.clear();
                          cubit.storeImages = [];
                          cubit.trunkTypeAr.clear();
                          cubit.mapCoordinates = null;
                          cubit.mapLocation = null;
                          cubit.storeEmail.clear();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const AddStoreScreen(),
                            ),
                          );
                        } else if (cubit.selectedServicesValue!.type ==
                            ServicesTypeEnum.laborers.name) {
                          cubit.laborerImage = null;
                          cubit.laborerNameAr.clear();
                          cubit.laborerNameEn.clear();
                          cubit.laborerPhone.clear();
                          cubit.laborerAddressAr.clear();
                          cubit.laborerAddressEn.clear();
                          cubit.professionAr.clear();
                          cubit.professionEn.clear();
                          cubit.mapCoordinates = null;
                          cubit.mapLocation = null;
                          cubit.laborerEmail.clear();
                          cubit.nationalityEn.clear();
                          cubit.nationalityAr.clear();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const AddLaborerScreen()));
                        }
                      },
                      radius: 89,
                      foregroundColor: AppColors.greyColor9D,
                      borderColor: AppColors.greyColor9D,
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      child: Row(
                        children: [
                          Icon(
                            Icons.add,
                            color: AppColors.greyColor71,
                            size: 18.r,
                          ),
                          const CustomSizedBox(
                            width: 8,
                          ),
                          Text(
                            cubit.selectedServicesValue!.name!,
                            style: CustomThemes.grey7DColorTextTheme(context)
                                .copyWith(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    )
                  : const CircularProgressIndicator();
            },
          ),
      ],
    ).onlyDirectionalPadding(
      start: 16,
      end: 16,
      top: 16,
      bottom: 10,
    );
  }
}
