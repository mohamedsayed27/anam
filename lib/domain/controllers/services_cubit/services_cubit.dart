import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/network/error_message_model.dart';
import '../../../core/parameters/store_parameters.dart';
import '../../../core/services/services_locator.dart';
import '../../../data/models/categories/categories_model.dart';
import '../../../data/models/categories/show_category_model.dart';
import '../../../data/models/categories/sub_categories_model.dart';
import '../../../data/models/laborers_models/laborer_model.dart';
import '../../../core/constants/constants.dart';
import '../../../core/enums/user_type_enum.dart';
import '../../../core/parameters/laborer_parameters.dart';
import '../../../core/parameters/vet_parameters.dart';
import '../../../data/datasources/remote_datasource/categories_remote_datasource.dart';
import '../../../data/datasources/remote_datasource/cities_and_countries_remote_datasource.dart';
import '../../../data/datasources/remote_datasource/laborers_services_remote_datasource.dart';
import '../../../data/datasources/remote_datasource/services_remote_data_source.dart';
import '../../../data/datasources/remote_datasource/stores_services_datasource.dart';
import '../../../data/datasources/remote_datasource/vet_services_remote_datasource.dart';
import '../../../data/models/city_model/city_model.dart';
import '../../../data/models/services/services_model.dart';
import '../../../data/models/stores_models/store_data_model.dart';
import '../../../data/models/vet_models/vet_model.dart';
import 'services_state.dart';

class ServicesCubit extends Cubit<ServicesState> {
  ServicesCubit() : super(ServicesInitial());

  static ServicesCubit get(context) => BlocProvider.of(context);

  final LaborersRemoteDatasource _laborerRemoteDatasource = sl();
  final CitiesAndCountriesRemoteDatasource _citiesAndCountriesRemoteDatasource =
      sl();
  final VetServicesRemoteDatasource _vetServicesRemoteDatasource = sl();
  final StoresServicesRemoteDatasource _storesServicesRemoteDatasource = sl();
  final ServicesRemoteDataSource _servicesRemoteDataSource = sl();
  final CategoriesRemoteDatasource _categoriesRemoteDatasource = sl();

  BaseErrorModel? baseErrorModel;
  List<LaborerModel> laborersList = [];
  List<LaborerModel> userFollowingLaborersList = [];
  LaborerModel? showLaborerModel;
  int allLaborerPageNumber = 1;
  int userFollowingLaborerPageNumber = 1;
  List<VetModel> vetsList = [];
  List<VetModel> userFollowingVetList = [];
  VetModel? showVetModel;
  int allVetPageNumber = 1;
  int allCategoriesPageNumber = 1;
  int userFollowingVetPageNumber = 1;
  List<StoreDataModel> storesList = [];
  List<StoreDataModel> userFollowingStoreList = [];
  StoreDataModel? showStoreModel;
  int allStorePageNumber = 1;
  int userFollowingStorePageNumber = 1;
  int allServicesPageNumber = 1;
  List<ServiceModel> allServicesList = [];
  List<CategoriesModel> categoriesList = [];
  List<CityModel> citiesList = [];
  final TextEditingController laborerNameAr = TextEditingController();
  final TextEditingController laborerNameEn = TextEditingController();
  final TextEditingController vetNameAr = TextEditingController();
  final TextEditingController vetNameEn = TextEditingController();
  final TextEditingController storeNameAr = TextEditingController();
  final TextEditingController storeNameEn = TextEditingController();
  final TextEditingController nationalityAr = TextEditingController();
  final TextEditingController nationalityEn = TextEditingController();
  final TextEditingController professionAr = TextEditingController();
  final TextEditingController professionEn = TextEditingController();
  final TextEditingController laborerAddressAr = TextEditingController();
  final TextEditingController laborerAddressEn = TextEditingController();
  final TextEditingController vetAddressAr = TextEditingController();
  final TextEditingController vetAddressEn = TextEditingController();
  final TextEditingController qualificationsAr = TextEditingController();
  final TextEditingController qualificationsEn = TextEditingController();
  final TextEditingController trunkTypeAr = TextEditingController();
  final TextEditingController trunkTypeEn = TextEditingController();
  final TextEditingController laborerPhone = TextEditingController();
  final TextEditingController vetPhone = TextEditingController();
  final TextEditingController vetEmail = TextEditingController();
  final TextEditingController laborerEmail = TextEditingController();
  final TextEditingController storePhone = TextEditingController();
  final TextEditingController storeEmail = TextEditingController();
  String? mapLocation;
  String? mapCoordinates;
  File? laborerImage;
  File? vetImage;
  File? storeImage;

