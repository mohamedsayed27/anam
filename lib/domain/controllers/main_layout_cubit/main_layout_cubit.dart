import 'package:anam/core/cache_helper/cache_keys.dart';
import 'package:anam/core/cache_helper/shared_pref_methods.dart';
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
    if(CacheHelper.getData(key: CacheKeys.token)!=null)const ConversationsScreen(),
    const HomeScreen(),
    if(CacheHelper.getData(key: CacheKeys.userType)==UserTypeEnum.user.name&&CacheHelper.getData(key: CacheKeys.token)!=null) const FavoritesScreen(),
    if(CacheHelper.getData(key: CacheKeys.userType)==UserTypeEnum.vendor.name&&CacheHelper.getData(key: CacheKeys.token)!=null)const OrdersScreen(isPreviousOrders: false,),
  ];

  int currentIndex = CacheHelper.getData(key: CacheKeys.token)!=null?2:1;

  void changeNavBarIndex(int index){
    currentIndex = index;
    emit(ChangeBottomNavBarIndexState());
  }

  void handleAuthMethods() {
    print("handleAuthMethods");
    print(CacheHelper.getData(key: CacheKeys.userType));
    print(CacheHelper.getData(key: CacheKeys.token));
    currentIndex = CacheHelper.getData(key: CacheKeys.token)!=null?2:1;
    screens = [
      const ProfileScreen(),
      if(CacheHelper.getData(key: CacheKeys.token)!=null)const ConversationsScreen(),
      const HomeScreen(),
      if(CacheHelper.getData(key: CacheKeys.userType).toString()==UserTypeEnum.user.name&&CacheHelper.getData(key: CacheKeys.token)!=null) const FavoritesScreen(),
      if(CacheHelper.getData(key: CacheKeys.userType).toString()==UserTypeEnum.vendor.name&&CacheHelper.getData(key: CacheKeys.token)!=null)const OrdersScreen(isPreviousOrders: false,),
    ];
    print(screens.length);
    emit(HandleAuthMethodsState());
  }
}
