import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_images.dart';
import '../../../core/models/asset_models.dart';
import '../../../core/theme/app_textstyles.dart';
import '../../../view%20model/bloc/navigation/navigation_bloc.dart';
import '../../widgets/bottom_nav/nestle_bottom_navigation_bar.dart';
import '../../widgets/module_app_bar.dart';
import '../../widgets/nestle_logo_widget.dart';
import 'pdf_viewer_screen.dart';
import 'widgets/asset_file_tile_widget.dart';

/// Shows the list of files inside a single asset folder.
class AssetFolderScreen extends StatelessWidget {
  final AssetFolder folder;

  const AssetFolderScreen({super.key, required this.folder});

  @override
  Widget build(BuildContext context) {
    return BlocListener<NavigationBloc, NavigationState>(
      listenWhen: (prev, curr) => prev.currentIndex != curr.currentIndex,
      listener: (_, __) => Navigator.maybePop(context),
      child: Scaffold(
        extendBody: true,
        backgroundColor: AppColors.primaryBlue,
        bottomNavigationBar: const NestleBottomNavigationBar(),
        body: Stack(
          fit: StackFit.expand,
          children: [
            // ── Background ──────────────────────────────────────
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
                    AppColors.primaryBlue.withValues(alpha: 1.0),
                    AppColors.primaryBlue.withValues(alpha: 0.95),
                    AppColors.primaryBlue.withValues(alpha: 0.75),
                    Colors.transparent,
                  ],
                ),
              ),
            ),

            // ── Content ─────────────────────────────────────────
            SafeArea(
              bottom: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ModuleAppBar(title: folder.name),
                  SizedBox(height: 4.h),

                  NestleLogoWidget(topPadding: 0),
                  SizedBox(height: 20.h),

                  // File count label
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Text(
                      folder.fileCountLabel,
                      style: AppTextStyles.fileCountLabel,
                    ),
                  ),
                  SizedBox(height: 14.h),

                  // File list
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.fromLTRB(
                        20.w,
                        0,
                        20.w,
                        80.h + MediaQuery.of(context).padding.bottom,
                      ),
                      itemCount: folder.files.length,
                      itemBuilder: (context, index) => AssetFileTileWidget(
                        file: folder.files[index],
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                PdfViewerScreen(file: folder.files[index]),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
