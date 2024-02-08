import 'package:anam/core/constants/constants.dart';
import 'package:anam/core/constants/extensions.dart';
import 'package:anam/core/parameters/vet_parameters.dart';
import 'package:anam/domain/controllers/services_cubit/services_state.dart';
import 'package:anam/presentation/screens/map_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/app_theme/app_colors.dart';
import '../../../../data/models/city_model/city_model.dart';
import '../../../../domain/controllers/services_cubit/services_cubit.dart';
import '../../../widgets/auth_widgets/custom_drop_down_button.dart';
import '../../../widgets/auth_widgets/custom_text_field.dart';
import '../../../widgets/shared_widget/custom_divider.dart';
import '../../../widgets/shared_widget/custom_elevated_button.dart';
import '../../../widgets/shared_widget/custom_sized_box.dart';

class AddVetScreen extends StatefulWidget {
  const AddVetScreen({super.key});

  @override
  State<AddVetScreen> createState() => _AddVetScreenState();
}

class _AddVetScreenState extends State<AddVetScreen> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<ServicesCubit, ServicesState>(
          listener: (context, state) {
            ServicesCubit cubit = ServicesCubit.get(context);
            if (state is UploadVetLoadingState) {
              showProgressIndicator(context);
            }
            if (state is UploadVetSuccessState) {
              Navigator.pop(context);
              Navigator.pop(context);
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
              print("Uploadeddddd");
              // Navigator.pop(context);
            }
            if (state is UploadVetErrorState) {
              Navigator.pop(context);
              showToast(errorType: 1, message: state.error);
            }
            if (state is GetPickedImageSuccessState) {
              cubit.vetImage = state.pickedImage;
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
                      "اضافة بيطره",
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
                            child: cubit.vetImage == null
                                ? null
                                : Image.file(
                                    cubit.vetImage!,
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
                      controller: cubit.vetNameAr,
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
                      controller: cubit.vetNameEn,
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
                      controller: cubit.vetPhone,
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
                      controller: cubit.vetEmail,
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
                    CustomTextField(
                      hintText: "المؤهل بالعربيه",
                      controller: cubit.qualificationsAr,
                      keyboardType: TextInputType.multiline,
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
                      hintText: "المؤهل بالانجليزيه",
                      controller: cubit.qualificationsEn,
                      keyboardType: TextInputType.multiline,
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
                      height: 11,
                    ),
                    CustomTextField(
                      hintText: "العنوان بالانجليزيه",
                      controller: cubit.vetAddressEn,
                      keyboardType: TextInputType.multiline,
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
                      hintText: "العنوان بالعربيه",
                      controller: cubit.vetAddressAr,
                      keyboardType: TextInputType.multiline,
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
                    const CustomSizedBox(
                      height: 40,
                    ),
                    CustomElevatedButton(
                      title: "ارفاق البيانات",
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          if (cubit.vetImage == null) {
                            showToast(
                                errorType: 1,
                                message: "يجب اختيار صوره للبيطري");
                          } else {
                            if (cubit.mapLocation == null) {
                              showToast(
                                  errorType: 1, message: "يجب اختيار الموقع");
                            } else {
                              cubit.uploadVet(
                                vetParameters: VetParameters(
                                  image: cubit.vetImage!,
                                  nameAr: cubit.vetNameAr.text,
                                  nameEn: cubit.vetNameEn.text,
                                  phone: cubit.vetPhone.text,
                                  addressAr: cubit.vetAddressAr.text,
                                  addressEn: cubit.vetAddressEn.text,
                                  coordinates: cubit.mapCoordinates,
                                  mapLocation: cubit.mapLocation,
                                  email: cubit.vetEmail.text,
                                  countryId:
                                      cubit.chosenCity!.country!.id.toString(),
                                  cityId: cubit.chosenCity!.id.toString(),
                                  qualificationAr: cubit.qualificationsAr.text,
                                  qualificationEn: cubit.qualificationsEn.text,
                                ),
                              );
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
