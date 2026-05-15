import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/theme/app_textstyles.dart';
import '../../../../domain/entities/station_entity.dart';
import '../../../../view%20model/cubit/stations/stations_cubit.dart';

/// Bottom sheet that opens the device camera and scans for the station's QR.
class QrScannerSheetWidget extends StatefulWidget {
  final StationEntity station;
  final String userId;

  const QrScannerSheetWidget({
    super.key,
    required this.station,
    required this.userId,
  });

  @override
  State<QrScannerSheetWidget> createState() => _QrScannerSheetWidgetState();
}

class _QrScannerSheetWidgetState extends State<QrScannerSheetWidget> {
  final MobileScannerController _controller = MobileScannerController();
  bool _scanned = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onDetect(BarcodeCapture capture) {
    if (_scanned) return;
    final code = capture.barcodes.firstOrNull?.rawValue;
    if (code == null) return;
    _scanned = true;
    _controller.stop();

    final cubit = context.read<StationsCubit>();
    final stationId = widget.station.id;
    final userId = widget.userId;

    Navigator.pop(context);

    Future.delayed(const Duration(milliseconds: 300), () {
      cubit.processScan(
        userId: userId,
        stationId: stationId,
        scannedCode: code,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.scannerSheetBg,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: Column(
        children: [
          Center(
            child: Container(
              width: 40.w,
              height: 4.h,
              margin: EdgeInsets.only(top: 10.h, bottom: 20.h),
              decoration: BoxDecoration(
                color: Colors.white30,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
          ),

          Text(AppStrings.scanQrCode, style: AppTextStyles.scanQrTitle),
          SizedBox(height: 6.h),

          Text(widget.station.name, style: AppTextStyles.scanQrStation),
          SizedBox(height: 20.h),

          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: MobileScanner(
                controller: _controller,
                onDetect: _onDetect,
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
            child: Text(
              AppStrings.pointCameraAtQr,
              textAlign: TextAlign.center,
              style: AppTextStyles.scanQrInstruction,
            ),
          ),
        ],
      ),
    );
  }
}
