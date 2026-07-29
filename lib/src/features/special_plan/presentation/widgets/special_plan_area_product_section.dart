import 'package:eks_sana_plus_org/src/features/special_plan/domain/entities/special_plan_product_entity.dart';
import 'package:eks_sana_plus_org/src/features/special_plan/presentation/widgets/special_plan_section_header.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/domain/entity/discountable_area_entity.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/drop_down_widget/overlay_dropdown_form_field.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/form_widgets/form_section_container.dart';
import 'package:flutter/material.dart';

class SpecialPlanAreaProductSection extends StatelessWidget {
  const SpecialPlanAreaProductSection({
    super.key,
    required this.areas,
    required this.products,
    required this.selectedArea,
    required this.selectedProduct,
    required this.onAreaChanged,
    required this.onProductChanged,
  });

  final List<DiscountableAreaEntity> areas;
  final List<SpecialPlanProductEntity> products;
  final DiscountableAreaEntity? selectedArea;
  final SpecialPlanProductEntity? selectedProduct;
  final ValueChanged<DiscountableAreaEntity?> onAreaChanged;
  final ValueChanged<SpecialPlanProductEntity?> onProductChanged;

  @override
  Widget build(BuildContext context) {
    return FormSectionContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SpecialPlanSectionHeader(
            title: 'محدوده و محصول',
            icon: Icons.map_outlined,
          ),
          Space.h20,
          OverlayDropdownFormField<DiscountableAreaEntity>(
            labelText: 'محدوده جغرافیایی',
            mandatory: true,
            items: areas,
            value: selectedArea,
            validator: (value) =>
                value == null ? 'این فیلد الزامی است.' : null,
            onChanged: onAreaChanged,
          ),
          Space.h16,
          OverlayDropdownFormField<SpecialPlanProductEntity>(
            labelText: 'محصول طرح',
            items: products,
            value: selectedProduct,
            onChanged: onProductChanged,
          ),
        ],
      ),
    );
  }
}
