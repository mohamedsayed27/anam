import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'services_state.dart';

class ServicesCubit extends Cubit<ServicesState> {
  ServicesCubit() : super(ServicesInitial());
}
