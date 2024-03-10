import 'package:anam/bloc_observer.dart';
import 'package:anam/core/cache_helper/shared_pref_methods.dart';
import 'package:anam/translations/codegen_loader.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/app_router/app_router.dart';
import 'core/app_router/screens_name.dart';
import 'core/app_theme/app_theme.dart';
import 'core/network/dio_helper.dart';
import 'core/services/services_locator.dart';
import 'domain/controllers/auth_cubit/auth_cubit.dart';
import 'domain/controllers/chat_cubit/chat_cubit.dart';
import 'domain/controllers/home_cubit/home_cubit.dart';
import 'domain/controllers/main_layout_cubit/main_layout_cubit.dart';
import 'domain/controllers/map_cubit/map_cubit.dart';
import 'domain/controllers/products_cubit/products_cubit.dart';
import 'domain/controllers/profile_cubit/profile_cubit.dart';
import 'domain/controllers/requests_cubit/requests_cubit.dart';
import 'domain/controllers/services_cubit/services_cubit.dart';
import 'firebase_options.dart';

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
    Phoenix(
      child: EasyLocalization(
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
              create: (context) => RequestsCubit()..getAllCountries(),
            ),
            BlocProvider(
              create: (context) => ChatCubit(),
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
                ..getUserFollowingStore()
                ..getAllCategories()
                ..getAllCities(),
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
            // home: NotificationsScreen(),
          ),
        );
      },
    );
  }
}
