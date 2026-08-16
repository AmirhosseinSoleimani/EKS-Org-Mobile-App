import 'package:eks_sana_plus_org/src/features/invoice_management/data/emdadgar_invoices/models/emdadgar_settlement_model.dart';

class EmdadgarSettlementEntity {
  const EmdadgarSettlementEntity({
    this.amounts,
    this.coefficients,
  });

  final EmdadgarSettlementAmountsEntity? amounts;
  final EmdadgarSettlementCoefficientsEntity? coefficients;

  EmdadgarSettlementModel toModel() {
    return EmdadgarSettlementModel(
      amounts: amounts?.toModel(),
      coefficients: coefficients?.toModel(),
    );
  }
}

class EmdadgarSettlementAmountsEntity {
  const EmdadgarSettlementAmountsEntity({
    this.priceAfterCoefficients,
    this.totalWithoutTaxAndInsurance,
    this.totalPrice,
    this.distanceCost,
    this.distanceCostWithCoefficient,
    this.entranceWageCost,
    this.entranceWageCostWithCoefficient,
    this.towingCost,
    this.towingCostWithCoefficient,
    this.loadingCost,
    this.loadingCostWithCoefficient,
    this.stopTimeCost,
    this.stopTimeCostWithCoefficient,
    this.useAppCost,
    this.insurance,
    this.valueAddedTaxCost,
    this.nightAndHolidayCost,
    this.customerTotalPartPrice,
    this.companyTotalPartPrice,
    this.guarantyTotalPartPrice,
    this.customerTotalLaborPrice,
    this.companyTotalLaborPrice,
    this.guarantyTotalLaborPrice,
    this.totalPriceWithCoefficient,
    this.customerTotalReusablePartPrice,
    this.companyTotalReusablePartPrice,
  });

  final int? priceAfterCoefficients;
  final int? totalWithoutTaxAndInsurance;
  final int? totalPrice;
  final int? distanceCost;
  final int? distanceCostWithCoefficient;
  final int? entranceWageCost;
  final int? entranceWageCostWithCoefficient;
  final int? towingCost;
  final int? towingCostWithCoefficient;
  final int? loadingCost;
  final int? loadingCostWithCoefficient;
  final int? stopTimeCost;
  final int? stopTimeCostWithCoefficient;
  final int? useAppCost;
  final int? insurance;
  final int? valueAddedTaxCost;
  final int? nightAndHolidayCost;
  final int? customerTotalPartPrice;
  final int? companyTotalPartPrice;
  final int? guarantyTotalPartPrice;
  final int? customerTotalLaborPrice;
  final int? companyTotalLaborPrice;
  final int? guarantyTotalLaborPrice;
  final int? totalPriceWithCoefficient;
  final int? customerTotalReusablePartPrice;
  final int? companyTotalReusablePartPrice;

  EmdadgarSettlementAmountsModel toModel() {
    return EmdadgarSettlementAmountsModel(
      priceAfterCoefficients: priceAfterCoefficients,
      totalWithoutTaxAndInsurance: totalWithoutTaxAndInsurance,
      totalPrice: totalPrice,
      distanceCost: distanceCost,
      distanceCostWithCoefficient: distanceCostWithCoefficient,
      entranceWageCost: entranceWageCost,
      entranceWageCostWithCoefficient: entranceWageCostWithCoefficient,
      towingCost: towingCost,
      towingCostWithCoefficient: towingCostWithCoefficient,
      loadingCost: loadingCost,
      loadingCostWithCoefficient: loadingCostWithCoefficient,
      stopTimeCost: stopTimeCost,
      stopTimeCostWithCoefficient: stopTimeCostWithCoefficient,
      useAppCost: useAppCost,
      insurance: insurance,
      valueAddedTaxCost: valueAddedTaxCost,
      nightAndHolidayCost: nightAndHolidayCost,
      customerTotalPartPrice: customerTotalPartPrice,
      companyTotalPartPrice: companyTotalPartPrice,
      guarantyTotalPartPrice: guarantyTotalPartPrice,
      customerTotalLaborPrice: customerTotalLaborPrice,
      companyTotalLaborPrice: companyTotalLaborPrice,
      guarantyTotalLaborPrice: guarantyTotalLaborPrice,
      totalPriceWithCoefficient: totalPriceWithCoefficient,
      customerTotalReusablePartPrice: customerTotalReusablePartPrice,
      companyTotalReusablePartPrice: companyTotalReusablePartPrice,
    );
  }
}

class EmdadgarSettlementCoefficientsEntity {
  const EmdadgarSettlementCoefficientsEntity({
    this.privateCarText,
    this.privateCarPrice,
    this.agencyGradeText,
    this.agencyGradePrice,
    this.commissionText,
    this.commissionPrice,
    this.commissionCoefficient,
  });

  final String? privateCarText;
  final int? privateCarPrice;
  final String? agencyGradeText;
  final int? agencyGradePrice;
  final String? commissionText;
  final int? commissionPrice;
  final String? commissionCoefficient;

  EmdadgarSettlementCoefficientsModel toModel() {
    return EmdadgarSettlementCoefficientsModel(
      privateCarText: privateCarText,
      privateCarPrice: privateCarPrice,
      agencyGradeText: agencyGradeText,
      agencyGradePrice: agencyGradePrice,
      commissionText: commissionText,
      commissionPrice: commissionPrice,
      commissionCoefficient: commissionCoefficient,
    );
  }
}
