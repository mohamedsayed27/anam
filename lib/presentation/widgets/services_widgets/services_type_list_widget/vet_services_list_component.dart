import 'package:anam/presentation/screens/main_layout_screens/services_screens/vet_service_details_screen.dart';
import 'package:anam/presentation/widgets/services_widgets/vet_services_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../data/models/vet_models/vet_model.dart';
import '../../../../domain/controllers/services_cubit/services_cubit.dart';
import '../../shared_widget/custom_sized_box.dart';

class VetServicesList extends StatefulWidget {
  final List<VetModel> vetsList;
  final bool isFollowing;
  const VetServicesList({
    super.key,
    required this.vetsList, required this.isFollowing,
  });

  @override
  State<VetServicesList> createState() => _VetServicesListState();
}

class _VetServicesListState extends State<VetServicesList> {

  ScrollController followingScrollController = ScrollController();
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    var cubit = ServicesCubit.get(context);
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        cubit.getAllStore();
      }
    });
    followingScrollController.addListener(() {
      if (followingScrollController.position.maxScrollExtent ==
          followingScrollController.offset) {
        cubit.getUserFollowingStore();
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
      itemCount: widget.vetsList.length,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) {
              return VetServiceDetailsScreen(
                vetModel: widget.vetsList[index],
              );
            }));
          },
          child: VetServicesWidget(
            vetModel: widget.vetsList[index],
          ),
        );
      },
    );
  }
}
