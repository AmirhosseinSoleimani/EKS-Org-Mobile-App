import 'dart:async';

import 'package:eks_sana_plus_org/src/common/constants/app_constants.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/presentation/cubit/map_cubit.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/presentation/cubit/map_state.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_message.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_message_model.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/snake_bar_widget/snake_bar_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

class MapEffectsListenerWidget extends StatefulWidget {
  const MapEffectsListenerWidget({super.key, required this.child});
  final Widget child;

  @override
  State<MapEffectsListenerWidget> createState() => _MapEffectsListenerWidgetState();
}

class _MapEffectsListenerWidgetState extends State<MapEffectsListenerWidget> {
  StreamSubscription<MapSideEffect>? _sub;

  @override
  void initState() {
    super.initState();
    final cubit = context.read<MapCubit>();
    _sub = cubit.effects.listen((e) async{
      if (!mounted) return;
      switch (e) {
        case AskOpenSettings():
          await _showOpenSettingsBottomSheet();
          break;
        case AskEnableService():
          await _showGpsEnableSheet();
          break;
        case NavigateToAddressInfo():
          if (!mounted) return;
          // Navigator.of(context).pushReplacement(
          //   MaterialPageRoute(builder: (_) => const InsertHomeServiceAddressInfoPage()),
          // );
          break;
        case ShowInfo(:final message):
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
          break;
        case ShowError(:final message):
          if (!mounted) return;
          BottomSheetMessage.showError(
              context: context,
              data: BottomSheetMessageModel(title: '', message: message));
          break;
      }
    });
  }

  Future<BottomSheetAction?> _showOpenSettingsBottomSheet() {
    return BottomSheetMessage.showNoticeWithAction(
      context: context,
      data: const BottomSheetMessageModel(
          title: 'نیاز به دسترسی موقعیت',
          message:
              'برای ادامه، از تنظیمات سیستم دسترسی موقعیت مکانی را فعال کنید.'),
      positiveText: 'رفتن به تنظیمات',
      onPositive: () async {
        await _openAppSettings();
        if (mounted) {
          context.read<MapCubit>().ensureAndCenterOnUser();
        }
      },
    );
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }

  Future<void> _openAppSettings() async {
    if (kIsWeb) {
      await _requestLocationPermissionOnWeb();
      return;
    }

    final ok = await openAppSettings();
    if (!ok && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('باز کردن تنظیمات امکان‌پذیر نبود')),
      );
    }
  }

  Future<void> _requestLocationPermissionOnWeb() async {
    try {
      final status = await Permission.location.request();

      if (!mounted) return;

      if (status.isGranted) {
        SnakeBarWidget.showSuccess(
            context: context, message: 'مجوز موقعیت مکانی داده شد');
      } else {
        SnakeBarWidget.showError(context: context, message: 'دسترسی داده نشد');
      }
    } catch (e) {
      debugPrint("Web location error: $e");
    }
  }

  Future<void> _showGpsEnableSheet() async {
    return showModalBottomSheet<void>(
      context: context,
      useSafeArea: true,
      isScrollControlled: true,
      builder: (ctx) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.location_searching, size: 32),
              const SizedBox(height: 12),
              const Text(
                'GPS خاموش است',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
              const SizedBox(height: 8),
              const Text(
                'برای یافتن موقعیت دقیق، GPS را روشن کنید. سپس مجدداً تلاش کنید.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () async {
                        Navigator.of(ctx).pop();
                        await _openAppSettings();
                      },
                      child: const Text('رفتن به تنظیمات'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(ctx).pop();
                        context.read<MapCubit>()
                            .ensureAndCenterOnUser();
                      },
                      child: const Text('تلاش مجدد'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) => widget.child;
}
