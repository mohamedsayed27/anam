import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../shared_widget/search_bar_widget.dart';

class IntroSearchContainer extends StatelessWidget {
  const IntroSearchContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.all(16.r),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.10),
              blurRadius: 8.r,
              offset: Offset(0, 1.h),
            )
          ]
      ),
      child: const SearchBarWidget(),
    );
  }
}
