import 'package:anam/core/constants/constants.dart';
import 'package:anam/core/parameters/request_parameters.dart';
import 'package:anam/presentation/widgets/auth_widgets/custom_text_field.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/app_theme/app_colors.dart';
import '../../../domain/controllers/requests_cubit/requests_cubit.dart';
import '../../../domain/controllers/requests_cubit/requests_state.dart';
import '../../../translations/locale_keys.g.dart';
import '../../screens/map_screen.dart';
import '../shared_widget/custom_divider.dart';
import '../shared_widget/custom_elevated_button.dart';
import '../shared_widget/custom_sized_box.dart';
import 'base_bottom_sheet_widget.dart';
import '../shared_widget/bottom_sheet_title_text_widget.dart';

class AddOrderBottomSheet extends StatefulWidget {
  const AddOrderBottomSheet({super.key});

  @override
  State<AddOrderBottomSheet> createState() => _AddOrderBottomSheetState();
}

class _AddOrderBottomSheetState extends State<AddOrderBottomSheet> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BaseBottomSheetWidget(
      child: SingleChildScrollView(
        child: BlocConsumer<RequestsCubit, RequestsState>(
          listener: (context, state) {
            RequestsCubit cubit = RequestsCubit.get(context);
            if (state is GetLocationNameAndCoordinates) {
              cubit.mapLocation = state.mapLocation;
              cubit.mapCoordinates = state.coordinates;
            }
            if(state is SendRequestErrorState){
              Navigator.pop(context);
              showToast(errorType: 1, message: state.error,);
            }
            if(state is SendRequestSuccessState){
              print("object");
              print("objects");
              Navigator.pop(context);
              Navigator.pop(context);
              cubit.previousRequestsPageNumber = 1;
              cubit.previousRequestList.clear();
              cubit.getPreviousRequests();
            }
          },
          builder: (context, state) {
            var cubit = RequestsCubit.get(context);
            return Form(
              key: formKey,
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
                    height: 12,
                  ),
                  state is! GetAllCountriesLoadingState
                      ? DropdownButtonFormField(
                          items: cubit.countriesList
                              .map((e) => DropdownMenuItem(
                                    value: e,
                                    child: Text("${e.code}   ${e.name}"),
                                  ))
                              .toList(),
                          hint: Text(
                            LocaleKeys.pleaseChooseYourCountry.tr(),
                            textAlign: TextAlign.start,
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .copyWith(fontSize: 14.sp),
                          ),
                          onChanged: cubit.changeCity,
                          // isExpanded: true,
                          alignment: Alignment.topCenter,
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(fontSize: 12.sp),
                          decoration:  InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.r),
                              borderSide: BorderSide(
                                color: AppColors.authBorderColor,
                                width: 0.74.w,
                              ),
                            ),
                          ),
                          value: cubit.chosenCity,
                        )
                      : Center(
                          child: CircularProgressIndicator.adaptive(),
                        ),
                  const CustomSizedBox(
                    height: 12,
                  ),
                  CustomTextField(
                    hintText: LocaleKeys.notes.tr(),
                    textAlignVertical: TextAlignVertical.top,
                    controller: cubit.notes,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return LocaleKeys.dataMustBeEntered.tr();
                      }
                      return null;
                    },
                    keyboardType: TextInputType.multiline,
                  ),
                  const CustomSizedBox(
                    height: 12,
                  ),
                  CustomTextField(
                    hintText: LocaleKeys.address.tr(),
                    textAlignVertical: TextAlignVertical.top,
                    controller: cubit.address,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return LocaleKeys.dataMustBeEntered.tr();
                      }
                      return null;
                    },
                    keyboardType: TextInputType.multiline,
                  ),
                  const CustomSizedBox(
                    height: 12,
                  ),
                  CustomTextField(
                    hintText: LocaleKeys.description.tr(),
                    controller: cubit.details,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return LocaleKeys.dataMustBeEntered.tr();
                      }
                      return null;
                    },
                    textAlignVertical: TextAlignVertical.top,
                    keyboardType: TextInputType.multiline,
                  ),
                  const CustomSizedBox(
                    height: 12,
                  ),
                  InkWell(
                    onTap: () async {
                      Map<String, dynamic> result = await Navigator.push(
                          context, MaterialPageRoute(builder: (_) {
                        return const MapScreen();
                      }));
                      cubit.getLocation(
                        locationName: result["name"],
                        coordinates: result['coordinates'],
                      );
                    },
                    child: CustomTextField(
                      prefix: Icon(
                        Icons.location_on_outlined,
                        size: 20.r,
                        color: AppColors.authBorderColor,
                      ),
                      controller:
                          TextEditingController(text: cubit.mapLocation),
                      hintText: cubit.mapLocation ?? LocaleKeys.locationMustBeSelected.tr(),
                      enabled: false,
                      height: 45,
                    ),
                  ),
                  const CustomSizedBox(
                    height: 12,
                  ),
                  CustomTextField(
                    hintText: LocaleKeys.priceInSaudiRiyals.tr(),
                    controller: cubit.price,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return LocaleKeys.dataMustBeEntered.tr();
                      }
                      return null;
                    },
                    height: 45,
                  ),
                  const CustomSizedBox(
                    height: 24,
                  ),
                  CustomElevatedButton(
                    title: LocaleKeys.continueText.tr(),
                    onPressed: () {
                      if(formKey.currentState!.validate()){
                        if(cubit.chosenCity==null){
                          showToast(errorType: 1, message: LocaleKeys.chooseCountryCode.tr(),);
                        }else if(cubit.mapLocation==null){
                          showToast(errorType: 1, message: LocaleKeys.chooseCountry.tr(),);
                        }
                        else {
                          cubit.sendRequest(
                          requestParameters: RequestParameters(
                            title: cubit.address.text,
                            countryId: cubit.chosenCity!.id.toString(),
                            coordinates: cubit.mapCoordinates,
                            description: cubit.details.text,
                            mapLocation: cubit.mapLocation,
                            notes: cubit.notes.text,
                            price: cubit.price.text,
                          ),
                        );
                          showProgressIndicator(context);
                        }
                      }

                    },
                    buttonSize: Size(double.infinity, 40.h),
                  ),
                  const CustomSizedBox(
                    height: 12,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