  Map<String, dynamic> followedVendors = {};
  final _picker = ImagePicker();

  Future<void> getImagePick() async {
    final pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      emit(GetPickedImageSuccessState(pickedImage: File(pickedFile.path)));
    } else {
      emit(GetPickedImageErrorState());
    }
  }

  List<File> storeImages = [];

  Future<void> getMultiImagePick() async {
    final pickedFile = await _picker.pickMultiImage();
    final List<File> storeImages = pickedFile.map((e) => File(e.path)).toList();
    this.storeImages = storeImages;
    emit(GetPickedMultiImageSuccessState());
  }

  void getLocation({
    required String locationName,
    required String coordinates,
  }) {
    mapLocation = locationName;
    mapCoordinates = coordinates;
    emit(GetLocationNameAndCoordinates());
  }

  /// --------------------------------------> Laborer Logic Methods <--------------------------------------
  void getAllLaborer() async {
    if (allLaborerPageNumber == 1) {
      emit(GetAllLaborerLoadingState());
    }
    final response = await _laborerRemoteDatasource.getAll(
      pageNumber: allLaborerPageNumber,
    );
    response.fold(
      (l) {
        baseErrorModel = l.baseErrorModel;
        emit(GetAllLaborerErrorState(error: baseErrorModel?.message ?? ""));
      },
      (r) {
        if (r.storePaginatedModel!.lastPage != null) {
          if (allLaborerPageNumber <= r.storePaginatedModel!.lastPage!) {
            if (r.storePaginatedModel!.currentPage! <=
                r.storePaginatedModel!.lastPage!) {
              laborersList.addAll(r.storePaginatedModel!.laborerList!);
              for (var element in laborersList) {
                if (element.vendor!.isFollowed != null) {
                  if (!followedVendors.containsKey(element.id!.toString())) {
                    followedVendors.addAll({
                      element.vendor!.id.toString(): element.vendor!.isFollowed
                    });
                  }
                }
              }
              allLaborerPageNumber++;
            }
            emit(GetAllLaborerSuccessState());
          }
        }
      },
    );
  }

  void getUserFollowingLaborer() async {
    if (userFollowingLaborerPageNumber == 1) {
      emit(GetUserFollowingLaborerLoadingState());
    }
    final response = await _laborerRemoteDatasource.getUserFollowing(
      pageNumber: userFollowingLaborerPageNumber,
    );
    response.fold(
      (l) {
        baseErrorModel = l.baseErrorModel;
        emit(GetUserFollowingLaborerErrorState(
            error: baseErrorModel?.message ?? ""));
      },
      (r) {
        if (r.storePaginatedModel!.lastPage != null) {
          if (userFollowingLaborerPageNumber <=
              r.storePaginatedModel!.lastPage!) {
            if (r.storePaginatedModel!.currentPage! <=
                r.storePaginatedModel!.lastPage!) {
              if (userType == UserTypeEnum.user.name) {
                userFollowingLaborersList
                    .addAll(r.storePaginatedModel!.laborerList!);
                for (var element in userFollowingLaborersList) {
                  if (element.vendor!.isFollowed != null) {
                    if (!followedVendors.containsKey(element.id!.toString())) {
                      followedVendors.addAll({
                        element.vendor!.id.toString():
                            element.vendor!.isFollowed
                      });
                    }
                  }
                }
                userFollowingLaborerPageNumber++;
              }
            }
            emit(GetUserFollowingLaborerSuccessState());
          }
        }
      },
    );
  }

  void showLaborerDetails({required int productId}) async {
    emit(ShowLaborerDetailsLoadingState());
    final response = await _laborerRemoteDatasource.showSingle(id: productId);
    response.fold(
      (l) {
        baseErrorModel = l.baseErrorModel;
        emit(ShowLaborerDetailsErrorState(
            error: baseErrorModel?.errors?[0] ?? ""));
      },
      (r) async {
        showLaborerModel = r;
        emit(ShowLaborerDetailsSuccessState());
      },
    );
  }

  bool getAllCitiesLoading = false;

  void getAllCities() async {
    getAllCitiesLoading = true;
    emit(GetCitiesLoadingState());
    final response = await _citiesAndCountriesRemoteDatasource.getAllCities();
    response.fold(
      (l) {
        getAllCitiesLoading = false;
        baseErrorModel = l.baseErrorModel;
        emit(GetCitiesErrorState(error: baseErrorModel?.errors?[0] ?? ""));
      },
      (r) async {
        getAllCitiesLoading = false;
        citiesList = r.citiesList!;
        emit(GetCitiesSuccessState());
      },
    );
  }

  void deleteLaborer({required int productId}) async {
    emit(DeleteLaborerLoadingState());
    final response = await _laborerRemoteDatasource.delete(id: productId);
    response.fold(
      (l) {
        baseErrorModel = l.baseErrorModel;
        emit(DeleteLaborerErrorState(error: baseErrorModel?.errors?[0] ?? ""));
      },
      (r) async {
        emit(DeleteLaborerSuccessState(baseResponseModel: r));
      },
    );
  }

  void uploadLaborer({required LaborerParameters productParameters}) async {
    emit(UploadLaborerLoadingState());
    final response = await _laborerRemoteDatasource.upload(
      parameters: productParameters,
    );
    response.fold(
      (l) {
        baseErrorModel = l.baseErrorModel;
        emit(UploadLaborerErrorState(error: baseErrorModel?.errors?[0] ?? ""));
      },
      (r) {
        emit(UploadLaborerSuccessState());
      },
    );
  }

  void updateLaborer({required LaborerParameters productParameters}) async {
    emit(UpdateLaborerLoadingState());
    final response = await _laborerRemoteDatasource.update(
      parameters: productParameters,
    );
    response.fold(
      (l) {
        baseErrorModel = l.baseErrorModel;
        emit(UpdateLaborerErrorState(error: baseErrorModel?.errors?[0] ?? ""));
      },
      (r) {
        emit(UpdateLaborerSuccessState());
      },
    );
  }

  /// --------------------------------------> Vet Logic Methods <--------------------------------------
  void getAllVet() async {
    if (allVetPageNumber == 1) {
      emit(GetAllVetLoadingState());
    }
    final response = await _vetServicesRemoteDatasource.getAll(
      pageNumber: allVetPageNumber,
    );
    response.fold(
      (l) {
        baseErrorModel = l.baseErrorModel;
        emit(GetAllVetErrorState(error: baseErrorModel?.message ?? ""));
      },
      (r) {
        if (allVetPageNumber <= r.storePaginatedModel!.lastPage!) {
          if (r.storePaginatedModel!.currentPage! <=
              r.storePaginatedModel!.lastPage!) {
            vetsList.addAll(r.storePaginatedModel!.vetList!);
            for (var element in vetsList) {
              if (element.vendor!.isFollowed != null) {
                if (!followedVendors.containsKey(element.id!.toString())) {
                  followedVendors.addAll({
                    element.vendor!.id.toString(): element.vendor!.isFollowed
                  });
                }
              }
            }
            allVetPageNumber++;
          }
          emit(GetAllLaborerSuccessState());
        }
      },
    );
  }

  void getUserFollowingVet() async {
    if (userFollowingVetPageNumber == 1) {
      emit(GetUserFollowingVetLoadingState());
    }
    final response = await _vetServicesRemoteDatasource.getUserFollowing(
      pageNumber: userFollowingVetPageNumber,
    );
    response.fold(
      (l) {
        baseErrorModel = l.baseErrorModel;
        emit(GetUserFollowingVetErrorState(
            error: baseErrorModel?.message ?? ""));
      },
      (r) {
        if (r.storePaginatedModel != null) {
          if (userFollowingVetPageNumber <= r.storePaginatedModel!.lastPage!) {
            if (r.storePaginatedModel!.currentPage! <=
                r.storePaginatedModel!.lastPage!) {
              if (userType == UserTypeEnum.user.name) {
                userFollowingVetList.addAll(r.storePaginatedModel!.vetList!);
                for (var element in userFollowingVetList) {
                  if (element.vendor!.isFollowed != null) {
                    if (!followedVendors.containsKey(element.id!.toString())) {
                      followedVendors.addAll({
                        element.vendor!.id.toString():
                            element.vendor!.isFollowed
                      });
                    }
                  }
                }
                userFollowingVetPageNumber++;
              }
            }
          }
          emit(GetUserFollowingVetSuccessState());
        } else {
          userFollowingVetList = [];
          emit(GetUserFollowingVetSuccessState());
        }
      },
    );
  }

  void showVetDetails({required int productId}) async {
    emit(ShowVetDetailsLoadingState());
    final response =
        await _vetServicesRemoteDatasource.showSingle(id: productId);
    response.fold(
      (l) {
        baseErrorModel = l.baseErrorModel;
        emit(ShowVetDetailsErrorState(error: baseErrorModel?.errors?[0] ?? ""));
      },
      (r) async {
        showVetModel = r;
        emit(ShowVetDetailsSuccessState());
      },
    );
  }

  void deleteVet({required int productId}) async {
    emit(DeleteVetLoadingState());
    final response = await _vetServicesRemoteDatasource.delete(id: productId);
    response.fold(
      (l) {
        baseErrorModel = l.baseErrorModel;
        emit(DeleteVetErrorState(error: baseErrorModel?.errors?[0] ?? ""));
      },
      (r) async {
        emit(DeleteVetSuccessState(baseResponseModel: r));
      },
    );
  }

  void uploadVet({required VetParameters vetParameters}) async {
    emit(UploadVetLoadingState());
    final response = await _vetServicesRemoteDatasource.upload(
      parameters: vetParameters,
    );
    response.fold(
      (l) {
        baseErrorModel = l.baseErrorModel;
        emit(UploadVetErrorState(error: baseErrorModel?.errors?[0] ?? ""));
      },
      (r) {
        emit(UploadVetSuccessState());
      },
    );
  }

  void updateVet({required VetParameters vetParameters}) async {
    emit(UpdateVetLoadingState());
    final response = await _vetServicesRemoteDatasource.update(
      parameters: vetParameters,
    );
    response.fold(
      (l) {
        baseErrorModel = l.baseErrorModel;
        emit(UpdateVetErrorState(error: baseErrorModel?.errors?[0] ?? ""));
      },
      (r) {
        emit(UpdateVetSuccessState());
      },
    );
  }

  /// --------------------------------------> Store Logic Methods <--------------------------------------
  void getAllStore() async {
    if (allStorePageNumber == 1) {
      emit(GetAllStoreLoadingState());
    }
    final response = await _storesServicesRemoteDatasource.getAll(
      pageNumber: allStorePageNumber,
    );
    response.fold(
      (l) {
        baseErrorModel = l.baseErrorModel;
        emit(GetAllStoreErrorState(error: baseErrorModel?.message ?? ""));
      },
      (r) {
        if (r.storePaginatedModel!.lastPage != null) {
          if (allStorePageNumber <= r.storePaginatedModel!.lastPage!) {
            if (r.storePaginatedModel!.currentPage! <=
                r.storePaginatedModel!.lastPage!) {
              storesList.addAll(r.storePaginatedModel!.storeList!);
              for (var element in storesList) {
                if (element.vendor!.isFollowed != null) {
                  if (!followedVendors.containsKey(element.id!.toString())) {
                    followedVendors.addAll({
                      element.vendor!.id.toString(): element.vendor!.isFollowed
                    });
                  }
                }
              }
              allStorePageNumber++;
            }

            emit(GetAllStoreSuccessState());
          }
        }
      },
    );
  }

  void getUserFollowingStore() async {
    if (userFollowingStorePageNumber == 1) {
      emit(GetUserFollowingStoreLoadingState());
    }
    final response = await _storesServicesRemoteDatasource.getUserFollowing(
      pageNumber: userFollowingStorePageNumber,
    );
    response.fold(
      (l) {
        baseErrorModel = l.baseErrorModel;
        emit(GetUserFollowingStoreErrorState(
            error: baseErrorModel?.message ?? ""));
      },
      (r) {
        if (r.storePaginatedModel!.lastPage != null) {
          if (userFollowingStorePageNumber <=
              r.storePaginatedModel!.lastPage!) {
            if (r.storePaginatedModel!.currentPage! <=
                r.storePaginatedModel!.lastPage!) {
              if (userType == UserTypeEnum.user.name) {
                userFollowingStoreList
                    .addAll(r.storePaginatedModel!.storeList!);
                for (var element in userFollowingStoreList) {
                  if (element.vendor!.isFollowed != null) {
                    if (!followedVendors.containsKey(element.id!.toString())) {
                      followedVendors.addAll({
                        element.vendor!.id.toString():
                            element.vendor!.isFollowed
                      });
                    }
                  }
                }
                userFollowingStorePageNumber++;
              }
            }
            emit(GetUserFollowingStoreSuccessState());
          }
        }
      },
    );
  }

  void showStoreDetails({required int productId}) async {
    emit(ShowStoreDetailsLoadingState());
    final response =
        await _storesServicesRemoteDatasource.showSingle(id: productId);
    response.fold(
      (l) {
        baseErrorModel = l.baseErrorModel;
        emit(ShowStoreDetailsErrorState(
            error: baseErrorModel?.errors?[0] ?? ""));
      },
      (r) async {
        showStoreModel = r;
        emit(ShowStoreDetailsSuccessState());
      },
    );
  }

  void deleteStore({required int productId}) async {
    emit(DeleteStoreLoadingState());
    final response =
        await _storesServicesRemoteDatasource.delete(id: productId);
    response.fold(
      (l) {
        baseErrorModel = l.baseErrorModel;
        emit(DeleteStoreErrorState(error: baseErrorModel?.errors?[0] ?? ""));
      },
      (r) async {
        emit(DeleteStoreSuccessState(baseResponseModel: r));
      },
    );
  }

  void uploadStore({required StoreParameters storeParameters}) async {
    emit(UploadStoreLoadingState());
    final response = await _storesServicesRemoteDatasource.upload(
      parameters: storeParameters,
    );
    response.fold(
      (l) {
        baseErrorModel = l.baseErrorModel;
        emit(UploadStoreErrorState(error: baseErrorModel?.errors?[0] ?? ""));
      },
      (r) {
        emit(UploadStoreSuccessState());
      },
    );
  }

  void updateStore({
    required StoreParameters vetParameters,
  }) async {
    emit(UpdateStoreLoadingState());
    final response = await _storesServicesRemoteDatasource.update(
      parameters: vetParameters,
    );
    response.fold(
      (l) {
        baseErrorModel = l.baseErrorModel;
        emit(UpdateStoreErrorState(error: baseErrorModel?.errors?[0] ?? ""));
      },
      (r) {
        emit(UpdateStoreSuccessState());
      },
    );
  }

  bool getAllServicesLoading = false;
  ServiceModel? selectedServicesValue;

  void getAllServices() async {
    getAllServicesLoading = true;
    emit(GetAllServicesLoadingState());
    final response = await _servicesRemoteDataSource.getAllServices(
      pageNumber: allServicesPageNumber,
    );
    response.fold(
      (l) {
        baseErrorModel = l.baseErrorModel;
        getAllServicesLoading = false;
        emit(GetAllServicesErrorState(error: baseErrorModel?.message ?? ""));
      },
      (r) {
        if (allServicesPageNumber <= r.servicesPaginatedModel!.lastPage!) {
          if (r.servicesPaginatedModel!.currentPage! <=
              r.servicesPaginatedModel!.lastPage!) {
            allServicesList.addAll(r.servicesPaginatedModel!.allServicesList!
                .where((element) => element.type != null));
            allServicesPageNumber++;
          }
          getAllServicesLoading = false;
          selectedServicesValue = allServicesList[0];
          selectedServicesCategoryIndex = 0;
          emit(GetAllServicesSuccessState());
        }
      },
    );
  }

  late int selectedServicesCategoryIndex;

  void changeServicesCategoriesTabBarWidget(
    int index,
  ) {
    if (index != selectedServicesCategoryIndex) {
      selectedServicesCategoryIndex = index;
      selectedServicesValue = allServicesList[selectedServicesCategoryIndex];
      emit(ChangeServicesCategoriesTabBarWidgetState());
    }
  }

  void handleLogout() {
    emit(ServicesInitial());
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

        getCategory = false;
        emit(ShowCategoryDetailsSuccessState());
      },
    );
  }

  ShowCategoryDataModel? showCategoryModel;

  bool getAllCategoriesLoading = false;

  void chooseCategory(CategoriesModel? value) {
    productCategory = value;
    showCategoryModel = null;
    showCategoryDetails(categoryId: productCategory!.id!);
    emit(ChangeCategoryState());
  }

  CityModel? chosenCity;

  void chooseCity(CityModel? value) {
    chosenCity = value;
    emit(ChangeCategoryState());
  }

  SubCategoriesModel? productSubCategory;

  void chooseSubCategory(SubCategoriesModel? value) {
    productSubCategory = value;
    emit(ChangeCategoryState());
  }

  CategoriesModel? productCategory;

  void getAllCategories() async {
    getAllCategoriesLoading = true;
    emit(GetAllCategoriesLoadingState());
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

  @override
  Future<void> close() {
    laborerNameAr.dispose();
    laborerNameEn.dispose();
    storeNameAr.dispose();
    storeNameEn.dispose();
    nationalityAr.dispose();
    nationalityEn.dispose();
    professionAr.dispose();
    professionEn.dispose();
    laborerAddressAr.dispose();
    laborerAddressEn.dispose();
    laborerPhone.dispose();
    laborerEmail.dispose();
    storePhone.dispose();
    storeEmail.dispose();
    handleLogout();
    return super.close();
  }
}
