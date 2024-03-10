
abstract class RequestsState {}

class RequestsInitial extends RequestsState {}

class GetAllRequestsLoadingState extends RequestsState {}
class GetAllRequestsSuccessState extends RequestsState {}
class GetAllRequestsErrorState extends RequestsState {
  final String error;

  GetAllRequestsErrorState({required this.error});
}

class GetLocationNameAndCoordinates extends RequestsState {
  final String mapLocation;
  final String coordinates;

  GetLocationNameAndCoordinates({required this.mapLocation, required this.coordinates});
}
class ShowRequestLoadingState extends RequestsState {}
class ShowRequestSuccessState extends RequestsState {}
class ShowRequestErrorState extends RequestsState {
  final String error;

  ShowRequestErrorState({required this.error});
}

class GetPreviousRequestsLoadingState extends RequestsState {}
class GetPreviousRequestsSuccessState extends RequestsState {}
class GetPreviousRequestsErrorState extends RequestsState {
  final String error;

  GetPreviousRequestsErrorState({required this.error});
}

class ChangeCityState extends RequestsState{}



class GetAllCountriesLoadingState extends RequestsState {}

class GetAllCountriesSuccessState extends RequestsState {}

class GetAllCountriesErrorState extends RequestsState {
  final String error;

  GetAllCountriesErrorState({required this.error});
}


class SendRequestLoadingState extends RequestsState {}

class SendRequestSuccessState extends RequestsState {}

class SendRequestErrorState extends RequestsState {
  final String error;

  SendRequestErrorState({required this.error});
}