import 'package:anam/core/constants/constants.dart';
import 'package:anam/core/constants/extensions.dart';
import 'package:anam/core/parameters/upload_product_parameters.dart';
import 'package:anam/data/models/categories/categories_model.dart';
import 'package:anam/data/models/categories/sub_categories_model.dart';
import 'package:anam/data/models/multi_lang_models/product_multi_lang_model.dart';
import 'package:anam/presentation/screens/map_screen.dart';
import 'package:anam/translations/locale_keys.g.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/app_theme/app_colors.dart';
import '../../../../core/network/api_end_points.dart';
import '../../../../domain/controllers/products_cubit/products_cubit.dart';
import '../../../../domain/controllers/products_cubit/products_state.dart';
import '../../../widgets/auth_widgets/custom_drop_down_button.dart';
import '../../../widgets/auth_widgets/custom_text_field.dart';
import '../../../widgets/shared_widget/custom_divider.dart';
import '../../../widgets/shared_widget/custom_elevated_button.dart';
import '../../../widgets/shared_widget/custom_sized_box.dart';

class AddProductScreen extends StatefulWidget {
  final ProductMultiLangModel? productMultiLangModel;

  const AddProductScreen({super.key, this.productMultiLangModel});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  late final ProductsCubit cubit;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    cubit = ProductsCubit.get(context);
    if (widget.productMultiLangModel != null) {
      cubit.productNameAr.text =
          widget.productMultiLangModel!.name!['ar'] ?? "";
      cubit.productNameEn.text =
          widget.productMultiLangModel!.name!['en'] ?? "";
      cubit.locationAr.text =
          widget.productMultiLangModel!.location!['ar'] ?? "";
      cubit.locationEn.text =
          widget.productMultiLangModel!.location!['en'] ?? "";
      cubit.productPrice.text =
          widget.productMultiLangModel!.salePrice?.toString() ?? "";
      cubit.productDescriptionAr.text =
          widget.productMultiLangModel!.description!['ar'] ?? "";
      cubit.productDescriptionEn.text =
          widget.productMultiLangModel!.description!['en'] ?? "";
      cubit.productProsAr.text =
          widget.productMultiLangModel!.advantages!['ar'] ?? "";
      cubit.productProsEn.text =
          widget.productMultiLangModel!.advantages!['en'] ?? "";
      cubit.productConsAr.text =
          widget.productMultiLangModel!.defects!['ar'] ?? "";
      cubit.productConsEn.text =
          widget.productMultiLangModel!.defects!['en'] ?? "";
      cubit.youtubeLink.text = widget.productMultiLangModel!.youtubeLink ?? "";
      cubit.mapLocation = widget.productMultiLangModel!.mapLocation ?? "";
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<ProductsCubit, ProductsState>(
          listener: (context, state) {
            if (state is UploadProductLoadingState) {
              showProgressIndicator(context);
            }
            if (state is DeleteProductImagesSuccessState) {
              Navigator.pop(context);
              widget.productMultiLangModel!.images!.removeWhere((element) => element.id==state.imageId);
              showToast(errorType: 0, message: "Deleted");
            }
            if (state is DeleteProductImagesErrorState) {
              Navigator.pop(context);
              print(state.error);
              showToast(errorType: 1, message: "Error");
            }
            if (state is UploadProductSuccessState) {
              Navigator.pop(context);
              Navigator.pop(context);
              cubit.productNameAr.clear();
              cubit.productNameEn.clear();
              cubit.locationAr.clear();
              cubit.locationEn.clear();
              cubit.productPrice.clear();
              cubit.productDescriptionAr.clear();
              cubit.productDescriptionEn.clear();
              cubit.productProsAr.clear();
              cubit.productProsEn.clear();
              cubit.productConsAr.clear();
              cubit.productConsEn.clear();
              cubit.youtubeLink.clear();
              cubit.mapLocation = null;
              cubit.productImages.clear();
            }
            if (state is UploadProductErrorState) {
              Navigator.pop(context);
              showToast(errorType: 1, message: state.error);
            }
            if (state is UpdateProductLoadingState) {
              showProgressIndicator(context);
            }
            if (state is UpdateProductSuccessState) {
              Navigator.pop(context);
              Navigator.pop(context);
              cubit.productNameAr.clear();
              cubit.productNameEn.clear();
              cubit.locationAr.clear();
              cubit.locationEn.clear();
              cubit.productPrice.clear();
              cubit.productDescriptionAr.clear();
              cubit.productDescriptionEn.clear();
              cubit.productProsAr.clear();
              cubit.productProsEn.clear();
              cubit.productConsAr.clear();
              cubit.productConsEn.clear();
              cubit.youtubeLink.clear();
              cubit.mapLocation = null;
              cubit.productImages.clear();
            }
            if (state is UpdateProductErrorState) {
              Navigator.pop(context);
              showToast(errorType: 1, message: state.error);
            }
          },
          builder: (context, state) {
            return Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      LocaleKeys.addProduct.tr(),
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(fontSize: 20.sp),
                    ),
                    const CustomSizedBox(
                      height: 10,
                    ),
                    const CustomDivider(),
                    const CustomSizedBox(
                      height: 10,
                    ),
                    Text(
                      "عرض 001",
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(fontSize: 16.sp),
                    ),
                    const CustomSizedBox(
                      height: 17,
                    ),
                    widget.productMultiLangModel == null
                        ? cubit.getAllCategoriesLoading
                            ? const Center(
                                child: CircularProgressIndicator.adaptive(),
                              )
                            : CustomDropDownButton<CategoriesModel>(
                                height: 45,
                                onChanged: cubit.chooseCategory,
                                hint: LocaleKeys.mainClassification.tr(),
                                items: cubit.categoriesList
                                    .map((e) => DropdownMenuItem(
                                          value: e,
                                          child: Text(e.name!,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headlineSmall!
                                                  .copyWith(fontSize: 14.sp)),
                                        ))
                                    .toList(),
                                value: cubit.productCategory,
                              )
                        : const CustomSizedBox(
                            height: 0,
                          ),
                    const CustomSizedBox(
                      height: 11,
                    ),
                    cubit.showCategoryModel == null
                        ? const SizedBox.shrink()
                        : cubit.getCategory
                            ? const Center(
                                child: CircularProgressIndicator.adaptive(),
                              )
                            : CustomDropDownButton<SubCategoriesModel>(
                                height: 45,
                                onChanged: cubit.chooseSubCategory,
                                hint: LocaleKeys.subCategory.tr(),
                                items: cubit.showCategoryModel!.subCategories!
                                    .map((e) => DropdownMenuItem(
                                          value: e,
                                          child: Text(e.name!),
                                        ))
                                    .toList(),
                                value: cubit.productSubCategory,
                              ),
                    const CustomSizedBox(
                      height: 11,
                    ),
                    CustomTextField(
                      hintText: LocaleKeys.productNameAr.tr(),
                      controller: cubit.productNameAr,
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
                      controller: cubit.productNameEn,
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
                      hintText: LocaleKeys.locationAr.tr(),
                      controller: cubit.locationAr,
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
                      hintText: LocaleKeys.locationEn.tr(),
                      controller: cubit.locationEn,
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
                      hintText: LocaleKeys.price.tr(),
                      controller: cubit.productPrice,
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
                      hintText: LocaleKeys.productDescriptionAr.tr(),
                      maxLines: 8,
                      controller: cubit.productDescriptionAr,
                      textAlignVertical: TextAlignVertical.top,
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
                      hintText: LocaleKeys.productDescriptionEn.tr(),
                      maxLines: 8,
                      controller: cubit.productDescriptionEn,
                      textAlignVertical: TextAlignVertical.top,
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
                        hintText: cubit.mapLocation ?? "اختر الموقع",
                        enabled: false,
                        height: 45,
                      ),
                    ),
                    const CustomSizedBox(
                      height: 11,
                    ),
                    InkWell(
                      onTap: () {
                        cubit.getImagePick();
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
                      height: cubit.productImages.isEmpty ? 0 : 40,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: cubit.productImages.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            height: 36.h,
                            width: 50.w,
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                            child: Image.file(
                              cubit.productImages[index],
                              fit: BoxFit.cover,
                            ),
                          ).onlyDirectionalPadding(end: 5);
                        },
                      ),
                    ),
                    if(widget.productMultiLangModel!=null&&widget.productMultiLangModel!.images!=null&&widget.productMultiLangModel!.images!.isNotEmpty)Text(
                      LocaleKeys.attachedImages.tr(),
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(fontSize: 16.sp),
                    ),
                    if(widget.productMultiLangModel!=null&&widget.productMultiLangModel!.images!=null&&widget.productMultiLangModel!.images!.isNotEmpty)const CustomSizedBox(
                      height: 11,
                    ),
                    if(widget.productMultiLangModel!=null&&widget.productMultiLangModel!.images!=null&&widget.productMultiLangModel!.images!.isNotEmpty)CustomSizedBox(
                      height: widget.productMultiLangModel!.images!.isEmpty ? 0 : 40,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: widget.productMultiLangModel!.images!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            height: 60.h,
                            width: 60.w,
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                CachedNetworkImage(
                                  height: double.infinity,
                                  width: double.infinity,
                                  imageUrl: "${EndPoints
                                      .imagesBaseUrl
                                  }/${widget.productMultiLangModel!.images![index]
                                      .imageAr!}",
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) {
                                    return Shimmer.fromColors(
                                      baseColor: Colors.grey[200]!,
                                      highlightColor: Colors.grey[300]!,
                                      child: Container(
                                        height: double.infinity,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius:
                                          BorderRadius.circular(8.0),
                                        ),
                                      ),
                                    );
                                  },
                                  errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                                ),
                                Container(
                                  height: double.infinity,
                                  width: double.infinity,
                                  color: AppColors.blackColor.withOpacity(0.1),
                                ),
                                IconButton(
                                  onPressed: () {
                                    cubit.deleteProductImages(id: widget.productMultiLangModel!.images![index].id!);
                                    showProgressIndicator(context);
                                  },
                                  icon: Icon(
                                    Icons.delete,
                                    color: AppColors.whiteColor,
                                    size: 22.sp,
                                  ),
                                ),
                              ],
                            ),
                          ).onlyDirectionalPadding(end: 5);
                        },
                      ),
                    ),
                    const CustomSizedBox(
                      height: 11,
                    ),
                    CustomTextField(
                      prefix: Icon(
                        Icons.link_rounded,
                        size: 20.r,
                        color: AppColors.authBorderColor,
                      ),
                      controller: cubit.youtubeLink,
                      hintText: LocaleKeys.youtubeLink.tr(),
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
                      hintText: LocaleKeys.productProsAr.tr(),
                      maxLines: 8,
                      controller: cubit.productProsEn,
                      textAlignVertical: TextAlignVertical.top,
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
                      hintText: LocaleKeys.productProsEn.tr(),
                      maxLines: 8,
                      controller: cubit.productProsAr,
                      textAlignVertical: TextAlignVertical.top,
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
                      hintText: LocaleKeys.productConsAr.tr(),
                      maxLines: 8,
                      controller: cubit.productConsEn,
                      textAlignVertical: TextAlignVertical.top,
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
                      hintText: LocaleKeys.productConsEn.tr(),
                      controller: cubit.productConsAr,
                      maxLines: 8,
                      textAlignVertical: TextAlignVertical.top,
                      keyboardType: TextInputType.multiline,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return LocaleKeys.dataMustBeEntered.tr();
                        }
                        return null;
                      },
                    ),
                    const CustomSizedBox(
                      height: 40,
                    ),
                    CustomElevatedButton(
                      title: LocaleKeys.uploadYourProduct.tr(),
                      onPressed: ()
                      // {
                      //   print(widget.productMultiLangModel?.subCategoryId);
                      // },
                      {
                        if (formKey.currentState!.validate()) {
                          if (widget.productMultiLangModel == null) {
                            if (cubit.productImages.isEmpty) {
                              showToast(
                                  errorType: 1,
                                  message: LocaleKeys.imagesMustBeSelected.tr());
                            } else {
                              if (cubit.productCategory == null) {
                                showToast(
                                    errorType: 1,
                                    message:
                                    LocaleKeys.categoriesMustBeSelected.tr());
                              } else {
                                if (cubit.productSubCategory == null) {
                                  showToast(
                                      errorType: 1,
                                      message:
                                      LocaleKeys.categoriesMustBeSelected.tr());
                                } else {
                                  if (cubit.mapLocation == null) {
                                    showToast(
                                        errorType: 1,
                                        message: LocaleKeys.locationMustBeSelected.tr());
                                  } else {
                                    cubit.uploadProduct(
                                      productParameters: ProductParameters(
                                        catId: cubit.productCategory!.id!
                                            .toString(),
                                        subCatId: cubit.productSubCategory!.id!
                                            .toString(),
                                        nameAr: cubit.productNameAr.text,
                                        nameEn: cubit.productNameEn.text,
                                        salePrice: cubit.productPrice.text,
                                        mainImage: cubit.productImages[0],
                                        locationAr: cubit.locationAr.text,
                                        locationEn: cubit.locationEn.text,
                                        descriptionAr:
                                            cubit.productDescriptionAr.text,
                                        descriptionEn:
                                            cubit.productDescriptionEn.text,
                                        coordinates: cubit.mapCoordinates,
                                        mapLocation: cubit.mapLocation,
                                        youtubeLink: cubit.youtubeLink.text,
                                        advantagesEn: cubit.productProsEn.text,
                                        advantagesAr: cubit.productProsAr.text,
                                        defectsEn: cubit.productConsEn.text,
                                        defectsAr: cubit.productConsAr.text,
                                        images: cubit.productImages,
                                      ),
                                    );
                                  }
                                }
                              }
                            }
                          } else {
                            cubit.updateProduct(
                                productParameters: ProductParameters(
                              catId: widget.productMultiLangModel!.categoryId!.toString(),
                              subCatId:
                              widget.productMultiLangModel!.subCategoryId.toString(),
                              nameAr: cubit.productNameAr.text,
                              nameEn: cubit.productNameEn.text,
                              productId: widget.productMultiLangModel!.id.toString(),
                              salePrice: cubit.productPrice.text,
                              // mainImage: cubit.productImages[0],
                              locationAr: cubit.locationAr.text,
                              method: "PUT",
                              locationEn: cubit.locationEn.text,
                              descriptionAr: cubit.productDescriptionAr.text,
                              descriptionEn: cubit.productDescriptionEn.text,
                              coordinates: cubit.mapCoordinates,
                              mapLocation: cubit.mapLocation,
                              youtubeLink: cubit.youtubeLink.text,
                              advantagesEn: cubit.productProsEn.text,
                              advantagesAr: cubit.productProsAr.text,
                              defectsEn: cubit.productConsEn.text,
                              defectsAr: cubit.productConsAr.text,
                              images: cubit.productImages,
                            ));
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
