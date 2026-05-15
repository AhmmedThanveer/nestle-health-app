import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:health_congress/app/global_scroll_behavior.dart';
import 'package:health_congress/app/routes/app_routes.dart';
import 'package:health_congress/view%20model/bloc/auth/auth_bloc.dart';
import 'package:health_congress/view%20model/bloc/auth/auth_event.dart';
import 'package:health_congress/view%20model/bloc/login_bloc.dart';
import 'package:health_congress/view%20model/bloc/navigation/navigation_bloc.dart';
import 'package:health_congress/view%20model/bloc/notification/notification_bloc.dart';
import 'package:health_congress/view%20model/bloc/profile/profile_bloc.dart';
import 'package:health_congress/view%20model/bloc/register/register_bloc.dart';
import 'package:health_congress/view%20model/bloc/event%20code/event_code_bloc.dart';

import '../core/theme/app_theme.dart';
import '../services/analytics_service.dart';
import '../app/di/service_locator.dart';

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
            BlocProvider(
              create: (_) => AuthBloc()..add(AppStartedEvent()),
            ),
            BlocProvider(create: (_) => LoginBloc()),
            BlocProvider(create: (_) => RegisterBloc()),
            BlocProvider(create: (_) => EventCodeBloc()),
            BlocProvider(create: (_) => NavigationBloc()),
            BlocProvider(create: (_) => ProfileBloc()),
            BlocProvider(create: (_) => NotificationBloc()),
          ],
          child: MaterialApp(
            navigatorKey: globalNavigatorKey,
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            initialRoute: AppRoutes.splash,
            onGenerateRoute: AppRoutes.onGenerateRoute,
            navigatorObservers: [
              sl<AnalyticsService>().observer,
            ],
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
