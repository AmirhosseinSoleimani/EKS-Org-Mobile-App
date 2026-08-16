import 'package:eks_sana_plus_org/src/features/invoice_management/domain/emdadgar_invoices/entities/emdadgar_settlement_entity.dart';

class EmdadgarSettlementModel extends EmdadgarSettlementEntity {
  const EmdadgarSettlementModel({
    super.amounts,
    super.coefficients,
  });
}

class EmdadgarSettlementAmountsModel extends EmdadgarSettlementAmountsEntity {
  const EmdadgarSettlementAmountsModel({
    super.priceAfterCoefficients,
    super.totalWithoutTaxAndInsurance,
    super.totalPrice,
    super.distanceCost,
    super.distanceCostWithCoefficient,
    super.entranceWageCost,
    super.entranceWageCostWithCoefficient,
    super.towingCost,
    super.towingCostWithCoefficient,
    super.loadingCost,
    super.loadingCostWithCoefficient,
    super.stopTimeCost,
    super.stopTimeCostWithCoefficient,
    super.useAppCost,
    super.insurance,
    super.valueAddedTaxCost,
    super.nightAndHolidayCost,
    super.customerTotalPartPrice,
    super.companyTotalPartPrice,
    super.guarantyTotalPartPrice,
    super.customerTotalLaborPrice,
    super.companyTotalLaborPrice,
    super.guarantyTotalLaborPrice,
    super.totalPriceWithCoefficient,
    super.customerTotalReusablePartPrice,
    super.companyTotalReusablePartPrice,
  });
}

class EmdadgarSettlementCoefficientsModel
    extends EmdadgarSettlementCoefficientsEntity {
  const EmdadgarSettlementCoefficientsModel({
    super.privateCarText,
    super.privateCarPrice,
    super.agencyGradeText,
    super.agencyGradePrice,
    super.commissionText,
    super.commissionPrice,
    super.commissionCoefficient,
  });
}
