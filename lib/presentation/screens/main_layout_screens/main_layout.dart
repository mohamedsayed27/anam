
import 'package:anam/presentation/widgets/main_layout_widgets/bottom_nav_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/controllers/main_layout_cubit/main_layout_cubit.dart';
import '../../../domain/controllers/main_layout_cubit/main_layout_state.dart';


class MainLayoutScreen extends StatelessWidget {
  const MainLayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainLayoutCubit, MainLayoutState>(
      builder: (context, state) {
        var cubit = MainLayoutCubit.get(context);
        return Scaffold(
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavBarWidget(
            currentIndex: cubit.currentIndex,
            onTap: cubit.changeNavBarIndex,
          ),
        );
      },
    );
  }
}
