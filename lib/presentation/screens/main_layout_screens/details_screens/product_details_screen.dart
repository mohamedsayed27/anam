import 'package:anam/core/constants/extensions.dart';
import 'package:anam/data/models/products_model/product_model.dart';
import 'package:anam/presentation/widgets/bottom_sheets_widgets/add_review_bottom_sheet.dart';
import 'package:anam/presentation/widgets/shared_widget/custom_divider.dart';
import 'package:anam/presentation/widgets/shared_widget/custom_sized_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/app_theme/app_colors.dart';
import '../../../../core/app_theme/custom_themes.dart';
import '../../../../core/assets_path/images_path.dart';
import '../../../widgets/bottom_sheets_widgets/chat_bottom.dart';
import '../../../widgets/product_details_widgets/contact_container_widget.dart';
import '../../../widgets/product_details_widgets/product_details_images_widget.dart';
import '../../../widgets/shared_widget/title_and_body_text_widget.dart';
import '../../../widgets/product_details_widgets/vendor_details_component.dart';
import '../../../widgets/vendor_details_widgets/rating_component_builder.dart';

class ProductDetailsScreen extends StatefulWidget {
  final ProductDataModel productDataModel;

  const ProductDetailsScreen({super.key, required this.productDataModel});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: SafeArea(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            ListView(
              children: [
                ProductDetailsImagesWidget(
                  imagesList: widget.productDataModel.images!,
                ),
                const CustomSizedBox(
                  height: 25,
                ),
                VendorDetailsComponent(productDataModel: widget.productDataModel,),
                const CustomSizedBox(
                  height: 24,
                ),
                const CustomDivider(hPadding: 28),
                const CustomSizedBox(
                  height: 24,
                ),
                TileAndBodyTextWidget(
                  titleText: "وصف المنتج",
                  bodyText: widget.productDataModel.description ?? "",
                  titleFontSize: 20,
                  horizontalPadding: 16,
                  bodyFontSize: 16,
                  bodyMaxLines: 10,
                  titleMaxLines: 5,
                  spaceBetweenTitleAndBody: 8,
                ),
                const CustomSizedBox(
                  height: 19,
                ),
                const CustomDivider(hPadding: 28),
                const CustomSizedBox(
                  height: 19,
                ),
                TileAndBodyTextWidget(
                  titleText: "المميزات",
                  bodyText: widget.productDataModel.advantages ?? "",
                  titleFontSize: 20,
                  bodyFontSize: 16,
                  horizontalPadding: 16,
                  bodyMaxLines: 5,
                  spaceBetweenTitleAndBody: 3,
                ),
                const CustomSizedBox(
                  height: 19,
                ),
                const CustomDivider(hPadding: 28),
                const CustomSizedBox(
                  height: 19,
                ),
                TileAndBodyTextWidget(
                  titleText: "العيوب",
                  bodyText: widget.productDataModel.defects ?? "",
                  titleFontSize: 20,
                  bodyFontSize: 16,
                  horizontalPadding: 16,
                  bodyMaxLines: 5,
                  spaceBetweenTitleAndBody: 3,
                ),
                const CustomSizedBox(
                  height: 19,
                ),
                const CustomDivider(hPadding: 28),
                const CustomSizedBox(
                  height: 19,
                ),
                RatingComponentBuilder(
                  componentTitle: 'اراء العملاء',
                  buttonTitle: 'اضافة تقييم',
                  onAddPressed: (){
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (_) =>  AddProductReviewBottomSheet(id: widget.productDataModel.id.toString(),),
                    );
                  },
                ),
                const CustomSizedBox(
                  height: 19,
                ),
                const CustomDivider(hPadding: 16),
                const CustomSizedBox(
                  height: 19,
                ),
                Text(
                  "روابط مرفقة",
                  style: CustomThemes.darkGreyColorTextTheme(context).copyWith(
                    fontSize: 20.sp,
                    height: 1,
                    fontWeight: FontWeight.w400,
                  ),
                ).symmetricPadding(horizontal: 16),
                const CustomSizedBox(
                  height: 8,
                ),
                Text(
                  widget.productDataModel.youtubeLink ?? "",
                  style: CustomThemes.primaryColorTextTheme(context).copyWith(
                    fontSize: 16.sp,
                    height: 1,
                    decoration: TextDecoration.underline,
                    decorationColor: AppColors.primaryColor,
                    fontWeight: FontWeight.w400,
                  ),
                ).symmetricPadding(horizontal: 16),
                const CustomSizedBox(
                  height: 19,
                ),
                const CustomDivider(hPadding: 16),
                const CustomSizedBox(
                  height: 19,
                ),
                Text(
                  "الموقع على الخريطة",
                  style: CustomThemes.darkGreyColorTextTheme(context).copyWith(
                    fontSize: 20.sp,
                    height: 1,
                    fontWeight: FontWeight.w400,
                  ),
                ).symmetricPadding(horizontal: 16),
                const CustomSizedBox(
                  height: 22,
                ),
                SizedBox(
                  height: 193.h,
                  width: double.infinity,
                  child: Image.asset(
                    ImagesPath.mapImage,
                    fit: BoxFit.cover,
                  ),
                ).symmetricPadding(horizontal: 16),
                const CustomDivider(hPadding: 28),
                const CustomSizedBox(
                  height: 19,
                ),
                ContactContainerWidget(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (_) => ChatBottomSheet(receiverId: widget.productDataModel.uploadedBy!.id!,),
                    );
                  }, price: widget.productDataModel.regularPrice?.toString()??"", rate: widget.productDataModel.rate!.toString(),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
