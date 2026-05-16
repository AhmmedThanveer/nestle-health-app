import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/theme/app_textstyles.dart';
import '../../../domain/entities/venue_entity.dart';
import '../../../view%20model/bloc/navigation/navigation_bloc.dart';
import '../../../view%20model/cubit/venue/venue_cubit.dart';
import '../../widgets/animated_entrance_item.dart';
import '../../widgets/bottom_nav/nestle_bottom_navigation_bar.dart';
import '../../widgets/module_app_bar.dart';
import '../../widgets/nestle_logo_widget.dart';
import '../../widgets/screen_state_widget.dart';
import 'widgets/venue_location_card_widget.dart';

class VenueScreen extends StatelessWidget {
  const VenueScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => VenueCubit()..load(),
      child: BlocListener<NavigationBloc, NavigationState>(
        listenWhen: (prev, curr) => prev.currentIndex != curr.currentIndex,
        listener: (_, __) => Navigator.maybePop(context),
        child: Scaffold(
          extendBody: true,
          backgroundColor: AppColors.primaryBlue,
          bottomNavigationBar: const NestleBottomNavigationBar(),
          body: SafeArea(
            bottom: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ModuleAppBar(title: AppStrings.venueTitle),
                SizedBox(height: 4.h),
                NestleLogoWidget(topPadding: 0),
                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: 20.w, vertical: 16.h),
                  height: 1,
                  color: Colors.white30,
                ),
                Expanded(
                  child: BlocBuilder<VenueCubit, VenueState>(
                    builder: (context, state) {
                      if (state.status == VenueStatus.loading ||
                          state.status == VenueStatus.initial) {
                        return const Center(
                          child: CircularProgressIndicator(
                              color: Colors.white),
                        );
                      }
                      if (state.status == VenueStatus.error) {
                        return ScreenStateWidget.serverError(
                          message: state.errorMessage ?? 'Failed to load venue.',
                          onRetry: () => context.read<VenueCubit>().load(),
                        );
                      }
                      return _VenueContent(venue: state.venue!);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Loaded content ───────────────────────────────────────────────────────────

class _VenueContent extends StatelessWidget {
  final VenueEntity venue;
  const _VenueContent({required this.venue});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(bottom: 100.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AnimatedEntranceItem(
            direction: EntranceDirection.ttb,
            index: 0,
            child: _HotelImage(imageUrl: venue.imageUrl),
          ),
          SizedBox(height: 16.h),
          AnimatedEntranceItem(
            direction: EntranceDirection.ttb,
            index: 1,
            child: VenueLocationCardWidget(
              name: venue.name,
              address: venue.address,
              city: venue.city,
            ),
          ),
          SizedBox(height: 12.h),
          AnimatedEntranceItem(
            direction: EntranceDirection.ttb,
            index: 2,
            child: VenueAboutCardWidget(auditorium: venue.auditorium),
          ),
          SizedBox(height: 16.h),
          AnimatedEntranceItem(
            direction: EntranceDirection.ttb,
            index: 3,
            child: _VenueMap(
              latitude: venue.latitude,
              longitude: venue.longitude,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Hotel image ──────────────────────────────────────────────────────────────

class _HotelImage extends StatelessWidget {
  final String imageUrl;
  const _HotelImage({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.r),
        child: imageUrl.isNotEmpty
            ? Image.network(
                imageUrl,
                height: 200.h,
                fit: BoxFit.cover,
                loadingBuilder: (_, child, progress) {
                  if (progress == null) return child;
                  return Container(
                    height: 200.h,
                    color: AppColors.glassBg,
                    child: const Center(
                      child: CircularProgressIndicator(color: Colors.white),
                    ),
                  );
                },
                errorBuilder: (_, __, ___) => _imagePlaceholder(),
              )
            : _imagePlaceholder(),
      ),
    );
  }

  Widget _imagePlaceholder() => Container(
        height: 200,
        color: AppColors.glassBg,
        child: const Center(
          child: Icon(Icons.hotel_rounded, color: Colors.white54, size: 48),
        ),
      );
}

// ─── OpenStreetMap via flutter_map ────────────────────────────────────────────

class _VenueMap extends StatelessWidget {
  final double latitude;
  final double longitude;

  const _VenueMap({required this.latitude, required this.longitude});

  @override
  Widget build(BuildContext context) {
    final point = LatLng(latitude, longitude);
    final mapsUrl = 'https://maps.google.com/?q=$latitude,$longitude';

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16.r),
            child: SizedBox(
              height: 300.h,
              child: FlutterMap(
                options: MapOptions(
                  initialCenter: point,
                  initialZoom: 16,
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName:
                        'com.nestlecongress.health_congress',
                  ),
                  MarkerLayer(
                    markers: [
                      Marker(
                        point: point,
                        child: Icon(
                          Icons.location_on,
                          color: AppColors.primaryBlue,
                          size: 40.r,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 12.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: GestureDetector(
            onTap: () async {
              final uri = Uri.parse(mapsUrl);
              if (await canLaunchUrl(uri)) {
                await launchUrl(uri, mode: LaunchMode.externalApplication);
              }
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 14.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.map_outlined,
                      color: AppColors.primaryBlue, size: 20.r),
                  SizedBox(width: 8.w),
                  Text(AppStrings.openInGoogleMaps,
                      style: AppTextStyles.openMapsText),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 16.h),
      ],
    );
  }
}
