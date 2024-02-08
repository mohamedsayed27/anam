import 'package:anam/core/constants/constants.dart';
import 'package:anam/core/enums/user_type_enum.dart';
import 'package:anam/presentation/screens/main_layout_screens/orders_screens/orders_screen.dart';
import 'package:anam/presentation/screens/main_layout_screens/profile_screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../presentation/screens/main_layout_screens/conversations_screens/conversations_screen.dart';
import '../../../presentation/screens/main_layout_screens/favorite_screens/favorites_screen.dart';
import '../../../presentation/screens/main_layout_screens/home_screen/home_screen.dart';
import 'main_layout_state.dart';

class MainLayoutCubit extends Cubit<MainLayoutState> {
  MainLayoutCubit() : super(MainLayoutInitial());

  static MainLayoutCubit get(context) => BlocProvider.of(context);

  List<Widget> screens = [
    const ProfileScreen(),
    const ConversationsScreen(),
    const HomeScreen(),
    if(userType==UserTypeEnum.user.name&&token!=null) const FavoritesScreen(),
    if(userType==UserTypeEnum.vendor.name&&token!=null)const OrdersScreen(isPreviousOrders: false,),
  ];

  int currentIndex = 2;

  void changeNavBarIndex(int index){
    currentIndex = index;
    emit(ChangeBottomNavBarIndexState());
  }

  void handleLogout() {
    emit(MainLayoutInitial());
  }

  @override
  Future<void> close() {
    handleLogout();
    return super.close();
  }
}
