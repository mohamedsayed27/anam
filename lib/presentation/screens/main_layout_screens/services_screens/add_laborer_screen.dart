import 'package:anam/core/constants/constants.dart';
import 'package:anam/core/constants/extensions.dart';
import 'package:anam/core/parameters/laborer_parameters.dart';
import 'package:anam/domain/controllers/services_cubit/services_state.dart';
import 'package:anam/presentation/screens/map_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/app_theme/app_colors.dart';
import '../../../../domain/controllers/services_cubit/services_cubit.dart';
import '../../../widgets/auth_widgets/custom_text_field.dart';
import '../../../widgets/shared_widget/custom_divider.dart';
import '../../../widgets/shared_widget/custom_elevated_button.dart';
import '../../../widgets/shared_widget/custom_sized_box.dart';

class AddLaborerScreen extends StatefulWidget {
  const AddLaborerScreen({super.key});

  @override
  State<AddLaborerScreen> createState() => _AddLaborerScreenState();
}

class _AddLaborerScreenState extends State<AddLaborerScreen> {
  final formKey = GlobalKey<FormState>();


  @override
  void dispose() {
    ServicesCubit cubit = ServicesCubit.get(context);
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<ServicesCubit, ServicesState>(
          listener: (context, state) {
            ServicesCubit cubit = ServicesCubit.get(context);
            if (state is UploadLaborerLoadingState) {
              showProgressIndicator(context);
            }
            if (state is UploadLaborerSuccessState) {
              Navigator.pop(context);
              Navigator.pop(context);
            }
            if (state is UploadLaborerErrorState) {
              Navigator.pop(context);
              showToast(errorType: 1, message: state.error);
            }
            if (state is GetPickedImageSuccessState) {
              cubit.laborerImage = state.pickedImage;
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
                      "اضافة ايدي عاملة",
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
                            child: cubit.laborerImage == null
                                ? null
                                : Image.file(
                                    cubit.laborerImage!,
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
                    CustomTextField(
                      hintText: "الاسم بالعربيه",
                      controller: cubit.laborerNameAr,
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
                      controller: cubit.laborerNameEn,
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
                      hintText: "الجنسيه بالعربيه",
                      controller: cubit.nationalityAr,
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
                      hintText: "الجنسيه بالانجليزيه",
                      controller: cubit.nationalityEn,
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
                      controller: cubit.laborerPhone,
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
                      controller: cubit.laborerEmail,
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
                      hintText: "المهنه بالعربيه",
                      controller: cubit.professionAr,
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
                      hintText: "المهنه بالانجليزيه",
                      controller: cubit.professionEn,
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
                      controller: cubit.laborerAddressEn,
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
                      controller: cubit.laborerAddressAr,
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
                          if (cubit.laborerImage == null) {
                            showToast(
                                errorType: 1,
                                message: "يجب اختيار صوره للمنتج");
                          } else {
                            if (cubit.mapLocation == null) {
                              showToast(
                                  errorType: 1, message: "يجب اختيار الموقع");
                            } else {
                              cubit.uploadLaborer(
                                productParameters: LaborerParameters(
                                  image: cubit.laborerImage!,
                                  nameAr: cubit.laborerNameAr.text,
                                  nameEn: cubit.laborerNameEn.text,
                                  phone: cubit.laborerPhone.text,
                                  addressAr: cubit.laborerAddressAr.text,
                                  addressEn: cubit.laborerAddressEn.text,
                                  professionAr: cubit.professionAr.text,
                                  professionEn: cubit.professionEn.text,
                                  coordinates: cubit.mapCoordinates,
                                  mapLocation: cubit.mapLocation,
                                  email: cubit.laborerEmail.text,
                                  nationalityEn: cubit.nationalityEn.text,
                                  nationalityAr: cubit.nationalityAr.text,
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
