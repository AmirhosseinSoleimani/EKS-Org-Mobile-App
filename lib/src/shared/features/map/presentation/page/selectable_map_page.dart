
import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/shared/extensions/string_extensions.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/domain/entity/address_info_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/presentation/cubit/map_cubit.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/presentation/cubit/map_state.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/presentation/page/widget/map_effects_listener_widget.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/presentation/page/widget/map_widget.dart';
import 'package:eks_sana_plus_org/src/shared/resources/assets_manager.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/app_bar_widget/simple_app_bar.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/buttom_sheet_widget/bottom_sheet_message.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/inkwell_button_widget/inkwell_button_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/internet/no_internet_bottom_sheet.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/snake_bar_widget/snake_bar_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/svg_widget/svg_src.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/svg_widget/svg_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_form_field_widget/text_form_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widget/animated_location_button.dart';

class SelectableMapPage extends StatelessWidget {
  static const path = '/home-service-interactive-map-page';
  static const name = 'home-service-interactive-map-name';

  final AddressInfoEntity? initialLocation;
  final ServiceType serviceType;

  const SelectableMapPage({super.key, this.initialLocation,required this.serviceType});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<MapCubit>()..setInitialLocation(initialLocation)..init(),
      child:  Scaffold(
        appBar: const SimpleAppBar(
          title: 'انتخاب آدرس',
        ),
        body: MapEffectsListenerWidget(
          child: _MapView(serviceType: serviceType),
        ),
      ),
    );
  }
}

class _MapView extends StatefulWidget {
  final ServiceType serviceType;
  const _MapView({required this.serviceType});

  @override
  State<_MapView> createState() => _MapViewState();
}

class _MapViewState extends State<_MapView> with AutomaticKeepAliveClientMixin{

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final primaryColor = widget.serviceType.serviceColor;
    return BlocConsumer<MapCubit, MapState>(
      listenWhen: (prev, curr) => curr.maybeWhen(
        permissionError: (_) => true,
        locationToAddressSuccess: () => true,
        error: (_) => true,
        connectionError: () => true,
        orElse: () => false,
      ),
      listener: (context, state) {
        state.whenOrNull(
          locationToAddressSuccess: () => _openAnimatedBottomSheet(context),
          error: (messageModel) => BottomSheetMessage.showError(
              context: context, data: messageModel),
          permissionError: (messageModel) => SnakeBarWidget.showError(
              context: context, message: messageModel.message),
          connectionError: () {
            final cubit = context.read<MapCubit>();
            BottomSheetMessage.showCustom(
                context: context,
                content: NoInternetBottomSheet(
                    onRetry: cubit.retryLastAction),
                actionWidget: const SizedBox.shrink(), isDismissible: false,enableDrag: false);
          },
        );
      },
      buildWhen: (prev, curr) => curr.maybeWhen(
        permissionSuccess: () => false,
        permissionError: (_) => false,
        error: (_) => false,
        orElse: () => true,
      ),
      builder: (context, state) {
        return state.maybeWhen(
          orElse: () => Stack(
            children: [
               _MapCanvas(serviceType: widget.serviceType),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16, vertical: AppPadding.p36),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: _LocationActionButton(color: primaryColor,),
                ),
              )
            ],
          ),
        );
      },
    );
  }
  void _openAnimatedBottomSheet(BuildContext context) {
    final cubit = context.read<MapCubit>();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return BlocProvider.value(
          value: cubit,
          child: AnimatedPadding(
            duration: 200.ms,
            curve: Curves.easeOut,
            padding: EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom),
            child: SizedBox(
              width: double.infinity,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Theme.of(ctx).colorScheme.surface,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(AppSize.s12)),
                ),
                child: SafeArea(
                  top: false,
                  child: Padding(
                    padding: const EdgeInsets.only(right: AppPadding.p12, left: AppPadding.p12, bottom: AppPadding.p36, top: AppPadding.p8),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: AppSize.s60,
                          height: AppSize.s4,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.onInverseSurface,
                              borderRadius: BorderRadius.circular(AppSize.s24),
                            ),
                          ),
                        ),
                        Space.h16,
                        'تایید آدرس'.headlineMedium(context,
                            fontSize: AppSize.s16, fontWeight: FontWeight.w600),
                        Space.h16,
                        TextFormFieldWidget(
                          controller: cubit.addressController,
                          labelText: 'جزئیات آدرس',
                          labelStyle: Theme.of(context).textTheme.displayMedium?.copyWith(fontSize: AppSize.s16),
                          textInputAction: TextInputAction.done,
                          maxLines: 4,
                        ),
                        Space.h16,
                        InkwellButtonWidget(
                          onTap: () {
                            cubit.confirmSelectedAddress();
                            Navigator.pop(context);
                            Navigator.pop(
                              context,
                              AddressInfoEntity(
                                latitude: cubit.location.latitude,
                                longitude: cubit.location.longitude,
                                address: cubit.addressController.text,
                              ),
                            );
                          },
                          backgroundColor: Theme.of(context).colorScheme.secondary,
                          title: 'تایید آدرس',
                        ),
                      ],
                    )
                        .animate()
                        .fadeIn(duration: 300.ms, curve: Curves.easeOut)
                        .slideY(begin: 0.2, end: 0, duration: 300.ms, curve: Curves.easeOut)
                        .scale(begin: const Offset(0.98, 0.98), end: const Offset(1, 1), duration: 300.ms),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _LocationActionButton extends StatelessWidget {
  const _LocationActionButton({this.color});
  final Color? color;
  @override
  Widget build(BuildContext context) {
    final loading = context.select<MapCubit, bool>(
          (c) => c.state.maybeWhen(locationToAddressLoading: () => true, orElse: () => false),
    );
    return InkwellButtonWidget(
      showLoading: loading,
      onTap: loading ? () {} : () => context.read<MapCubit>().fetchLocationToAddress(),
      title: 'ثبت موقعیت مکانی',
      borderColor: color ?? Theme.of(context).colorScheme.primary,
      backgroundColor: color ?? Theme.of(context).colorScheme.primary,
    );
  }
}

class _MapCanvas extends StatelessWidget {
  final ServiceType serviceType;
  const _MapCanvas({required this.serviceType});
  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                const MapWidget(key: ValueKey('static_map_widget')),
                Align(
                  alignment: AlignmentDirectional.bottomStart,
                  child: Padding(
                    padding: const EdgeInsetsDirectional.only(
                      start: AppPadding.p16,
                      bottom: 100,
                    ),
                    child: AnimatedLocationButton(
                      loadingColor: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ),
                const Align(
                  alignment: AlignmentDirectional.topCenter,
                  child: Padding(
                    padding: EdgeInsetsDirectional.only(
                      start: AppPadding.p16,
                      end: AppPadding.p16,
                      top: AppPadding.p16,
                    ),
                    child: MapSearchField(),
                  ),
                ),
                 _CenterMarker(serviceType: serviceType),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CenterMarker extends StatelessWidget {
  final ServiceType serviceType;
  const _CenterMarker({required this.serviceType});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: EdgeInsets.only(bottom: 30),
      child: Align(
        alignment: Alignment.center,
        child: IgnorePointer(
          child: SvgWidget(
            src: SvgAsset(serviceType == ServiceType.homeService ? SvgManager.homeServiceLocation: SvgManager.location),
            width: AppSize.s60,
            height: AppSize.s60,
          ),
        ),
      ),
    );
  }
}
