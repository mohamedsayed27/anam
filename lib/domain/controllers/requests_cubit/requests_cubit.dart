import 'package:anam/data/models/requests/request_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/network/error_message_model.dart';
import '../../../core/services/services_locator.dart';
import '../../../data/datasources/remote_datasource/requests_remote_datasource.dart';
import 'requests_state.dart';

class RequestsCubit extends Cubit<RequestsState> {
  RequestsCubit() : super(RequestsInitial());
  final RequestsRemoteDatasource _requestsRemoteDatasource = sl();
static RequestsCubit get(context) => BlocProvider.of(context);


  BaseErrorModel? baseErrorModel;
  List<RequestModel> requestList = [];
  bool getAllRequestsLoading = false;
  int allRequestsPageNumber = 1;

  RequestModel? requestModel;

  List<RequestModel> previousRequestList = [];
  int previousRequestsPageNumber = 1;


  void getAllServices() async {
    getAllRequestsLoading = true;
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


  void getPreviousServices() async {
    getAllRequestsLoading = true;
    emit(GetPreviousRequestsLoadingState());
    final response = await _requestsRemoteDatasource.getPreviousRequests(
      pageNumber: previousRequestsPageNumber,
    );
    response.fold(
          (l) {
        baseErrorModel = l.baseErrorModel;
        getAllRequestsLoading = false;
        emit(GetPreviousRequestsErrorState(error: baseErrorModel?.message ?? ""));
      },
          (r) {
        if (previousRequestsPageNumber <= r.requestsPaginatedModel!.lastPage!) {
          if (r.requestsPaginatedModel!.currentPage! <=
              r.requestsPaginatedModel!.lastPage!) {
            previousRequestList.addAll(r.requestsPaginatedModel!.requestModel!);
            previousRequestsPageNumber++;
          }
          getAllRequestsLoading = false;
          emit(GetPreviousRequestsSuccessState());
        }
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
