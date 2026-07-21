import 'package:eks_sana_plus_org/src/features/vehicle_info/domain/entities/vehicle_model_entity.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_info/presentation/widgets/vehicle_info_form/vehicle_info_form_fields.dart';
import 'package:eks_sana_plus_org/src/features/vehicle_info/presentation/widgets/vehicle_info_form/vehicle_info_form_section.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/car_license_plate_widget/car_license_plate_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/selection_widgets/selectable_check_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class VehicleMainInfoSection extends StatelessWidget {
  const VehicleMainInfoSection({
    super.key,
    required this.vehicleModels,
    required this.selectedVehicleModelTitle,
    required this.onVehicleModelChanged,
    required this.chassisController,
    required this.engineController,
    required this.productYearController,
    required this.statusTitle,
    required this.onStatusChanged,
    required this.requiredValidator,
    required this.numberFormatters,
  });

  final List<VehicleModelEntity> vehicleModels;
  final String selectedVehicleModelTitle;
  final ValueChanged<String> onVehicleModelChanged;
  final TextEditingController chassisController;
  final TextEditingController engineController;
  final TextEditingController productYearController;
  final String statusTitle;
  final ValueChanged<String> onStatusChanged;
  final String? Function(String, String?) requiredValidator;
  final List<TextInputFormatter> numberFormatters;

  @override
  Widget build(BuildContext context) {
    return VehicleInfoFormSection(
      title: 'اطلاعات اصلی خودرو',
      icon: Icons.directions_car_outlined,
      children: [
        VehicleInfoFormDropDown(
          label: 'نوع خودرو',
          mandatory: true,
          selectedTitle: selectedVehicleModelTitle,
          items: vehicleModelTitles(vehicleModels),
          onChanged: onVehicleModelChanged,
        ),
        Space.h20,
        VehicleInfoFormTextField(
          controller: chassisController,
          label: 'شماره شاسی',
          mandatory: true,
          validator: (value) => requiredValidator('شماره شاسی', value),
        ),
        Space.h20,
        VehicleInfoFormTextField(
          controller: engineController,
          label: 'شماره موتور',
          mandatory: true,
          validator: (value) => requiredValidator('شماره موتور', value),
        ),
        Space.h20,
        VehicleInfoFormTextField(
          controller: productYearController,
          label: 'سال ساخت',
          mandatory: true,
          keyboardType: TextInputType.number,
          inputFormatters: numberFormatters,
          textDirection: TextDirection.ltr,
          validator: (value) => requiredValidator('سال ساخت', value),
        ),
        Space.h20,
        VehicleInfoFormDropDown(
          label: 'وضعیت',
          selectedTitle: statusTitle,
          items: const ['فعال', 'غیرفعال'],
          onChanged: onStatusChanged,
        ),
      ],
    );
  }
}

class VehicleSimCardSection extends StatelessWidget {
  const VehicleSimCardSection({
    super.key,
    required this.imeiController,
    required this.installDateController,
    required this.requiredValidator,
    required this.numberFormatters,
  });

  final TextEditingController imeiController;
  final TextEditingController installDateController;
  final String? Function(String, String?) requiredValidator;
  final List<TextInputFormatter> numberFormatters;

  @override
  Widget build(BuildContext context) {
    return VehicleInfoFormSection(
      title: 'اطلاعات سیمکارت',
      icon: Icons.settings_input_antenna_rounded,
      children: [
        VehicleInfoFormTextField(
          controller: imeiController,
          label: 'IMEI',
          mandatory: true,
          keyboardType: TextInputType.number,
          inputFormatters: numberFormatters,
          textDirection: TextDirection.ltr,
          validator: (value) => requiredValidator('IMEI', value),
        ),
        Space.h20,
        VehicleInfoFormTextField(
          controller: installDateController,
          label: 'تاریخ نصب',
          hint: 'مثال: 1403/01/01',
          mandatory: true,
          textDirection: TextDirection.ltr,
          validator: (value) => requiredValidator('تاریخ نصب', value),
        ),
      ],
    );
  }
}

class VehiclePlateOptionsSection extends StatelessWidget {
  const VehiclePlateOptionsSection({
    super.key,
    required this.plateController,
    required this.hasTroubleShooter,
    required this.onTroubleShooterChanged,
    required this.hasDepot,
    required this.isDepotEnabled,
    required this.onDepotEnabledChanged,
    required this.tashimTitle,
    required this.onTashimChanged,
  });

  final TextEditingController plateController;
  final bool hasTroubleShooter;
  final ValueChanged<bool> onTroubleShooterChanged;
  final bool hasDepot;
  final bool isDepotEnabled;
  final ValueChanged<bool> onDepotEnabledChanged;
  final String tashimTitle;
  final ValueChanged<String> onTashimChanged;

  @override
  Widget build(BuildContext context) {
    return VehicleInfoFormSection(
      title: 'پلاک و امکانات',
      icon: Icons.car_repair_outlined,
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            'شماره پلاک خودرو',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        Space.h8,
        LicensePlateTextFormFieldWidget(
          controller: plateController,
          mandatory: true,
        ),
        Space.h20,
        VehicleInfoFormCheckBox(
          title: 'دستگاه عیب یاب دارد',
          value: hasTroubleShooter,
          onChanged: onTroubleShooterChanged,
        ),
        if (hasDepot) ...[
          VehicleInfoFormCheckBox(
            title: 'انبارک فعال است',
            value: isDepotEnabled,
            onChanged: onDepotEnabledChanged,
          ),
          if (isDepotEnabled) ...[
            Space.h12,
            VehicleInfoFormDropDown(
              label: 'مدل تسهیم انبارک',
              mandatory: true,
              selectedTitle: tashimTitle,
              items: const [
                'انتخاب کنید',
                'براساس نمایندگی',
                'براساس خودرو',
              ],
              onChanged: onTashimChanged,
            ),
          ],
        ],
      ],
    );
  }
}

List<String> vehicleModelTitles(List<VehicleModelEntity> items) {
  if (items.isEmpty) return const ['انتخاب کنید'];
  return [
    'انتخاب کنید',
    ...items
        .map((item) => item.title.trim())
        .where((title) => title.isNotEmpty),
  ];
}

String selectedVehicleModelTitle(VehicleModelEntity? item) {
  return item?.title ?? 'انتخاب کنید';
}
