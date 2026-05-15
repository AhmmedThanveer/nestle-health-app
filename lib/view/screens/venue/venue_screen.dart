import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/theme/app_textstyles.dart';
import '../../../view%20model/bloc/navigation/navigation_bloc.dart';
import '../../widgets/bottom_nav/nestle_bottom_navigation_bar.dart';
import '../../widgets/module_app_bar.dart';
import '../../widgets/nestle_logo_widget.dart';
import 'widgets/venue_location_card_widget.dart';

// The Ritz-Carlton Jeddah — Southern Corniche, Al Hamra
const _venueLat = 21.4767;
const _venueLng = 39.1460;
const _googleMapsUrl =
    'https://maps.google.com/?q=$_venueLat,$_venueLng';

class VenueScreen extends StatelessWidget {
  const VenueScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<NavigationBloc, NavigationState>(
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

              // White divider line under the logo
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                height: 1,
                color: Colors.white30,
              ),

              // ── Scrollable content ─────────────────────────────
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(bottom: 100.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Hotel photo
                      _HotelImage(),
                      SizedBox(height: 16.h),

                      // Location card
                      const VenueLocationCardWidget(),
                      SizedBox(height: 12.h),

                      // About the venue card
                      const VenueAboutCardWidget(),
                      SizedBox(height: 16.h),

                      // Map
                      _VenueMap(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Hotel image ──────────────────────────────────────────────────────────────

class _HotelImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.r),
        child: Image.network(
          'https://images.unsplash.com/photo-1551882547-ff40c63fe5fa'
          '?auto=format&fit=crop&w=1000&q=80',
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
          errorBuilder: (_, __, ___) => Container(
            height: 200.h,
            color: AppColors.glassBg,
            child: const Center(
              child: Icon(Icons.hotel_rounded, color: Colors.white54, size: 48),
            ),
          ),
        ),
      ),
    );
  }
}

// ─── OpenStreetMap via flutter_map ────────────────────────────────────────────

class _VenueMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16.r),
            child: SizedBox(
              height: 300.h,
              child: FlutterMap(
                options: const MapOptions(
                  initialCenter: LatLng(_venueLat, _venueLng),
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
                        point: const LatLng(_venueLat, _venueLng),
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

        // Open in Google Maps button
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: GestureDetector(
            onTap: () async {
              final uri = Uri.parse(_googleMapsUrl);
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
                  Icon(
                    Icons.map_outlined,
                    color: AppColors.primaryBlue,
                    size: 20.r,
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    AppStrings.openInGoogleMaps,
                    style: AppTextStyles.openMapsText,
                  ),
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
