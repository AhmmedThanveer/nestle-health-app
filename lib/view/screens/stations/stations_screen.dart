import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_images.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/theme/app_textstyles.dart';
import '../../../domain/entities/station_entity.dart';
import '../../../view%20model/bloc/auth/auth_bloc.dart';
import '../../../view%20model/bloc/auth/auth_state.dart';
import '../../../view%20model/bloc/navigation/navigation_bloc.dart';
import '../../../view%20model/bloc/profile/profile_bloc.dart';
import '../../../view%20model/cubit/stations/stations_cubit.dart';
import '../../widgets/bottom_nav/nestle_bottom_navigation_bar.dart';
import '../../widgets/module_app_bar.dart';
import '../../widgets/nestle_logo_widget.dart';
import 'widgets/qr_scanner_sheet_widget.dart';
import 'widgets/station_list_tile_widget.dart';

class StationsScreen extends StatelessWidget {
  const StationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authState = context.read<AuthBloc>().state;
    final userId =
        authState is AuthAuthenticatedState ? authState.user.uid : '';

    return BlocProvider(
      create: (_) => StationsCubit()..loadStations(userId),
      child: _StationsView(userId: userId),
    );
  }
}

// â”€â”€â”€ View â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€

class _StationsView extends StatelessWidget {
  final String userId;

  const _StationsView({required this.userId});

