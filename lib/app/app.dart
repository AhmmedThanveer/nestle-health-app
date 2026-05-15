import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_congress/app/global_scroll_behavior.dart';
import 'package:health_congress/app/routes/app_routes.dart';
import 'package:health_congress/view%20model/bloc/login_bloc.dart';
import 'package:health_congress/view%20model/bloc/navigation/navigation_bloc.dart';

import '../core/theme/app_theme.dart';

final GlobalKey<NavigatorState> globalNavigatorKey =
    GlobalKey<NavigatorState>();

class NestleHealthApp extends StatelessWidget {
  const NestleHealthApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      enableScaleWH: () => true,
      enableScaleText: () => true,
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            /// Auth BLoC – manages login / password visibility
            BlocProvider(create: (_) => LoginBloc()),

            /// Navigation BLoC – drives the main bottom tab bar
            BlocProvider(create: (_) => NavigationBloc()),
          ],
          child: MaterialApp(
            navigatorKey: globalNavigatorKey,
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            initialRoute: AppRoutes.main,
            onGenerateRoute: AppRoutes.onGenerateRoute,
            builder: (context, widget) {
              return ScrollConfiguration(
                behavior: GlobalScrollBehavior(),
                child: widget!,
              );
            },
          ),
        );
      },
    );
  }
}
