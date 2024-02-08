import 'package:anam/data/models/laborers_models/laborer_model.dart';
import 'package:anam/domain/controllers/services_cubit/services_cubit.dart';
import 'package:anam/presentation/widgets/services_widgets/laborer_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../screens/main_layout_screens/services_screens/laborers_details_screen.dart';
import '../../shared_widget/custom_sized_box.dart';

class LaborersServicesList extends StatefulWidget {
  final List<LaborerModel> laborersList;final bool isFollowing;
  const LaborersServicesList({
    super.key,
    required this.laborersList, required this.isFollowing,
  });

  @override
  State<LaborersServicesList> createState() => _LaborersServicesListState();
}

class _LaborersServicesListState extends State<LaborersServicesList> {
  ScrollController followingScrollController = ScrollController();
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    var cubit = ServicesCubit.get(context);
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        cubit.getAllLaborer();
      }
    });
    followingScrollController.addListener(() {
      if (followingScrollController.position.maxScrollExtent ==
          followingScrollController.offset) {
        cubit.getUserFollowingLaborer();
      }
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      controller: widget.isFollowing?followingScrollController:scrollController,
      separatorBuilder: (_, index) {
        return const CustomSizedBox(
          height: 32,
        );
      },
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 12.h,
      ),
      itemCount: widget.laborersList.length,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) {
                  return LaborersServiceDetailsScreen(
                    laborerModel: widget.laborersList[index],
                  );
                },
              ),
            );
          },
          child: LaborerServicesWidget(
            laborerModel: widget.laborersList[index],
          ),
        );
      },
    );
  }
}
