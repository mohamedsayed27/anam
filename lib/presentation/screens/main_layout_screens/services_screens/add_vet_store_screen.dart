import 'package:anam/core/constants/constants.dart';
import 'package:anam/core/constants/extensions.dart';
import 'package:anam/core/parameters/vet_parameters.dart';
import 'package:anam/data/models/multi_lang_models/veterian_multi_lang_model.dart';
import 'package:anam/domain/controllers/services_cubit/services_state.dart';
import 'package:anam/presentation/screens/map_screen.dart';
import 'package:anam/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
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
  final VeterinarianMultiLangModel? veterinarianMultiLangModel;
  const AddVetScreen({super.key, this.veterinarianMultiLangModel});

  @override
  State<AddVetScreen> createState() => _AddVetScreenState();
}

class _AddVetScreenState extends State<AddVetScreen> {
  final formKey = GlobalKey<FormState>();
  late final ServicesCubit cubit;
  @override
  void initState() {
    cubit = ServicesCubit.get(context);

    if (widget.veterinarianMultiLangModel != null) {
      cubit.vetNameAr.text = widget.veterinarianMultiLangModel!.name?["ar"]??"";
      cubit.vetNameEn.text = widget.veterinarianMultiLangModel!.name?["en"]??"";
      cubit.vetAddressAr.text = widget.veterinarianMultiLangModel!.address?["ar"]??"";
      cubit.vetAddressEn.text = widget.veterinarianMultiLangModel!.address?["en"]??"";
      cubit.qualificationsAr.text = widget.veterinarianMultiLangModel!.qualification?["ar"]??"";
      cubit.qualificationsEn.text = widget.veterinarianMultiLangModel!.qualification?["en"]??"";
      cubit.vetPhone.text = widget.veterinarianMultiLangModel!.phone??"";
      cubit.chosenCity = cubit.citiesList.firstWhere((element) => element.id==widget.veterinarianMultiLangModel!.cityId);
      cubit.mapCoordinates = widget.veterinarianMultiLangModel!.coordinates;
      cubit.mapLocation = widget.veterinarianMultiLangModel!.mapLocation;
      cubit.vetEmail.text = widget.veterinarianMultiLangModel!.email??"";
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<ServicesCubit, ServicesState>(
          listener: (context, state) {

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

            if (state is UpdateVetLoadingState) {
              showProgressIndicator(context);
            }
            if (state is UpdateVetSuccessState) {
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
              print("Updateeddddd");
              // Navigator.pop(context);
            }
            if (state is UpdateVetErrorState) {
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
                      LocaleKeys.addVeterinarian.tr(),
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
                            hint: LocaleKeys.pleaseChooseYourCountry.tr(),
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
                      hintText: LocaleKeys.productNameAr.tr(),
                      controller: cubit.vetNameAr,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return LocaleKeys.dataMustBeEntered.tr();
                        }
                        return null;
                      },
                    ),
                    const CustomSizedBox(
                      height: 11,
                    ),
                    CustomTextField(
                      hintText: LocaleKeys.productNameEn.tr(),
                      controller: cubit.vetNameEn,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return LocaleKeys.dataMustBeEntered.tr();
                        }
                        return null;
                      },
                    ),
                    const CustomSizedBox(
                      height: 11,
                    ),
                    CustomTextField(
                      hintText: LocaleKeys.phone.tr(),
                      controller: cubit.vetPhone,
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return LocaleKeys.dataMustBeEntered.tr();
                        }
                        return null;
                      },
                    ),
                    const CustomSizedBox(
                      height: 11,
                    ),
                    CustomTextField(
                      hintText: LocaleKeys.email.tr(),
                      controller: cubit.vetEmail,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return LocaleKeys.dataMustBeEntered.tr();
                        }
                        return null;
                      },
                    ),
                    const CustomSizedBox(
                      height: 11,
                    ),
                    CustomTextField(
                      hintText: LocaleKeys.professionAr.tr(),
                      controller: cubit.qualificationsAr,
                      keyboardType: TextInputType.multiline,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return LocaleKeys.dataMustBeEntered.tr();
                        }
                        return null;
                      },
                    ),
                    const CustomSizedBox(
                      height: 11,
                    ),
                    CustomTextField(
                      hintText: LocaleKeys.professionEn.tr(),
                      controller: cubit.qualificationsEn,
                      keyboardType: TextInputType.multiline,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return LocaleKeys.dataMustBeEntered.tr();
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
                        hintText: cubit.mapLocation ?? LocaleKeys.chooseLocation.tr(),
                        enabled: false,
                        height: 45,
                      ),
                    ),
                    const CustomSizedBox(
                      height: 11,
                    ),
                    CustomTextField(
                      hintText: LocaleKeys.addressAr.tr(),
                      controller: cubit.vetAddressEn,
                      keyboardType: TextInputType.multiline,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return LocaleKeys.dataMustBeEntered.tr();
                        }
                        return null;
                      },
                    ),
                    const CustomSizedBox(
                      height: 11,
                    ),
                    CustomTextField(
                      hintText: LocaleKeys.addressEn.tr(),
                      controller: cubit.vetAddressAr,
                      keyboardType: TextInputType.multiline,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return LocaleKeys.dataMustBeEntered.tr();
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
                      title: LocaleKeys.uploadData.tr(),
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                         if(widget.veterinarianMultiLangModel==null){
                           if (cubit.vetImage == null) {
                             showToast(
                                 errorType: 1,
                                 message: LocaleKeys.imagesMustBeSelected.tr());
                           } else {
                             if (cubit.mapLocation == null) {
                               showToast(
                                   errorType: 1, message: LocaleKeys.locationMustBeSelected.tr());
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
                         }else{
                           cubit.updateVet(
                             vetParameters: VetParameters(
                               image: cubit.vetImage,
                               method: "PUT",
                               id: widget.veterinarianMultiLangModel!.id!.toString(),
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
