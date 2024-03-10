import 'dart:async';

import 'package:anam/core/app_router/screens_name.dart';
import 'package:anam/core/assets_path/images_path.dart';
import 'package:anam/core/constants/constants.dart';
import 'package:anam/core/constants/extensions.dart';
import 'package:anam/core/enums/user_type_enum.dart';
import 'package:anam/data/models/products_model/product_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../core/assets_path/svg_path.dart';
import '../../../domain/controllers/products_cubit/products_cubit.dart';
import '../../../domain/controllers/products_cubit/products_state.dart';
import '../../../domain/controllers/profile_cubit/profile_cubit.dart';

class ItemImageWidget extends StatefulWidget {
  final ProductDataModel productDataModel;
  final bool isFavorite;

  const ItemImageWidget({
    super.key,
    required this.productDataModel,
    this.isFavorite = false,
  });

  @override
  State<ItemImageWidget> createState() => _ItemImageWidgetState();
}

class _ItemImageWidgetState extends State<ItemImageWidget> {
  final PageController controller = PageController();

  @override
  Widget build(BuildContext context) {
    print(userType);
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          height: 314.h,
          width: double.infinity,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: PageView.builder(
            itemCount: widget.productDataModel.images!.length,
            controller: controller,
            itemBuilder: (BuildContext context, int index) {
              return CachedNetworkImage(
                imageUrl: widget.productDataModel.images![index].image!,
                fit: BoxFit.cover,
                placeholder: (context, url) => Shimmer.fromColors(
                  baseColor: Colors.grey[200]!,
                  highlightColor: Colors.grey[300]!,
                  child: Container(
                    height: double.infinity,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              );
            },
          ),
        ),
        if (widget.productDataModel.images != null&&widget.productDataModel.images!.isNotEmpty)
          Align(
            alignment: Alignment.bottomCenter,
            child: SmoothPageIndicator(
              controller: controller,
              count: widget.productDataModel.images!.length,
              effect: SlideEffect(
                spacing: 6.9.w,
                radius: 4.0,
                dotWidth: 6.w,
                dotHeight: 6.h,
                paintStyle: PaintingStyle.fill,
                dotColor: Colors.white.withOpacity(.7),
                activeDotColor: Colors.white,
              ),
            ),
          ).symmetricPadding(vertical: 10),
        PositionedDirectional(
          start: 18.w,
          bottom: 30.h,
          child: InkWell(
            onTap: () {
              ProfileCubit.get(context)
                  .showVendorProfile(
                      id: widget.productDataModel.uploadedBy!.id!)
                  .then((value) {
                Navigator.pushNamed(context, ScreenName.vendorDetailsScreen,
                    arguments: ProfileCubit.get(context).vendorProfileModel);
              });
            },
            child: Container(
              height: 48.h,
              width: 48.w,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: CachedNetworkImage(
                imageUrl: widget.productDataModel.uploadedBy!.image!,
                fit: BoxFit.cover,
                placeholder: (context, url) => Shimmer.fromColors(
                  baseColor: Colors.grey[200]!,
                  highlightColor: Colors.grey[300]!,
                  child: Container(
                    height: double.infinity,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          ),
        ),
        if (token != null && userType == UserTypeEnum.user.name)
          PositionedDirectional(
            end: 18.w,
            top: 19.h,
            child: BlocConsumer<ProductsCubit, ProductsState>(
              listener: (context, state) {
                // TODO: implement listener
              },
              builder: (context, state) {
                var cubit = ProductsCubit.get(context);
                return IconButton(
                  onPressed: () {
                    cubit.changeFavorite(id: widget.productDataModel.id!);
                  },
                  padding: EdgeInsets.zero,
                  icon: SvgPicture.asset(
                    cubit.favoriteProduct[widget.productDataModel.id.toString()]
                        ? SvgPath.redLike
                        : SvgPath.like,
                    width: 23.w,
                    height: 21.h,
                  ),
                );
              },
            ),
          ),
      ],
    );
  }
}
