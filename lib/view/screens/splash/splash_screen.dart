import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/routes/app_routes.dart';
import '../../../core/constants/app_colors.dart';
import '../../../view%20model/bloc/auth/auth_bloc.dart';
import '../../../view%20model/bloc/auth/auth_state.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthAuthenticatedState) {
          AppRoutes.pushAndRemoveUntil(context, AppRoutes.main);
        } else if (state is AuthUnauthenticatedState) {
          AppRoutes.pushAndRemoveUntil(context, AppRoutes.login);
        }
      },
      child: const Scaffold(
        backgroundColor: AppColors.primaryBlue,
        body: Center(
          child: CircularProgressIndicator(color: Colors.white),
        ),
      ),
    );
  }
}
