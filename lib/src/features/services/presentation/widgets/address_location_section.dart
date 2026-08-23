import 'package:eks_sana_plus_org/src/common/constants/service_type.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/form_widgets/form_section_container.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/domain/entity/address_info_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/domain/entity/province_entity.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/presentation/page/bottom_sheet/selectable_map_bottom_sheet.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/presentation/view_model/marker_style.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/presentation/page/widget/single_location_map_widget.dart';
import 'package:eks_sana_plus_org/src/shared/resources/assets_manager.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/filter_button.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/filter_widgets/overlay_drop_down_menu.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/form_widgets/text_form_field_widget.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_medium_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AddressLocationSection extends StatelessWidget {
  const AddressLocationSection({
    super.key,
    required this.latitude,
    required this.longitude,
    required this.selectedProvince,
    required this.provinceList,
    required this.addressController,
    required this.onProvinceSelected,
    required this.onLocationSelected,
    this.extraWidgets,
    required this.serviceType,
  });

  final List<Widget>? extraWidgets;
  final ServiceType serviceType;

  final double latitude;
  final double longitude;

  final ValueListenable<ProvinceEntity?> selectedProvince;
  final List<ProvinceEntity> provinceList;

  final TextEditingController addressController;

  final ValueChanged<ProvinceEntity> onProvinceSelected;
  final ValueChanged<AddressInfoEntity> onLocationSelected;

  Future<void> _showSelectableMap(BuildContext context) async {
    final AddressInfoEntity initialLocation = AddressInfoEntity(
      latitude:latitude,
      longitude: longitude,
    );

    final result = await SelectableMapBottomSheet.show(
      context: context,
      initialLocation: initialLocation,
      serviceType: serviceType,
    );

    if (result != null && context.mounted) {
      onLocationSelected(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FormSectionContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const BodyMediumText(text: "موقعیت و آدرس"),
          Space.h32,

          SizedBox(
            height: 280,
            child: Stack(
              children: [
                SingleLocationMapWidget(
                  serviceType: serviceType,
                  latitude: latitude,
                  longitude: longitude,
                  height: null,
                  markerStyle: MarkerStyle(
                    iconPath: serviceType == ServiceType.homeService
                        ? SvgManager.homeServiceLocation
                        : SvgManager.location,
                  ),
                ),
                Positioned(
                  bottom: 12,
                  left: 12,
                  right: 12,
                  child: InkWell(
                    onTap: () => _showSelectableMap(context),
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 94,
                        vertical: 6,
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 6),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withAlpha(16),
                            spreadRadius: 2,
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      alignment: Alignment.center,
                      child: FittedBox(child: const BodyMediumText(text: "انتخاب روی نقشه")),
                    ),
                  ),
                ),
              ],
            ),
          ),

          Space.h24,
          if (extraWidgets != null) ...[...extraWidgets!, Space.h24],

          ValueListenableBuilder<ProvinceEntity?>(
            valueListenable: selectedProvince,
            builder: (_, province, __) {
              return SizedBox(
                height: 52,
                child: FilterButton(
                  title: province?.title ?? "انتخاب شهر و استان",
                  label: 'شهر و استان',
                  hasFloatingLabel: true,
                  expand: true,
                  overlayBuilder: (context, position, width, dismiss) {
                    return OverlayDropdownMenu<ProvinceEntity>(
                      position: position,
                      width: width,
                      items: provinceList,
                      onDismiss: dismiss,
                      onSelect: (item) {
                        onProvinceSelected(item);
                        dismiss();
                      },
                    );
                  },
                ),
              );
            },
          ),

          Space.h24,

          TextFormFieldWidget(
            labelText: "آدرس",
            controller: addressController,
            autofocus: false,
            textInputType: TextInputType.streetAddress,
            textAlign: TextAlign.start,
            textInputAction: TextInputAction.done,
            maxLines: 3,
          ),
        ],
      ),
    );
  }
}
