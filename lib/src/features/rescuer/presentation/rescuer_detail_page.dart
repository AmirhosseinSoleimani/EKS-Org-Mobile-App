import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/domain/entities/rescuer_entity.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/presentation/cubit/detail/rescuer_detail_cubit.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/presentation/widgets/detail/rescuer_detail_section_card.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/presentation/widgets/rescuer_avatar.dart';
import 'package:eks_sana_plus_org/src/features/rescuer/presentation/widgets/rescuer_full_screen_sheet_app_bar.dart';
import 'package:eks_sana_plus_org/src/shared/extensions/string_extensions.dart';
import 'package:eks_sana_plus_org/src/shared/resources/assets_manager.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/bottom_sheet_widget/bottom_sheet_message.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/button_widgets/inkwell_button_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/internet/no_internet_bottom_sheet.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/loading_widget/loading_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/snake_bar_widget/snake_bar_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class RescuerDetailPage extends StatelessWidget {
  static const path = '/rescuer-details';
  static const name = 'rescuer-details';

  final int rescuerId;

  const RescuerDetailPage({super.key, required this.rescuerId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<RescuerDetailCubit>()..loadDetails(rescuerId),
      child: const _RescuerDetailView(),
    );
  }
}

class _RescuerDetailView extends StatelessWidget {
  const _RescuerDetailView();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<RescuerDetailCubit>();

    return BlocListener<RescuerDetailCubit, RescuerDetailState>(
      listener: (context, state) {
        state.whenOrNull(
          error: (data, message) {
            BottomSheetMessage.showErrorWithAction(
              context: context,
              data: message,
              onPositive: () {
                context.pop();
                cubit.retryLastAction();
              },
            );
          },
          actionError: (data, message) {
            SnakeBarWidget.showError(context: context, message: message);
          },
          connectionError: (data) {
            BottomSheetMessage.showCustom(
              context: context,
              content: NoInternetBottomSheet(onRetry: cubit.retryLastAction),
              actionWidget: const SizedBox.shrink(),
              isDismissible: false,
              enableDrag: false,
            );
          },
        );
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF4F4F4),
        appBar: const RescuerFullScreenSheetAppBar(title: 'جزئیات امدادرسان'),
        body: BlocBuilder<RescuerDetailCubit, RescuerDetailState>(
          builder: (context, state) {
            return state.maybeWhen(
              idle: (_) => const SizedBox.shrink(),
              loading: (_) => const LoadingWidget(),
              loaded: (_) => _buildContent(context, cubit),
              actionLoading: (_) => _buildContent(context, cubit),
              orElse: () => _buildContent(context, cubit),
            );
          },
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(AppSize.s16),
              topRight: Radius.circular(AppSize.s16),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(45),
                blurRadius: 10,
                offset: const Offset(-1, 1),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(28, 12, 28, 16),
            child: InkwellButtonWidget(
              title: 'بستن',
              backgroundColor: Colors.white,
              titleColor: Theme.of(context).colorScheme.onSurfaceVariant,
              borderColor: Theme.of(context).colorScheme.outline,
              onTap: () => Navigator.of(context).pop(false),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, RescuerDetailCubit cubit) {
    final item = cubit.rescuer;
    if (item == null) return const SizedBox.shrink();

    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _ProfileHeader(item: item),
                  const SizedBox(height: 28),
                  _IdentitySection(item: item),
                  _ContactSection(item: item),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  final RescuerEntity item;

  const _ProfileHeader({required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFE7E7E7),
              ),
              child: RescuerAvatar(imageBase64: item.imageBase64, size: 86),
            ),
            Positioned(
              left: 0,
              bottom: 4,
              child: Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: const Color(0xFF00A878),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: const Icon(Icons.check, color: Colors.white, size: 14),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        BodyMediumText(
          text: item.fullName.isEmpty ? 'بدون نام' : item.fullName,
          fontWeight: FontWeight.w700,
          fontSize: 17,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 4),
        BodyMediumText(
          text: 'کد پرسنلی: ${_value(item.code)}',
          color: const Color(0xFF5F4A45),
          fontSize: 15,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class _IdentitySection extends StatelessWidget {
  final RescuerEntity item;

  const _IdentitySection({required this.item});

  @override
  Widget build(BuildContext context) {
    return RescuerDetailSectionCard(
      title: 'اطلاعات هویتی',
      icon: SvgManager.identityInformation,
      children: [
        RescuerDetailInfoGrid(
          items: [
            RescuerDetailInfoItem(
              label: 'نام و نام خانوادگی',
              value: item.fullName.isEmpty ? '-' : item.fullName,
            ),
            RescuerDetailInfoItem(
              label: 'نام پدر',
              value: _value(item.fatherName),
            ),
            RescuerDetailInfoItem(
              label: 'کد ملی',
              value: _value(item.nationalNumber),
            ),
            RescuerDetailInfoItem(
              label: 'تاریخ تولد',
              value: _value(item.birthDateJalali ?? item.birthDate),
            ),
            RescuerDetailInfoItem(
              label: 'محل تولد',
              value: _value(item.cityNamePlaceOfBirth),
            ),
            RescuerDetailInfoItem(
              label: 'وضعیت تاهل',
              value: _value(item.maritalTitle),
            ),
          ],
        ),
        const SizedBox(height: 22),
        Divider(color: Theme.of(context).dividerColor, height: 1),
        const SizedBox(height: 22),
        RescuerDetailInfoGrid(
          items: [
            RescuerDetailInfoItem(
              label: 'مدرک تحصیلی',
              value: _value(item.degreeTitle),
            ),
            RescuerDetailInfoItem(
              label: 'رشته',
              value: _value(item.certificatesTitle),
            ),
            RescuerDetailInfoItem(
              label: 'کد گواهینامه',
              value: _value(item.licenseCode),
            ),
          ],
        ),
      ],
    );
  }
}

class _ContactSection extends StatelessWidget {
  final RescuerEntity item;

  const _ContactSection({required this.item});

  @override
  Widget build(BuildContext context) {
    return RescuerDetailSectionCard(
      title: 'اطلاعات تماس',
      icon: SvgManager.contactInformation,
      children: [
        RescuerContactTile(
          title: 'شماره تلفن',
          value: _value(item.tel),
          icon: Icons.phone_android_outlined,
        ),
        RescuerContactTile(
          title: 'شماره همراه ایرانسل',
          value: item.mobile?.toLocalMobile() ?? '-',
          icon: Icons.settings_input_antenna_outlined,
        ),
        RescuerContactTile(
          title: 'شماره موبایل',
          value: item.mobile?.toLocalMobile() ?? '-',
          icon: Icons.phone_outlined,
        ),
        const SizedBox(height: 10),
        Divider(color: Theme.of(context).dividerColor, height: 1),
        const SizedBox(height: 22),
        RescuerDetailInfoGrid(
          items: [
            RescuerDetailInfoItem(
              label: 'استان',
              value: _value(item.provinceNameIssuingPlace),
            ),
            RescuerDetailInfoItem(
              label: 'شهر',
              value: _value(item.cityNameIssuingPlace),
            ),
          ],
        ),
        const SizedBox(height: 22),
        RescuerDetailInfoItem(label: 'نشانی دقیق', value: _value(item.address)),
      ],
    );
  }
}

String _value(String? value) {
  final result = value?.trim();
  return result == null || result.isEmpty ? '-' : result;
}
