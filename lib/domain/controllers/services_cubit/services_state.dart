import 'dart:io';

import '../../../data/models/base_model.dart';

abstract class ServicesState {}

class ServicesInitial extends ServicesState {}


class GetAllLaborerLoadingState extends ServicesState {}

class GetAllLaborerSuccessState extends ServicesState {}

class GetAllLaborerErrorState extends ServicesState {
  final String error;

  GetAllLaborerErrorState({required this.error});
}

class GetUserFollowingLaborerLoadingState extends ServicesState {}

class GetUserFollowingLaborerSuccessState extends ServicesState {}

class GetUserFollowingLaborerErrorState extends ServicesState {
  final String error;

  GetUserFollowingLaborerErrorState({required this.error});
}

class ShowLaborerDetailsLoadingState extends ServicesState {}

class ShowLaborerDetailsSuccessState extends ServicesState {}

class ShowLaborerDetailsErrorState extends ServicesState {
  final String error;

  ShowLaborerDetailsErrorState({required this.error});
}

class ShowLaborerMultiLangLoadingState extends ServicesState {}

class ShowLaborerMultiLangSuccessState extends ServicesState {}

class ShowLaborerMultiLangErrorState extends ServicesState {
  final String error;

  ShowLaborerMultiLangErrorState({required this.error});
}


class ShowVetMultiLangLoadingState extends ServicesState {}

class ShowVetMultiLangSuccessState extends ServicesState {}

class ShowVetMultiLangErrorState extends ServicesState {
  final String error;

  ShowVetMultiLangErrorState({required this.error});
}


class ShowStoreMultiLangLoadingState extends ServicesState {}

class ShowStoreMultiLangSuccessState extends ServicesState {}

class ShowStoreMultiLangErrorState extends ServicesState {
  final String error;

  ShowStoreMultiLangErrorState({required this.error});
}

class GetCitiesLoadingState extends ServicesState {}

class GetCitiesSuccessState extends ServicesState {}

class GetCitiesErrorState extends ServicesState {
  final String error;

  GetCitiesErrorState({required this.error});
}

class DeleteLaborerLoadingState extends ServicesState {}

class DeleteLaborerSuccessState extends ServicesState {
  final BaseResponseModel baseResponseModel;

  DeleteLaborerSuccessState({required this.baseResponseModel});
}

class DeleteLaborerErrorState extends ServicesState {
  final String error;

  DeleteLaborerErrorState({required this.error});
}

class UploadLaborerLoadingState extends ServicesState {}

class UploadLaborerSuccessState extends ServicesState {

}

class UploadLaborerErrorState extends ServicesState {
  final String error;

  UploadLaborerErrorState({required this.error});
}

class UpdateLaborerLoadingState extends ServicesState {}

class UpdateLaborerSuccessState extends ServicesState {

}

class UpdateLaborerErrorState extends ServicesState {
  final String error;

  UpdateLaborerErrorState({required this.error});
}



class GetAllVetLoadingState extends ServicesState {}

class GetAllVetSuccessState extends ServicesState {}

class GetAllVetErrorState extends ServicesState {
  final String error;

  GetAllVetErrorState({required this.error});
}

class GetUserFollowingVetLoadingState extends ServicesState {}

class GetUserFollowingVetSuccessState extends ServicesState {}

class GetUserFollowingVetErrorState extends ServicesState {
  final String error;

  GetUserFollowingVetErrorState({required this.error});
}

class ShowVetDetailsLoadingState extends ServicesState {}

class ShowVetDetailsSuccessState extends ServicesState {}

class ShowVetDetailsErrorState extends ServicesState {
  final String error;

  ShowVetDetailsErrorState({required this.error});
}

class DeleteVetLoadingState extends ServicesState {}

class DeleteVetSuccessState extends ServicesState {
  final BaseResponseModel baseResponseModel;

  DeleteVetSuccessState({required this.baseResponseModel});
}

class DeleteVetErrorState extends ServicesState {
  final String error;

  DeleteVetErrorState({required this.error});
}

class UploadVetLoadingState extends ServicesState {}

class UploadVetSuccessState extends ServicesState {

}

class UploadVetErrorState extends ServicesState {
  final String error;

  UploadVetErrorState({required this.error});
}

class UpdateVetLoadingState extends ServicesState {}

class UpdateVetSuccessState extends ServicesState {

}

class UpdateVetErrorState extends ServicesState {
  final String error;

  UpdateVetErrorState({required this.error});
}



class GetAllStoreLoadingState extends ServicesState {}

class GetAllStoreSuccessState extends ServicesState {}

class GetAllStoreErrorState extends ServicesState {
  final String error;

  GetAllStoreErrorState({required this.error});
}

class GetUserFollowingStoreLoadingState extends ServicesState {}

class GetUserFollowingStoreSuccessState extends ServicesState {}

class GetUserFollowingStoreErrorState extends ServicesState {
  final String error;

  GetUserFollowingStoreErrorState({required this.error});
}

class ShowStoreDetailsLoadingState extends ServicesState {}

class ShowStoreDetailsSuccessState extends ServicesState {}

class ShowStoreDetailsErrorState extends ServicesState {
  final String error;

  ShowStoreDetailsErrorState({required this.error});
}

class DeleteStoreLoadingState extends ServicesState {}

class DeleteStoreSuccessState extends ServicesState {
  final BaseResponseModel baseResponseModel;

  DeleteStoreSuccessState({required this.baseResponseModel});
}

class DeleteStoreErrorState extends ServicesState {
  final String error;

  DeleteStoreErrorState({required this.error});
}

class UploadStoreLoadingState extends ServicesState {}

class UploadStoreSuccessState extends ServicesState {

}

class UploadStoreErrorState extends ServicesState {
  final String error;

  UploadStoreErrorState({required this.error});
}

class UpdateStoreLoadingState extends ServicesState {}

class UpdateStoreSuccessState extends ServicesState {

}

class UpdateStoreErrorState extends ServicesState {
  final String error;

  UpdateStoreErrorState({required this.error});
}




class ChangeServicesCategoriesTabBarWidgetState extends ServicesState {}
class GetLocationNameAndCoordinates extends ServicesState {}


class GetAllServicesLoadingState extends ServicesState {}

class GetAllServicesSuccessState extends ServicesState {

}

class GetAllServicesErrorState extends ServicesState {
  final String error;

  GetAllServicesErrorState({required this.error});
}


class GetPickedImageSuccessState extends ServicesState {
  final File? pickedImage;
  GetPickedImageSuccessState({this.pickedImage});
}

class GetPickedImageErrorState extends ServicesState {
  GetPickedImageErrorState();
}

class GetPickedMultiImageSuccessState extends ServicesState {
  GetPickedMultiImageSuccessState();
}





class ShowCategoryDetailsLoadingState extends ServicesState {}

class ShowCategoryDetailsSuccessState extends ServicesState {}

class ShowCategoryDetailsErrorState extends ServicesState {
  final String error;

  ShowCategoryDetailsErrorState({required this.error});
}

class ChangeCategoryState extends ServicesState {}


class GetAllCategoriesLoadingState extends ServicesState {}

class GetAllCategoriesSuccessState extends ServicesState {}

class GetAllCategoriesErrorState extends ServicesState {
  final String error;

  GetAllCategoriesErrorState({required this.error});
}
