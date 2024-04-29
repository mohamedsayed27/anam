import 'package:anam/data/models/stores_models/store_data_model.dart';
import 'package:anam/presentation/widgets/services_widgets/store_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../domain/controllers/services_cubit/services_cubit.dart';
import '../../../screens/main_layout_screens/services_screens/store_services_details_screen.dart';
import '../../shared_widget/custom_sized_box.dart';

class StoreServicesList extends StatefulWidget {
  final List<StoreDataModel> storeList;
  final bool isFollowing;
  const StoreServicesList({
    super.key,
    required this.storeList, required this.isFollowing,
  });

  @override
  State<StoreServicesList> createState() => _StoreServicesListState();
}

class _StoreServicesListState extends State<StoreServicesList> {

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification.metrics.maxScrollExtent ==
            notification.metrics.pixels) {
          widget.isFollowing
              ? ServicesCubit.get(context).getUserFollowingStore()
              : ServicesCubit.get(context).getAllStore();
        }
        return true;
      },
      child: ListView.separated(
        // controller: widget.isFollowing?followingScrollController:scrollController,
        separatorBuilder: (_, index) {
          return const CustomSizedBox(
            height: 32,
          );
        },
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 12.h,
        ),
        itemCount: widget.storeList.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (_){
                  return StoreServiceDetailsScreen(storeDataModel: widget.storeList[index],);
                }));
            },
            child: StoreServicesWidget(
              storeDataModel: widget.storeList[index],
            ),
          );
        },
      ),
    );
  }
}
