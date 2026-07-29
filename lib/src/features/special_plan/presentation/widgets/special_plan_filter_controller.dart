import 'package:eks_sana_plus_org/src/features/special_plan/domain/entities/special_plan_product_entity.dart';
import 'package:eks_sana_plus_org/src/features/special_plan/presentation/services/special_plan_date_formatter.dart';
import 'package:eks_sana_plus_org/src/features/special_plan/presentation/widgets/special_plan_filter_value.dart';
import 'package:eks_sana_plus_org/src/shared/features/map/domain/entity/province_lookup_entity.dart';
import 'package:flutter/material.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

class SpecialPlanFilterController extends ChangeNotifier {
  SpecialPlanFilterController({
    required SpecialPlanFilterValue initialValue,
    required List<SpecialPlanProductEntity> products,
    required List<ProvinceLookupEntity> provinces,
  })  : titleController = TextEditingController(text: initialValue.title),
        orderController = TextEditingController(
          text: initialValue.orderNo?.toString() ?? '',
        ),
        cityController = TextEditingController(text: initialValue.cityTitle),
        startDateController = TextEditingController(
          text: initialValue.startDate == null
              ? ''
              : SpecialPlanDateFormatter.jalaliDate(initialValue.startDate),
        ),
        endDateController = TextEditingController(
          text: initialValue.endDate == null
              ? ''
              : SpecialPlanDateFormatter.jalaliDate(initialValue.endDate),
        ),
        _product = _findProduct(products, initialValue.productId),
        _province = _findProvince(provinces, initialValue.provinceTitle),
        _hasHighPriority = initialValue.hasHighPriority,
        _isActive = initialValue.isActive,
        _onlySaipaCars = initialValue.onlySaipaCars,
        _startDate = initialValue.startDate,
        _endDate = initialValue.endDate;

  final TextEditingController titleController;
  final TextEditingController orderController;
  final TextEditingController cityController;
  final TextEditingController startDateController;
  final TextEditingController endDateController;

  SpecialPlanProductEntity? _product;
  ProvinceLookupEntity? _province;
  bool? _hasHighPriority;
  bool? _isActive;
  bool? _onlySaipaCars;
  DateTime? _startDate;
  DateTime? _endDate;

  SpecialPlanProductEntity? get product => _product;

  ProvinceLookupEntity? get province => _province;

  bool? get hasHighPriority => _hasHighPriority;

  bool? get isActive => _isActive;

  bool? get onlySaipaCars => _onlySaipaCars;

  DateTime? get startDate => _startDate;

  DateTime? get endDate => _endDate;

  SpecialPlanFilterValue get value => SpecialPlanFilterValue(
        title: _normalizedText(titleController),
        productId: _product?.id,
        hasHighPriority: _hasHighPriority,
        startDate: _startDate,
        endDate: _endDate,
        orderNo: int.tryParse(orderController.text.trim()),
        provinceTitle: _province?.name,
        cityTitle: _normalizedText(cityController),
        isActive: _isActive,
        onlySaipaCars: _onlySaipaCars,
      );

  void selectProduct(SpecialPlanProductEntity? value) {
    if (_product == value) return;
    _product = value;
    notifyListeners();
  }

  void selectProvince(ProvinceLookupEntity? value) {
    if (_province == value) return;
    _province = value;
    notifyListeners();
  }

  void selectHighPriority(bool? value) {
    if (_hasHighPriority == value) return;
    _hasHighPriority = value;
    notifyListeners();
  }

  void selectStatus(bool? value) {
    if (_isActive == value) return;
    _isActive = value;
    notifyListeners();
  }

  void selectOnlySaipaCars(bool? value) {
    if (_onlySaipaCars == value) return;
    _onlySaipaCars = value;
    notifyListeners();
  }

  void selectStartDate(Jalali? value) {
    if (value == null) return;
    _startDate = value.toDateTime();
    notifyListeners();
  }

  void selectEndDate(Jalali? value) {
    if (value == null) return;
    _endDate = value.toDateTime();
    notifyListeners();
  }

  @override
  void dispose() {
    titleController.dispose();
    orderController.dispose();
    cityController.dispose();
    startDateController.dispose();
    endDateController.dispose();
    super.dispose();
  }

  static String? _normalizedText(TextEditingController controller) {
    final value = controller.text.trim();
    return value.isEmpty ? null : value;
  }

  static SpecialPlanProductEntity? _findProduct(
    List<SpecialPlanProductEntity> products,
    int? id,
  ) {
    if (id == null) return null;

    for (final product in products) {
      if (product.id == id) return product;
    }

    return null;
  }

  static ProvinceLookupEntity? _findProvince(
    List<ProvinceLookupEntity> provinces,
    String? title,
  ) {
    final normalizedTitle = title?.trim();
    if (normalizedTitle == null || normalizedTitle.isEmpty) return null;

    for (final province in provinces) {
      if (province.name == normalizedTitle) return province;
    }

    return null;
  }
}
