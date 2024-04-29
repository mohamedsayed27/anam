import 'package:anam/data/models/requests/request_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/network/error_message_model.dart';
import '../../../core/parameters/request_parameters.dart';
import '../../../core/services/services_locator.dart';
import '../../../data/datasources/remote_datasource/cities_and_countries_remote_datasource.dart';
import '../../../data/datasources/remote_datasource/requests_remote_datasource.dart';
import '../../../data/models/country_model/country_model.dart';
import 'requests_state.dart';

class RequestsCubit extends Cubit<RequestsState> {
  RequestsCubit() : super(RequestsInitial());
  final RequestsRemoteDatasource _requestsRemoteDatasource = sl();
  final CitiesAndCountriesRemoteDatasource citiesAndCountriesRemoteDatasource = sl();
  static RequestsCubit get(context) => BlocProvider.of(context);
  final TextEditingController notes = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController details = TextEditingController();
  final TextEditingController price = TextEditingController();

  BaseErrorModel? baseErrorModel;
  List<RequestModel> requestList = [];
  bool getAllRequestsLoading = false;
  int allRequestsPageNumber = 1;

  String? mapLocation;
  String? mapCoordinates;
  RequestModel? requestModel;

  List<RequestModel> previousRequestList = [];
  int previousRequestsPageNumber = 1;

  List<CountryModel> countriesList = [];
  CountryModel? chosenCity;

  void getLocation({
    required String locationName,
    required String coordinates,
  }) {
    mapLocation = locationName;
    mapCoordinates = coordinates;
    emit(GetLocationNameAndCoordinates(
        mapLocation: locationName, coordinates: coordinates));
  }

  void getAllRequests() async {
    if(allRequestsPageNumber==1){
      getAllRequestsLoading = true;
    }
    emit(GetAllRequestsLoadingState());
    final response = await _requestsRemoteDatasource.getAllRequests(
      pageNumber: allRequestsPageNumber,
    );
    response.fold(
      (l) {
        baseErrorModel = l.baseErrorModel;
        getAllRequestsLoading = false;
        emit(GetAllRequestsErrorState(error: baseErrorModel?.message ?? ""));
      },
      (r) {
        if (allRequestsPageNumber <= r.requestsPaginatedModel!.lastPage!) {
          if (r.requestsPaginatedModel!.currentPage! <=
              r.requestsPaginatedModel!.lastPage!) {
            requestList.addAll(r.requestsPaginatedModel!.requestModel!);
            allRequestsPageNumber++;
          }
          getAllRequestsLoading = false;
          emit(GetAllRequestsSuccessState());
        }
      },
    );
  }

  void getPreviousRequests() async {
    if(previousRequestsPageNumber==1) {
      getAllRequestsLoading = true;
    }
    emit(GetPreviousRequestsLoadingState());
    final response = await _requestsRemoteDatasource.getPreviousRequests(
      pageNumber: previousRequestsPageNumber,
    );
    response.fold(
      (l) {
        baseErrorModel = l.baseErrorModel;
        if(previousRequestsPageNumber==1) {
          getAllRequestsLoading = false;
        }
        emit(GetPreviousRequestsErrorState(
            error: baseErrorModel?.message ?? ""));
      },
      (r) {
        if (previousRequestsPageNumber <= r.requestsPaginatedModel!.lastPage!) {
          if (r.requestsPaginatedModel!.currentPage! <=
              r.requestsPaginatedModel!.lastPage!) {
            previousRequestList.addAll(r.requestsPaginatedModel!.requestModel??[]);
            previousRequestsPageNumber++;
          }

          if(previousRequestsPageNumber==1) {
            getAllRequestsLoading = false;
          }
          emit(GetPreviousRequestsSuccessState());
        }
      },
    );
  }

  void changeCity(CountryModel? value) {
    chosenCity = value;
    emit(ChangeCityState());
  }

  void getAllCountries() async {
    emit(GetAllCountriesLoadingState());
    final response = await citiesAndCountriesRemoteDatasource.getAllCountries();
    response.fold(
      (l) {
        baseErrorModel = l.baseErrorModel;
        emit(GetAllCountriesErrorState(error: baseErrorModel?.message ?? ""));
      },
      (r) {
        countriesList.addAll(r.countriesList!);
        emit(GetAllCountriesSuccessState());
      },
    );
  }

  void sendRequest({
    required RequestParameters requestParameters,
  }) async {
    emit(SendRequestLoadingState());
    final response = await _requestsRemoteDatasource.sendRequest(
      requestParameters: requestParameters,
    );
    response.fold(
      (l) {
        baseErrorModel = l.baseErrorModel;
        emit(SendRequestErrorState(error: baseErrorModel?.message ?? ""));
      },
      (r) {
        emit(SendRequestSuccessState());
      },
    );
  }

  void handleLogout() {
    emit(RequestsInitial());
  }

  @override
  Future<void> close() {
    handleLogout();
    return super.close();
  }
}
