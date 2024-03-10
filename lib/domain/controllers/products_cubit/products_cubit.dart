import 'dart:io';

import 'package:anam/core/network/error_message_model.dart';
import 'package:anam/core/parameters/review_product_parameters.dart';
import 'package:anam/core/parameters/upload_product_parameters.dart';
import 'package:anam/data/datasources/remote_datasource/categories_remote_datasource.dart';
import 'package:anam/data/datasources/remote_datasource/multi_lang_remote_data_source.dart';
import 'package:anam/data/datasources/remote_datasource/products_remote_datasource.dart';
import 'package:anam/data/models/base_model.dart';
import 'package:anam/data/models/categories/categories_model.dart';
import 'package:anam/data/models/categories/show_category_model.dart';
import 'package:anam/data/models/multi_lang_models/product_multi_lang_model.dart';
import 'package:anam/data/models/reviews_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:image_picker/image_picker.dart';
import '../../../core/constants/constants.dart';
import '../../../core/services/services_locator.dart';
import '../../../data/datasources/remote_datasource/profile_remote_datasource.dart';
import '../../../data/models/categories/sub_categories_model.dart';
import '../../../data/models/products_model/product_model.dart';
import '../../../data/models/vendor_data_model.dart';
import 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit() : super(ProductsInitial());

  static ProductsCubit get(context) => BlocProvider.of(context);
  final CategoriesRemoteDatasource _categoriesRemoteDatasource = sl();
  final ProductsRemoteDatasource _productsRemoteDatasource = sl();
  final ProfileRemoteDatasource _profileRemoteDatasource = sl();
  final MultiLangRemoteDataSource _multiLangRemoteDataSource = sl();
  BaseErrorModel? baseErrorModel;
  ProductDataModel? showProductDetailsModel;
  ShowCategoryDataModel? showCategoryModel;
  List<ReviewModel> reviewsList = [];
  List<ProductDataModel> productsList = [];
  List<ProductDataModel> favoriteProductsList = [];
  List<ProductDataModel> userFollowingProductsList = [];
  List<CategoriesModel> categoriesList = [];
  int allProductsPageNumber = 1;
  int allFavoriteProductsPageNumber = 1;
  int allCategoriesPageNumber = 1;
  int userFollowingProductsPageNumber = 1;
  VendorProfileModel? vendorProfileModel;
  bool getAllProductsLoading = false;
  Map<String, dynamic> vendorProducts = {};
  Map<String, dynamic> followedVendors = {};
  Map<String, dynamic> favoriteProduct = {};
  ImagePicker picker = ImagePicker();
  String? mapLocation;
  String? mapCoordinates;
  final TextEditingController addProductReviewName = TextEditingController();
  final TextEditingController addProductReviewEmail = TextEditingController();
  final TextEditingController addProductReviewDescription =
      TextEditingController();
  final TextEditingController addProductReviewAge = TextEditingController();
  final TextEditingController addProductReviewLocation =
      TextEditingController();

  final TextEditingController productNameAr = TextEditingController();
  final TextEditingController productNameEn = TextEditingController();
  final TextEditingController locationAr = TextEditingController();
  final TextEditingController locationEn = TextEditingController();
  final TextEditingController productPrice = TextEditingController();
  final TextEditingController productDescriptionAr = TextEditingController();
  final TextEditingController productDescriptionEn = TextEditingController();
  final TextEditingController productProsAr = TextEditingController();
  final TextEditingController productProsEn = TextEditingController();
  final TextEditingController productConsAr = TextEditingController();
  final TextEditingController productConsEn = TextEditingController();
  final TextEditingController youtubeLink = TextEditingController();
  int addProductReviewRate = 0;

  List<File> productImages = [];

  Future<void> getImagePick() async {
    final pickedFile = await picker.pickMultiImage();
    final List<File> productImages =
        pickedFile.map((e) => File(e.path)).toList();
    this.productImages = productImages;
    emit(GetPickedImageSuccessState());
  }

  void changeProductReviewRate(double value) {
    addProductReviewRate = value.round();
    emit(ChangeProductReviewRate());
  }

  void getAllProducts() async {
    if (allProductsPageNumber == 1) {
      getAllProductsLoading = true;
      emit(GetAllProductsLoadingState());
    }
    final response = await _productsRemoteDatasource.getAllProducts(
      pageNumber: allProductsPageNumber,
    );
    response.fold(
      (l) {
        baseErrorModel = l.baseErrorModel;
        getAllProductsLoading = false;
        emit(GetAllProductsErrorState(error: baseErrorModel?.message ?? ""));
      },
      (r) {
        if (allProductsPageNumber <=
            r.getPaginatedProductResultModel!.lastPage!) {
          if (r.getPaginatedProductResultModel!.currentPage! <=
              r.getPaginatedProductResultModel!.lastPage!) {
            if (r.getPaginatedProductResultModel!.products!.isNotEmpty) {
              for (var element in r.getPaginatedProductResultModel!.products!) {
                if (!productsList.contains(element)) {
                  productsList.add(element);
                }
              }
              for (var element in productsList) {
                if (element.uploadedBy!.isFollowed != null) {
                  if (!followedVendors.containsKey(element.id!.toString())) {
                    followedVendors.addAll({
                      element.uploadedBy!.id.toString():
                          element.uploadedBy!.isFollowed
                    });
                  }
                }
                if (element.isFavorite != null) {
                  if (!favoriteProduct.containsKey(element.id!.toString())) {
                    favoriteProduct.addAll({
                      element.id.toString():
                          element.isFavorite
                    });
                  }
                }
              }
              allProductsPageNumber++;
            }
          }
          productsList.forEach((element) {print(element.uploadedBy!.isFollowed);});
          getAllProductsLoading = false;
          emit(GetAllProductsSuccessState());
        }
      },
    );
  }

  void getLocation({
    required String locationName,
    required String coordinates,
  }) {
    mapLocation = locationName;
    mapCoordinates = coordinates;
    emit(GetLocationNameAndCoordinates());
  }

  void getFavoriteProducts() async {
    emit(GetFavoriteProductsLoadingState());
    final response = await _productsRemoteDatasource.getFavoriteProducts(
      pageNumber: allFavoriteProductsPageNumber,
    );
    response.fold(
      (l) {
        baseErrorModel = l.baseErrorModel;
        emit(GetFavoriteProductsErrorState(
            error: baseErrorModel?.message ?? ""));
      },
      (r) {
        if (allFavoriteProductsPageNumber <=
            r.getPaginatedProductResultModel!.lastPage!) {
          if (r.getPaginatedProductResultModel!.currentPage! <=
              r.getPaginatedProductResultModel!.lastPage!) {
            if (r.getPaginatedProductResultModel!.products!.isNotEmpty) {
              for (var element in r.getPaginatedProductResultModel!.products!) {
                if (!favoriteProductsList.contains(element)) {
                  favoriteProductsList.add(element);
                }
              }
              allFavoriteProductsPageNumber++;
            }
          }
          emit(GetFavoriteProductsSuccessState());
        }
      },
    );
  }

  bool getUserFollowingList = false;

  void getUserFollowingProducts() async {
    getUserFollowingList = true;
    emit(GetUserFollowingProductsLoadingState());
    final response = await _productsRemoteDatasource.getUserFollowingProducts(
      pageNumber: userFollowingProductsPageNumber,
    );
    response.fold(
      (l) {
        baseErrorModel = l.baseErrorModel;
        getUserFollowingList = false;
        emit(GetUserFollowingProductsErrorState(
            error: baseErrorModel?.message ?? ""));
      },
      (r) {
        if (userFollowingProductsPageNumber <=
            r.getPaginatedProductResultModel!.lastPage!) {
          if (r.getPaginatedProductResultModel!.currentPage! <=
              r.getPaginatedProductResultModel!.lastPage!) {
            userFollowingProductsList
                .addAll(r.getPaginatedProductResultModel!.products!);
            for (var element in userFollowingProductsList) {
              if (element.uploadedBy!.isFollowed != null) {
                if (!followedVendors.containsKey(element.id!.toString())) {
                  followedVendors.addAll({
                    element.uploadedBy!.id.toString():
                        element.uploadedBy!.isFollowed
                  });
                }
                if (element.isFavorite != null) {
                  if (!favoriteProduct.containsKey(element.id!.toString())) {
                    favoriteProduct.addAll({
                      element.id.toString():
                      element.isFavorite
                    });
                  }
                }
              }
            }
            userFollowingProductsPageNumber++;
          }
          getUserFollowingList = false;
          emit(GetUserFollowingProductsSuccessState());
        }
      },
    );
  }

  void showProductDetails({required int productId}) async {
    emit(ShowProductDetailsLoadingState());
    final response = await _productsRemoteDatasource.showProduct(id: productId);
    response.fold(
      (l) {
        baseErrorModel = l.baseErrorModel;
        emit(ShowProductDetailsErrorState(
            error: baseErrorModel?.errors?[0] ?? ""));
      },
      (r) async {
        showProductDetailsModel = r;
        emit(ShowProductDetailsSuccessState());
      },
    );
  }

  BaseResponseModel? productStatusModel;

  void changeProductStatus({
    required int productId,
    required String status,
  }) async {
    vendorProducts[productId.toString()] =
        !vendorProducts[productId.toString()];
    emit(ChangeProductStatusLoadingState());
    final response = await _productsRemoteDatasource.changeProductStatus(
      id: productId,
      status: status,
    );
    response.fold(
      (l) {
        vendorProducts[productId.toString()] =
            !vendorProducts[productId.toString()];
        baseErrorModel = l.baseErrorModel;
        emit(ChangeProductStatusErrorState(
            error: baseErrorModel?.errors?[0] ?? baseErrorModel!.message));
      },
      (r) async {
        productStatusModel = r;
        emit(ChangeProductStatusSuccessState());
      },
    );
  }

  // void addServicesProviderToFavorite({required int id}) async {
  //   favorites[id] = !favorites[id]!;
  //   emit(AddServiceToFavLoading());
  //   final response =
  //   await ServicesProvidersRepository.addServiceToFavorite(id: id);
  //   mainResponse = MainResponse.fromJson(response.data);
  //   if (mainResponse.errorCode == 0) {
  //     emit(AddServiceToFavSuccess());
  //     getFavoritesServices();
  //   } else {
  //     emit(AddServiceToFavError(error: mainResponse.errorMessage.toString()));
  //   }
  // }
  bool getVendorProfileData = false;

  Future showVendorProfile({required int id}) async {
    getVendorProfileData = true;
    vendorProfileModel = null;
    emit(ShowVendorProfileLoadingState());
    final response = await _profileRemoteDatasource.showVendorDetails(id: id);
    response.fold(
      (l) {
        baseErrorModel = l.baseErrorModel;

        getVendorProfileData = false;
        emit(ShowVendorProfileErrorState(
            error: baseErrorModel?.errors?[0] ?? baseErrorModel!.message));
      },
      (r) async {
        vendorProfileModel = r.vendorProfileModel;
        for (var element in r.vendorProfileModel.productsList!) {
          if (!vendorProducts.containsKey(element.id!.toString())) {
            vendorProducts.addAll({element.id!.toString(): element.inStock!});
          }
        }
        getVendorProfileData = false;
        emit(ShowVendorProfileSuccessState());
      },
    );
  }

  bool getProductReviewLoading = false;

  void getProductReview({required String productId}) async {
    reviewsList = [];
    getProductReviewLoading = true;
    emit(ShowProductDetailsLoadingState());
    final response =
        await _productsRemoteDatasource.getAllProductReviews(id: productId);
    response.fold(
      (l) {
        getProductReviewLoading = false;
        baseErrorModel = l.baseErrorModel;
        emit(ShowProductDetailsErrorState(
            error: baseErrorModel?.errors?[0] ?? ""));
      },
      (r) async {
        getProductReviewLoading = false;
        if (r.reviewModel != null) {
          reviewsList.addAll(r.reviewModel!);
        }
        emit(ShowProductDetailsSuccessState());
      },
    );
  }



  ProductMultiLangModel? productMultiLangModel;
  bool? getMultiLangLaborerLoading;

  void getMultiLangProduct({required int id}) async {
    emit(ShowProductMultiLangLoadingState());
    final response =
    await _multiLangRemoteDataSource.geProductMultiLang(id: id);
    response.fold(
          (l) {
        baseErrorModel = l.baseErrorModel;
        emit(ShowProductMultiLangErrorState(
            error: baseErrorModel?.errors?[0] ?? ""));
      },
          (r) async {
        productMultiLangModel = r;
        emit(ShowProductMultiLangSuccessState());
      },
    );
  }

  void deleteProduct({required int productId}) async {
    emit(DeleteProductLoadingState());
    final response =
        await _productsRemoteDatasource.deleteProduct(id: productId);
    response.fold(
      (l) {
        print(l);
        baseErrorModel = l.baseErrorModel;
        emit(DeleteProductErrorState(error: baseErrorModel?.errors?[0] ?? ""));
      },
      (r) async {
        print(r);
        showVendorProfile(id: int.parse(userId!.toString()));
        emit(DeleteProductSuccessState(baseResponseModel: r));
      },
    );
  }

  void uploadProduct({required ProductParameters productParameters}) async {
    emit(UploadProductLoadingState());
    final response = await _productsRemoteDatasource.uploadProduct(
      productParameters: productParameters,
    );
    response.fold(
      (l) {
        baseErrorModel = l.baseErrorModel;
        emit(UploadProductErrorState(error: baseErrorModel?.errors?[0] ?? ""));
      },
      (r) {
        emit(UploadProductSuccessState(updateProductModel: r));
      },
    );
  }

  void addProductReview({
    required ReviewProductParameters reviewProductParameters,
    required String id,
  }) async {
    emit(UploadReviewProductLoadingState());
    final response = await _productsRemoteDatasource.addProductReview(
      id: id,
      reviewProductParameters: reviewProductParameters,
    );
    response.fold(
      (l) {
        baseErrorModel = l.baseErrorModel;
        emit(UploadReviewProductErrorState(
            error: baseErrorModel?.errors?[0] ?? baseErrorModel!.message));
      },
      (r) {
        emit(UploadReviewProductSuccessState(baseResponseModel: r));
      },
    );
  }

  void updateProduct({required ProductParameters productParameters}) async {
    emit(UpdateProductLoadingState());
    final response = await _productsRemoteDatasource.updateProduct(
      productParameters: productParameters,
    );
    response.fold(
      (l) {
        print(l);
        baseErrorModel = l.baseErrorModel;
        emit(UpdateProductErrorState(error: baseErrorModel?.errors?[0] ?? ""));
      },
      (r) {
        emit(UpdateProductSuccessState(updateProductModel: r));
      },
    );
  }

  void changeFavorite({required int id}) async {
    favoriteProduct[id.toString()] = !favoriteProduct[id.toString()];
    emit(WishProductLoadingState());
    final response = await _productsRemoteDatasource.addToFavorite(
      id: id,
    );
    response.fold(
      (l) {
        favoriteProduct[id.toString()] = !favoriteProduct[id.toString()];
        print(l);
        baseErrorModel = l.baseErrorModel;
        emit(WishProductErrorState(error: baseErrorModel?.errors?[0] ?? ""));
      },
      (r) {
        emit(WishProductSuccessState());
      },
    );
  }

  bool getCategory = false;

  void showCategoryDetails({required int categoryId}) async {
    emit(ShowCategoryDetailsLoadingState());
    getCategory = true;
    final response = await _categoriesRemoteDatasource.showCategory(
      id: categoryId,
    );
    response.fold(
      (l) {
        baseErrorModel = l.baseErrorModel;

        getCategory = false;
        emit(ShowCategoryDetailsErrorState(
            error: baseErrorModel?.errors?[0] ?? ""));
      },
      (r) {
        showCategoryModel = r.showCategoryDataModel;

        if (showCategoryModel != null) {
          for (var element in showCategoryModel!.products!) {
            if (element.uploadedBy!.isFollowed != null) {
              if (!followedVendors.containsKey(element.id!.toString())) {
                followedVendors.addAll({
                  element.uploadedBy!.id.toString():
                      element.uploadedBy!.isFollowed
                });
              }
            }
            if (element.isFavorite != null) {
              if (!favoriteProduct.containsKey(element.id!.toString())) {
                favoriteProduct.addAll({
                  element.id.toString():
                  element.isFavorite
                });
              }
            }
          }
          for (var e in showCategoryModel!.subCategories!) {
            if (e.productsList!.isNotEmpty && e.productsList != null) {
              for (var element in e.productsList!) {
                if (element.uploadedBy!.isFollowed != null) {
                  if (!followedVendors.containsKey(element.id!.toString())) {
                    followedVendors.addAll({
                      element.uploadedBy!.id.toString():
                          element.uploadedBy!.isFollowed
                    });
                  }
                  if (element.isFavorite != null) {
                    if (!favoriteProduct.containsKey(element.id!.toString())) {
                      favoriteProduct.addAll({
                        element.id.toString():
                        element.isFavorite
                      });
                    }
                  }
                }
              }
            }
          }
        }
        getCategory = false;
        emit(ShowCategoryDetailsSuccessState());
      },
    );
  }

  bool getAllCategoriesLoading = false;

  void chooseCategory(CategoriesModel? value) {
    productCategory = value;
    showCategoryModel = null;
    showCategoryDetails(categoryId: productCategory!.id!);
    emit(ChangeCategoryState());
  }

  SubCategoriesModel? productSubCategory;

  void chooseSubCategory(SubCategoriesModel? value) {
    productSubCategory = value;
    emit(ChangeCategoryState());
  }

  CategoriesModel? productCategory;

  void getAllCategories() async {
    if (allCategoriesPageNumber == 1) {
      getAllCategoriesLoading = true;
      emit(GetAllCategoriesLoadingState());
    }
    final response = await _categoriesRemoteDatasource.getAllCategories(
      pageNumber: allCategoriesPageNumber,
    );
    response.fold(
      (l) {
        getAllCategoriesLoading = false;
        baseErrorModel = l.baseErrorModel;
        emit(GetAllCategoriesErrorState(error: baseErrorModel?.message ?? ""));
      },
      (r) {
        if (allCategoriesPageNumber <=
            r.getPaginatedCategoriesResultModel!.lastPage!) {
          if (r.getPaginatedCategoriesResultModel!.currentPage! <=
              r.getPaginatedCategoriesResultModel!.lastPage!) {
            categoriesList
                .addAll(r.getPaginatedCategoriesResultModel!.categories!);
            allCategoriesPageNumber++;
          }
          getAllCategoriesLoading = false;
          emit(GetAllCategoriesSuccessState());
        }
      },
    );
  }

  int? selectedServicesCategoryIndex;
  int? selectedCategoryIndex;
  int? selectedSubCategoryIndex;

  void changeCategoriesTabBarWidget(int index,
      {bool isCategories = true, int? categoryId}) {
    if (isCategories) {
      if (index != selectedCategoryIndex) {
        selectedCategoryIndex = index;
        if (categoryId != null) showCategoryDetails(categoryId: categoryId);
        selectedSubCategoryIndex = null;
      } else {
        selectedSubCategoryIndex = null;
        selectedCategoryIndex = null;
        showCategoryModel = null;
      }
    } else {
      if (index != selectedSubCategoryIndex) {
        selectedSubCategoryIndex = index;
      } else {
        selectedSubCategoryIndex = null;
      }
    }
    emit(ChangeCategoriesTabBarWidgetState());
  }

  void changeServicesCategoriesTabBarWidget(
    int index,
  ) {
    if (index != selectedServicesCategoryIndex) {
      selectedServicesCategoryIndex = index;
    } else {
      selectedServicesCategoryIndex = null;
    }
    emit(ChangeServicesCategoriesTabBarWidgetState());
  }

  void handleLogout() {
    emit(ProductsInitial());
  }

  @override
  Future<void> close() {
    handleLogout();
    return super.close();
  }
}
