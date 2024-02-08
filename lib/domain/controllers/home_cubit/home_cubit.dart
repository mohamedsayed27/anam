import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/assets_path/images_path.dart';
import '../../../core/assets_path/svg_path.dart';
import '../../../core/enums/services_type_enum.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  static HomeCubit get(context) => BlocProvider.of(context);

  List<Map<String, dynamic>> productCategoriesAndSubCategoriesItemsList = [
    {
      "title": "الطيور",
      "image": SvgPath.chicken,
      "subCategories": [
        "البط",
        "الاوز",
        "الحمام",
        "البط",
        "الاوز",
        "الحمام",
        "البط",
        "الاوز",
        "البط",
        "الاوز",
        "الحمام"
      ],
    },
    {
      "title": "الأغنام",
      "image": SvgPath.sheep,
      "subCategories": [
        "الماعز",
        "الخرفان",
        "الماعز",
        "الخرفان",
      ],
    },
    {
      "title": "مستلزمات الرحله",
      "image": SvgPath.tent,
      "subCategories": [
        "مستلزمات",
        "الرحلة",
        "مستلزمات",
        "الرحلة",
      ],
    },
    {
      "title": "الابل",
      "image": SvgPath.camel,
      "subCategories": [
        "الابل١",
        "الابل٢",
        "الابل٣",
      ],
    },
    {
      "title": "الخيل",
      "image": SvgPath.horse,
      "subCategories": [
        "خيل عربي",
        "خيل عربي١",
        "خيل عربي٢",
      ],
    },
    {
      "title": "نقل المواشي",
      "image": SvgPath.truck,
      "subCategories": [
        "نقل المواشي١",
        "نقل المواشي٢",
        "نقل المواشي٣",
        "نقل المواشي٤",
      ],
    },
    {
      "title": "الاعلاف",
      "image": SvgPath.planting,
      "subCategories": [
        "الاعلاف١",
        "الاعلاف٢",
        "الاعلاف٣",
        "الاعلاف٤",
      ],
    },
    {
      "title": "اليد العاملة",
      "image": SvgPath.technician,
      "subCategories": [
        "اليد العاملة١",
        "اليد العاملة٢",
        "اليد العاملة٣",
      ],
    },
  ];
  // List<Map<String, dynamic>> servicesCategoriesAndSubCategoriesItemsList = [
  //   {
  //     "title": "البيطرة",
  //     "image": SvgPath.medicine,
  //     "type":ServicesTypeEnum.medicine,
  //   },
  //   {
  //     "title": "نقل المواشي",
  //     "image": SvgPath.van,
  //     "type":ServicesTypeEnum.van,
  //   },
  //   {
  //     "title": "اليد العاملة",
  //     "image": SvgPath.technician,
  //     "type":ServicesTypeEnum.technician,
  //   },
  // ];

  int? selectedServicesCategoryIndex = 0;
  int? selectedCategoryIndex;
  int? selectedSubCategoryIndex;

  void changeCategoriesTabBarWidget(int index, {bool isCategories = true}) {
    if (isCategories) {
      if (index != selectedCategoryIndex) {
        selectedCategoryIndex = index;
        selectedSubCategoryIndex = null;
      } else {
        selectedSubCategoryIndex = null;
        selectedCategoryIndex = null;
      }
    } else {
      if (index != selectedSubCategoryIndex) {
        selectedSubCategoryIndex = index;
      } else {
        selectedSubCategoryIndex = null;
      }
    }
    emit(ChangeCategoriesTabBarWidgetState());
  }

  void changeServicesCategoriesTabBarWidget(int index,) {
    if (index != selectedServicesCategoryIndex) {
      selectedServicesCategoryIndex = index;
    } else {
      selectedServicesCategoryIndex = null;
    }
    emit(ChangeServicesCategoriesTabBarWidgetState());
  }
  void handleLogout() {
    emit(HomeInitial());
  }

  @override
  Future<void> close() {
    handleLogout();
    return super.close();
  }
}