  void _openScanner(BuildContext context, StationEntity station) {
    final cubit = context.read<StationsCubit>();
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetCtx) => BlocProvider.value(
        value: cubit,
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.75,
          child: QrScannerSheetWidget(station: station, userId: userId),
        ),
      ),
    );
  }

  void _showScanFailedDialog(BuildContext context, StationsCubit cubit) {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (dialogCtx) => _ScanFailedDialog(
        onDone: () {
          Navigator.pop(dialogCtx);
          cubit.dismissScanResult();
        },
      ),
    );
  }

  void _showAlreadyScannedDialog(BuildContext context, StationsCubit cubit) {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (dialogCtx) => _AlreadyScannedDialog(
        onDone: () {
          Navigator.pop(dialogCtx);
          cubit.dismissScanResult();
        },
      ),
    );
  }

  void _showScanSuccessDialog(
    BuildContext context,
    StationsCubit cubit,
    StationEntity station,
    int sessionPoints,
  ) {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (dialogCtx) => _ScanSuccessDialog(
        station: station,
        sessionPoints: sessionPoints,
        onDone: () {
          Navigator.pop(dialogCtx);
          cubit.dismissScanResult();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<NavigationBloc, NavigationState>(
      listenWhen: (prev, curr) => prev.currentIndex != curr.currentIndex,
      listener: (_, __) => Navigator.maybePop(context),
      child: BlocListener<StationsCubit, StationsState>(
        listenWhen: (prev, curr) =>
            curr.scanResult != ScanResult.none &&
            curr.scanResult != prev.scanResult,
        listener: (context, state) {
          final cubit = context.read<StationsCubit>();
          switch (state.scanResult) {
            case ScanResult.success:
              context
                  .read<ProfileBloc>()
                  .add(LoadProfileEvent(userId));
              _showScanSuccessDialog(
                context,
                cubit,
                state.lastScannedStation!,
                state.sessionPoints,
              );
            case ScanResult.failure:
              _showScanFailedDialog(context, cubit);
            case ScanResult.alreadyScanned:
              _showAlreadyScannedDialog(context, cubit);
            case ScanResult.none:
              break;
          }
        },
        child: Scaffold(
          extendBody: true,
          backgroundColor: AppColors.primaryBlue,
          bottomNavigationBar: const NestleBottomNavigationBar(),
          body: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                AppImages.loginBg,
                fit: BoxFit.cover,
                alignment: Alignment.bottomCenter,
                filterQuality: FilterQuality.low,
              ),
              DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: const [0.0, 0.35, 0.62, 1.0],
                    colors: [
                      AppColors.primaryBlue.withValues(alpha: 0.92),
                      AppColors.primaryBlue.withValues(alpha: 0.85),
                      AppColors.primaryBlue.withValues(alpha: 0.78),
                      AppColors.primaryBlue.withValues(alpha: 0.95),
                    ],
                  ),
                ),
              ),

              SafeArea(
                bottom: false,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ModuleAppBar(title: AppStrings.stationsTitle),
                    SizedBox(height: 4.h),
                    NestleLogoWidget(topPadding: 0),
                    SizedBox(height: 8.h),

                    Expanded(
                      child: BlocBuilder<StationsCubit, StationsState>(
                        builder: (context, state) {
                          if (state.status == StationsStatus.loading ||
                              state.status == StationsStatus.initial) {
                            return const Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            );
                          }

                          if (state.status == StationsStatus.error) {
                            return Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.wifi_off_rounded,
                                      color: Colors.white54, size: 48.r),
                                  SizedBox(height: 12.h),
                                  Text(
                                    state.errorMessage ?? 'Failed to load stations.',
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 14.sp,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: 16.h),
                                  TextButton(
                                    onPressed: () => context
                                        .read<StationsCubit>()
                                        .loadStations(userId),
                                    child: Text(
                                      'Retry',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14.sp,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }

                          return Stack(
                            children: [
                              RepaintBoundary(
                                child: ListView.builder(
                                  padding: EdgeInsets.only(
                                    top: 4.h,
                                    bottom: 100.h,
                                  ),
                                  itemCount: state.stations.length,
                                  itemBuilder: (_, i) {
                                    final station = state.stations[i];
                                    return StationListTileWidget(
                                      station: station,
                                      index: i,
                                      isScanned: state.isScanned(station.id),
                                      onScan: () =>
                                          _openScanner(context, station),
                                    );
                                  },
                                ),
                              ),
                              if (state.status == StationsStatus.scanning)
                                AbsorbPointer(
                                  child: Container(
                                    color: Colors.black38,
                                    child: const Center(
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// â”€â”€â”€ Scan Success dialog â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€

class _ScanSuccessDialog extends StatelessWidget {
  final StationEntity station;
  final int sessionPoints;
  final VoidCallback onDone;

  const _ScanSuccessDialog({
    required this.station,
    required this.sessionPoints,
    required this.onDone,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(24.w, 32.h, 24.w, 24.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 72.r,
              height: 72.r,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.stationScannedGreen,
              ),
              child: Icon(
                Icons.check_rounded,
                color: Colors.white,
                size: 40.r,
              ),
            ),
            SizedBox(height: 20.h),

            Text(
              'Points Earned!',
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 20.sp,
                fontWeight: FontWeight.w800,
                color: AppColors.darkNavy,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8.h),

            Text(
              station.name,
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.greyText,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.h),

            Container(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
              decoration: BoxDecoration(
                color: AppColors.primaryBlue.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.star_rounded,
                      color: AppColors.pointsGold, size: 28.r),
                  SizedBox(width: 8.w),
                  Text(
                    '+${station.points} pts',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w800,
                      color: AppColors.primaryBlue,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 12.h),

            Text(
              'Total this session: $sessionPoints pts',
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 13.sp,
                color: AppColors.greyMid,
              ),
            ),
            SizedBox(height: 28.h),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onDone,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.stationScannedGreen,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  elevation: 0,
                ),
                child: Text(
                  AppStrings.done,
                  style: AppTextStyles.scanFailedButton,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// â”€â”€â”€ Already scanned dialog â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€

class _AlreadyScannedDialog extends StatelessWidget {
  final VoidCallback onDone;

  const _AlreadyScannedDialog({required this.onDone});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(24.w, 32.h, 24.w, 24.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 72.r,
              height: 72.r,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.warningOrange,
              ),
              child: Icon(
                Icons.info_outline_rounded,
                color: Colors.white,
                size: 38.r,
              ),
            ),
            SizedBox(height: 20.h),

            Text(
              'Already Scanned',
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 20.sp,
                fontWeight: FontWeight.w800,
                color: AppColors.darkNavy,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10.h),

            Text(
              'You have already earned points\nfor this station.',
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 14.sp,
                color: AppColors.greyText,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 28.h),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onDone,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryBlue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  elevation: 0,
                ),
                child: Text(
                  AppStrings.done,
                  style: AppTextStyles.scanFailedButton,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// â”€â”€â”€ Scan Failed dialog â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€

class _ScanFailedDialog extends StatelessWidget {
  final VoidCallback onDone;

  const _ScanFailedDialog({required this.onDone});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(24.w, 32.h, 24.w, 24.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 72.r,
              height: 72.r,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.scanFailedRed,
              ),
              child: Center(
                child: Text(
                  '!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 36.sp,
                    fontWeight: FontWeight.w900,
                    fontFamily: 'Montserrat',
                    height: 1.0,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.h),

            Text(
              AppStrings.scanFailed,
              style: AppTextStyles.scanFailedTitle,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10.h),

            Text(
              AppStrings.qrCodeNoMatch,
              style: AppTextStyles.scanFailedSubtitle,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 28.h),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onDone,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryBlue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  elevation: 0,
                ),
                child: Text(
                  AppStrings.done,
                  style: AppTextStyles.scanFailedButton,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

