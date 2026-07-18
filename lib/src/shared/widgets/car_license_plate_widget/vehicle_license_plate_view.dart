
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:flutter/material.dart';

class VehicleLicensePlateView extends StatelessWidget {
  const VehicleLicensePlateView({
    super.key,
    required this.licensePlate,
  });

  final String licensePlate;

  @override
  Widget build(BuildContext context) {
    final parts = licensePlate.trim().split(RegExp(r'\s+'));
    final normalized = parts.length >= 4 ? parts.take(4).toList() : <String>['--', '-', '---', '--'];

    return Container(
      height: AppSize.s42,
      constraints: const BoxConstraints(maxWidth: 196),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(width: 2, color: Colors.black87),
        borderRadius: BorderRadius.circular(AppSize.s6),
      ),
      child: Row(
        children: [
          _PlateCell(normalized[3], flex: 2),
          VerticalDivider(
            thickness: AppSize.s1,
            color: Theme.of(context).colorScheme.shadow,
          ),

          _PlateCell(normalized[0], flex: 2),
          _PlateCell(normalized[1], flex: 2),
          _PlateCell(normalized[2], flex: 3),

          Container(
            width: AppSize.s28,
            height: double.infinity,
            color: const Color(0xFF073DA1),
            alignment: Alignment.center,
            child: const Text(
              'I.R.\nIRAN',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 7, fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }
}

class _PlateCell extends StatelessWidget {
  const _PlateCell(this.text, {required this.flex});

  final String text;
  final int flex;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Center(
        child: Text(
          text,
          maxLines: 1,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: Colors.black87,
              fontSize: AppSize.s14
          ),
        ),
      ),
    );
  }
}
