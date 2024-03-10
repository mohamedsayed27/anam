import 'package:anam/data/models/products_model/upload_or_update_product_model.dart';

import '../../../data/models/base_model.dart';

abstract class ProductsState {}

class ProductsInitial extends ProductsState {}
class ChangeProductReviewRate extends ProductsState {}
class GetPickedImageSuccessState extends ProductsState {}

class GetAllProductsLoadingState extends ProductsState {}

class GetAllProductsSuccessState extends ProductsState {}

class GetAllProductsErrorState extends ProductsState {
  final String error;

  GetAllProductsErrorState({required this.error});
}

class GetLocationNameAndCoordinates extends ProductsState {}
class GetFavoriteProductsLoadingState extends ProductsState {}

class GetFavoriteProductsSuccessState extends ProductsState {}

class GetFavoriteProductsErrorState extends ProductsState {
  final String error;

  GetFavoriteProductsErrorState({required this.error});
}

class GetUserFollowingProductsLoadingState extends ProductsState {}

class GetUserFollowingProductsSuccessState extends ProductsState {}

class GetUserFollowingProductsErrorState extends ProductsState {
  final String error;

  GetUserFollowingProductsErrorState({required this.error});
}

class ShowProductDetailsLoadingState extends ProductsState {}

class ShowProductDetailsSuccessState extends ProductsState {}

class ShowProductDetailsErrorState extends ProductsState {
  final String error;

  ShowProductDetailsErrorState({required this.error});
}

class ShowProductMultiLangLoadingState extends ProductsState {}

class ShowProductMultiLangSuccessState extends ProductsState {}

class ShowProductMultiLangErrorState extends ProductsState {
  final String error;

  ShowProductMultiLangErrorState({required this.error});
}

class ChangeProductStatusLoadingState extends ProductsState {}

class ChangeProductStatusSuccessState extends ProductsState {}

class ChangeProductStatusErrorState extends ProductsState {
  final String error;

  ChangeProductStatusErrorState({required this.error});
}

class DeleteProductLoadingState extends ProductsState {}

class DeleteProductSuccessState extends ProductsState {
  final BaseResponseModel baseResponseModel;

  DeleteProductSuccessState({required this.baseResponseModel});
}

class DeleteProductErrorState extends ProductsState {
  final String error;

  DeleteProductErrorState({required this.error});
}

class UploadProductLoadingState extends ProductsState {}

class UploadProductSuccessState extends ProductsState {
  final UploadOrUpdateProductModel updateProductModel;

  UploadProductSuccessState({required this.updateProductModel});
}

class UploadProductErrorState extends ProductsState {
  final String error;

  UploadProductErrorState({required this.error});
}

class UploadReviewProductLoadingState extends ProductsState {}

class UploadReviewProductSuccessState extends ProductsState {
  final BaseResponseModel baseResponseModel;

  UploadReviewProductSuccessState({required this.baseResponseModel});
}

class UploadReviewProductErrorState extends ProductsState {
  final String error;

  UploadReviewProductErrorState({required this.error});
}

class UpdateProductLoadingState extends ProductsState {}

class UpdateProductSuccessState extends ProductsState {
  final UploadOrUpdateProductModel updateProductModel;

  UpdateProductSuccessState({required this.updateProductModel});
}

class UpdateProductErrorState extends ProductsState {
  final String error;

  UpdateProductErrorState({required this.error});
}





class ChangeCategoryState extends ProductsState {}
class ChangeSubCategoryState extends ProductsState {}


class GetAllCategoriesLoadingState extends ProductsState {}

class GetAllCategoriesSuccessState extends ProductsState {}

class GetAllCategoriesErrorState extends ProductsState {
  final String error;

  GetAllCategoriesErrorState({required this.error});
}



class ShowCategoryDetailsLoadingState extends ProductsState {}

class ShowCategoryDetailsSuccessState extends ProductsState {}

class ShowCategoryDetailsErrorState extends ProductsState {
  final String error;

  ShowCategoryDetailsErrorState({required this.error});
}


class ChangeCategoriesTabBarWidgetState extends ProductsState {}
class ChangeServicesCategoriesTabBarWidgetState extends ProductsState {}



class ShowVendorProfileLoadingState extends ProductsState {}
class ShowVendorProfileSuccessState extends ProductsState {}
class ShowVendorProfileErrorState extends ProductsState {
  final String error;

  ShowVendorProfileErrorState({required this.error});
}