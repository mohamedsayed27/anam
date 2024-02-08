
abstract class RequestsState {}

class RequestsInitial extends RequestsState {}

class GetAllRequestsLoadingState extends RequestsState {}
class GetAllRequestsSuccessState extends RequestsState {}
class GetAllRequestsErrorState extends RequestsState {
  final String error;

  GetAllRequestsErrorState({required this.error});
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
