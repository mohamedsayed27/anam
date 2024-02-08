import 'package:anam/bloc_observer.dart';
import 'package:anam/core/app_theme/app_theme.dart';
import 'package:anam/core/cache_helper/shared_pref_methods.dart';
import 'package:anam/core/services/services_locator.dart';
import 'package:anam/data/datasources/map_remote_data_source.dart';
import 'package:anam/domain/controllers/auth_cubit/auth_cubit.dart';
import 'package:anam/presentation/screens/main_layout_screens/services_screens/add_laborer_screen.dart';
import 'package:anam/presentation/screens/main_layout_screens/services_screens/add_store_screen.dart';
import 'package:anam/presentation/screens/main_layout_screens/services_screens/add_vet_store_screen.dart';
import 'package:anam/presentation/screens/main_layout_screens/services_screens/laborers_details_screen.dart';
import 'package:anam/presentation/screens/main_layout_screens/services_screens/store_services_details_screen.dart';
import 'package:anam/presentation/screens/main_layout_screens/services_screens/vet_service_details_screen.dart';
import 'package:anam/translations/codegen_loader.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/app_router/app_router.dart';
import 'core/app_router/screens_name.dart';
import 'core/network/dio_helper.dart';
import 'domain/controllers/home_cubit/home_cubit.dart';
import 'domain/controllers/main_layout_cubit/main_layout_cubit.dart';
import 'domain/controllers/map_cubit/map_cubit.dart';
import 'domain/controllers/products_cubit/products_cubit.dart';
import 'domain/controllers/profile_cubit/profile_cubit.dart';
import 'domain/controllers/requests_cubit/requests_cubit.dart';
import 'domain/controllers/services_cubit/services_cubit.dart';
import 'firebase_options.dart';
import 'presentation/screens/main_layout_screens/profile_screens/products_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await EasyLocalization.ensureInitialized();
  await DioHelper.init();
  await CacheHelper.init();
  ServicesLocator().init();
  Bloc.observer = MyBlocObserver();
  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale(
          'en',
        ),
        Locale(
          'ar',
        ),
      ],
      startLocale: const Locale("ar"),
      path: 'assets/translations',
      assetLoader: const CodegenLoader(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      builder: (_, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => MainLayoutCubit(),
            ),
            BlocProvider(
              create: (context) => HomeCubit(),
            ),
            BlocProvider(
              create: (context) => RequestsCubit(),
            ),
            BlocProvider(
              create: (context) => AuthCubit()..getAllCountries(),
            ),
            BlocProvider(
              create: (context) => ProfileCubit(),
            ),
            BlocProvider(
                create: (context) => ProductsCubit()
                  ..getAllProducts()
                  ..getUserFollowingProducts()
                  ..getAllCategories()),
            BlocProvider(
              create: (context) => MapCubit(),
            ),
            BlocProvider(
              create: (context) => ServicesCubit()
                ..getAllServices()
                ..getAllVet()
                ..getUserFollowingVet()
                ..getAllLaborer()
                ..getUserFollowingLaborer()
                ..getAllStore()
                ..getUserFollowingStore()..getAllCategories()..getAllCities(),
            ),
          ],
          child: MaterialApp(
            title: 'Anaam',
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            // O
            theme: AppTheme.lightTheme,
            onGenerateRoute: AppRouter.generateRoute,
            initialRoute: ScreenName.splashScreen,
            // home: AddVetScreen(),
          ),
        );
      },
    );
  }
}
