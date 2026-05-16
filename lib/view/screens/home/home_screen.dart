import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_images.dart';
import '../../../view%20model/bloc/home/home_bloc.dart';
import '../../widgets/nestle_logo_widget.dart';
import 'widgets/home_background.dart';
import 'widgets/home_bell_button.dart';
import 'widgets/home_gradient_overlay.dart';
import 'widgets/home_loading_placeholder.dart';
import 'widgets/module_grid_container.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (_) => HomeBloc(), child: const _HomeView());
  }
}

class _HomeView extends StatefulWidget {
  const _HomeView();

  @override
  State<_HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<_HomeView> with TickerProviderStateMixin {
  late final AnimationController _headerCtrl;
  late final Animation<double> _headerOpacity;
  late final Animation<Offset> _headerSlide;

  @override
  void initState() {
    super.initState();
    _headerCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _headerOpacity = CurvedAnimation(
      parent: _headerCtrl,
      curve: Curves.easeOut,
    );
    _headerSlide = Tween<Offset>(
      begin: const Offset(0, -0.08),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _headerCtrl, curve: Curves.easeOutCubic));

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!mounted) return;
      await precacheImage(const AssetImage(AppImages.loginBg), context);
      if (!mounted) return;
      _headerCtrl.forward();
      context.read<HomeBloc>().add(const HomeLoadEvent());
    });
  }

  @override
  void dispose() {
    _headerCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF003087),
      body: Stack(
        fit: StackFit.expand,
        children: [
          const HomeBackground(),
          const HomeGradientOverlay(),
          SafeArea(
            bottom: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                FadeTransition(
                  opacity: _headerOpacity,
                  child: SlideTransition(
                    position: _headerSlide,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20.w,
                            vertical: 4.h,
                          ),
                          child: const Align(
                            alignment: Alignment.centerRight,
                            child: HomeBellButton(),
                          ),
                        ),
                        const NestleLogoWidget(),
                        SizedBox(height: 18.h),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 14.w),
                    child: BlocBuilder<HomeBloc, HomeState>(
                      builder: (context, state) {
                        if (state.isLoaded) {
                          return RepaintBoundary(
                            child: ModuleGridContainer(
                              onModuleTap: (route) =>
                                  Navigator.pushNamed(context, route),
                            ),
                          );
                        }
                        return const HomeLoadingPlaceholder();
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
