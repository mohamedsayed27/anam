import 'package:anam/presentation/widgets/services_widgets/services_type_list_widget/laborers_services_list_item.dart';
import 'package:anam/presentation/widgets/services_widgets/services_type_list_widget/stores_services_list_component.dart';
import 'package:anam/presentation/widgets/services_widgets/services_type_list_widget/vet_services_list_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/enums/services_type_enum.dart';
import '../../../domain/controllers/services_cubit/services_cubit.dart';
import '../../../domain/controllers/services_cubit/services_state.dart';

class ServicesAllProductsList extends StatelessWidget {
  const ServicesAllProductsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ServicesCubit, ServicesState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        ServicesCubit cubit = ServicesCubit.get(context);
        return cubit.selectedServicesValue!.type ==
                ServicesTypeEnum.veterinary.name
            ? VetServicesList(
                vetsList: cubit.vetsList, isFollowing: false,
              )
            : cubit.selectedServicesValue!.type ==
                    ServicesTypeEnum.laborers.name
                ? LaborersServicesList(
                    laborersList: cubit.laborersList,isFollowing: false,
                  )
                : StoreServicesList(
                    storeList: cubit.storesList,isFollowing: false,
                  );
      },
    );
  }
}
