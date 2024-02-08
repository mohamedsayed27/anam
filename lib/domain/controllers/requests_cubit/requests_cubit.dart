import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'requests_state.dart';

class RequestsCubit extends Cubit<RequestsState> {
  RequestsCubit() : super(RequestsInitial());
}
