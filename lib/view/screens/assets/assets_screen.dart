import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_images.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/models/asset_models.dart';
import '../../../view%20model/bloc/assets/assets_bloc.dart';
import '../../../view%20model/bloc/assets/assets_event.dart';
import '../../../view%20model/bloc/assets/assets_state.dart';
import '../../../view%20model/bloc/navigation/navigation_bloc.dart';
import '../../widgets/animated_entrance_item.dart';
import '../../widgets/bottom_nav/nestle_bottom_navigation_bar.dart';
import '../../widgets/module_app_bar.dart';
import '../../widgets/nestle_logo_widget.dart';
import 'asset_folder_screen.dart';
import 'widgets/asset_folder_card_widget.dart';

class AssetsScreen extends StatelessWidget {
  const AssetsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AssetsBloc()..add(const LoadAssetsEvent()),
      child: const _AssetsView(),
    );
  }
}

// ─── View ─────────────────────────────────────────────────────────────────────

class _AssetsView extends StatelessWidget {
  const _AssetsView();

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
                  ModuleAppBar(title: AppStrings.assetsScreenTitle),
                  SizedBox(height: 4.h),

                  NestleLogoWidget(topPadding: 0),
                  SizedBox(height: 20.h),

                  Expanded(
                    child: BlocBuilder<AssetsBloc, AssetsState>(
                      builder: (context, state) {
                        if (state is! AssetsLoadedState) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          );
                        }
                        return _FolderGrid(folders: state.folders);
                      },
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

// ─── 2-column folder grid ─────────────────────────────────────────────────────

class _FolderGrid extends StatelessWidget {
  final List<AssetFolder> folders;

  const _FolderGrid({required this.folders});

  @override
  Widget build(BuildContext context) {
    final double bottomPad = 80.h + MediaQuery.of(context).padding.bottom;

    return GridView.builder(
      padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, bottomPad),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 14.w,
        mainAxisSpacing: 14.h,
        childAspectRatio: 0.85,
      ),
      itemCount: folders.length,
      itemBuilder: (context, index) => AnimatedEntranceItem(
        direction: EntranceDirection.rtl,
        index: index,
        child: AssetFolderCardWidget(
          folder: folders[index],
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => AssetFolderScreen(folder: folders[index]),
            ),
          ),
        ),
      ),
    );
  }
}
