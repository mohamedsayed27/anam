import 'package:anam/core/constants/constants.dart';
import 'package:anam/core/constants/extensions.dart';
import 'package:anam/core/parameters/store_parameters.dart';
import 'package:anam/data/models/city_model/city_model.dart';
import 'package:anam/domain/controllers/services_cubit/services_state.dart';
import 'package:anam/presentation/screens/map_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/app_theme/app_colors.dart';
import '../../../../domain/controllers/services_cubit/services_cubit.dart';
import '../../../../translations/locale_keys.g.dart';
import '../../../widgets/auth_widgets/custom_drop_down_button.dart';
import '../../../widgets/auth_widgets/custom_text_field.dart';
import '../../../widgets/shared_widget/custom_divider.dart';
import '../../../widgets/shared_widget/custom_elevated_button.dart';
import '../../../widgets/shared_widget/custom_sized_box.dart';

class AddStoreScreen extends StatefulWidget {
  const AddStoreScreen({super.key});

  @override
  State<AddStoreScreen> createState() => _AddStoreScreenState();
}

class _AddStoreScreenState extends State<AddStoreScreen> {
  final formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    ServicesCubit cubit = ServicesCubit.get(context);
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
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<ServicesCubit, ServicesState>(
          listener: (context, state) {
            ServicesCubit cubit = ServicesCubit.get(context);
            if (state is UploadStoreLoadingState) {
              showProgressIndicator(context);
            }
            if (state is UploadStoreSuccessState) {
              Navigator.pop(context);
              Navigator.pop(context);
            }
            if (state is UploadStoreErrorState) {
              Navigator.pop(context);
              showToast(errorType: 1, message: state.error);
            }
            if (state is GetPickedImageSuccessState) {
              cubit.storeImage = state.pickedImage;
            }
          },
          builder: (context, state) {
            ServicesCubit cubit = ServicesCubit.get(context);
            return Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "اضافة شاحنه",
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(fontSize: 20.sp),
                    ),
                    const CustomSizedBox(
                      height: 11,
                    ),
                    const CustomDivider(),
                    const CustomSizedBox(
                      height: 11,
                    ),
                    Center(
                      child: Stack(
                        children: [
                          Container(
                            height: 132.h,
                            width: 132.w,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            decoration:
                                const BoxDecoration(shape: BoxShape.circle),
                            child: cubit.storeImage == null
                                ? null
                                : Image.file(
                                    cubit.storeImage!,
                                    fit: BoxFit.cover,
                                  ),
                            //CachedNetworkImage(
                            //                               imageUrl: cubit.laborerModel!.image!,
                            //                               fit: BoxFit.cover,
                            //                               placeholder: (context, url) {
                            //                                 return Shimmer.fromColors(
                            //                                   baseColor: Colors.grey[200]!,
                            //                                   highlightColor: Colors.grey[300]!,
                            //                                   child: Container(
                            //                                     height: double.infinity,
                            //                                     width: double.infinity,
                            //                                     decoration: BoxDecoration(
                            //                                       color: Colors.black,
                            //                                       borderRadius:
                            //                                       BorderRadius.circular(8.0),
                            //                                     ),
                            //                                   ),
                            //                                 );
                            //                               },
                            //                               errorWidget: (context, url, error) =>
                            //                               const Icon(Icons.error),
                            //                             )
                          ),
                          InkWell(
                            onTap: () {
                              cubit.getImagePick();
                            },
                            overlayColor:
                                MaterialStateProperty.all(Colors.transparent),
                            splashColor: Colors.transparent,
                            child: Container(
                              height: 132.h,
                              width: 132.w,
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(
                                color: Colors.black38,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(Icons.add_a_photo_outlined,
                                  size: 35.r, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const CustomSizedBox(
                      height: 11,
                    ),
                    cubit.getAllCitiesLoading
                        ? const Center(
                            child: CircularProgressIndicator.adaptive(),
                          )
                        : CustomDropDownButton<CityModel>(
                            height: 45,
                            onChanged: cubit.chooseCity,
                            hint: "اختيار المدينه",
                            items: cubit.citiesList
                                .map((e) => DropdownMenuItem(
                                      value: e,
                                      child: Text(e.name!,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineSmall!
                                              .copyWith(fontSize: 14.sp)),
                                    ))
                                .toList(),
                            value: cubit.chosenCity,
                          ),
                    const CustomSizedBox(
                      height: 11,
                    ),
                    CustomTextField(
                      hintText: "الاسم بالعربيه",
                      controller: cubit.storeNameAr,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "يجب ادخال البيانات";
                        }
                        return null;
                      },
                    ),
                    const CustomSizedBox(
                      height: 11,
                    ),
                    CustomTextField(
                      hintText: "الاسم بالانجليزيه",
                      controller: cubit.storeNameEn,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "يجب ادخال البيانات";
                        }
                        return null;
                      },
                    ),
                    const CustomSizedBox(
                      height: 11,
                    ),
                    CustomTextField(
                      hintText: "نوع الشاحنه بالعربيه",
                      controller: cubit.trunkTypeAr,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "يجب ادخال البيانات";
                        }
                        return null;
                      },
                    ),
                    const CustomSizedBox(
                      height: 11,
                    ),
                    CustomTextField(
                      hintText: "نوع الشاحنه بالانجليزيه",
                      controller: cubit.trunkTypeEn,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "يجب ادخال البيانات";
                        }
                        return null;
                      },
                    ),
                    const CustomSizedBox(
                      height: 11,
                    ),
                    CustomTextField(
                      hintText: "الهاتف",
                      controller: cubit.storePhone,
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "يجب ادخال البيانات";
                        }
                        return null;
                      },
                    ),
                    const CustomSizedBox(
                      height: 11,
                    ),
                    CustomTextField(
                      hintText: "البريد الاليكتروني",
                      controller: cubit.storeEmail,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "يجب ادخال البيانات";
                        }
                        return null;
                      },
                    ),
                    const CustomSizedBox(
                      height: 11,
                    ),
                    InkWell(
                      onTap: () {
                        cubit.getMultiImagePick();
                      },
                      child: CustomTextField(
                        prefix: Icon(
                          Icons.camera_alt,
                          size: 20.r,
                          color: AppColors.authBorderColor,
                        ),
                        hintText: LocaleKeys.uploadImages.tr(),
                        enabled: false,
                        height: 45,
                      ),
                    ),
                    const CustomSizedBox(
                      height: 11,
                    ),
                    CustomSizedBox(
                      height: cubit.storeImages.isEmpty ? 0 : 40,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: cubit.storeImages.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            height: 36.h,
                            width: 50.w,
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                            child: Image.file(
                              cubit.storeImages[index],
                              fit: BoxFit.cover,
                            ),
                          ).onlyDirectionalPadding(end: 5);
                        },
                      ),
                    ),
                    CustomSizedBox(
                      height: cubit.storeImages.isEmpty ? 0 : 11,
                    ),
                    InkWell(
                      onTap: () async {
                        Map<String, dynamic> result = await Navigator.push(
                            context, MaterialPageRoute(builder: (_) {
                          return const MapScreen();
                        }));
                        cubit.getLocation(
                            locationName: result["name"],
                            coordinates: result['coordinates']);
                      },
                      child: CustomTextField(
                        prefix: Icon(
                          Icons.location_on_outlined,
                          size: 20.r,
                          color: AppColors.authBorderColor,
                        ),
                        hintText: cubit.mapLocation ?? "اختر الموقع",
                        enabled: false,
                        height: 45,
                      ),
                    ),
                    const CustomSizedBox(
                      height: 40,
                    ),
                    CustomElevatedButton(
                      title: "ارفاق البيانات",
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          if (cubit.storeImage == null) {
                            showToast(
                                errorType: 1,
                                message: "يجب اختيار صوره للمنتج");
                          } else {
                            if (cubit.mapLocation == null) {
                              showToast(
                                  errorType: 1, message: "يجب اختيار الموقع");
                            } else {
                              if (cubit.storeImages.isEmpty) {
                                showToast(
                                    errorType: 1,
                                    message: "يجب اختيار صور للمنتج");
                              } else {
                                cubit.uploadStore(
                                  storeParameters: StoreParameters(
                                    image: cubit.storeImage!,
                                    nameAr: cubit.storeNameAr.text,
                                    nameEn: cubit.storeNameEn.text,
                                    phone: cubit.storePhone.text,
                                    countryId: cubit.chosenCity!.country!.id!
                                        .toString(),
                                    cityId: cubit.chosenCity!.id!.toString(),
                                    truckTypeEn: cubit.trunkTypeEn.text,
                                    images: cubit.storeImages,
                                    truckTypeAr: cubit.trunkTypeAr.text,
                                    coordinates: cubit.mapCoordinates,
                                    mapLocation: cubit.mapLocation,
                                    email: cubit.storeEmail.text,
                                  ),
                                );
                              }
                            }
                          }
                        }
                      },
                      buttonSize: Size(double.infinity, 48.h),
                    ),
                  ],
                ).symmetricPadding(horizontal: 26, vertical: 20),
              ),
            );
          },
        ),
      ),
    );
  }
}
