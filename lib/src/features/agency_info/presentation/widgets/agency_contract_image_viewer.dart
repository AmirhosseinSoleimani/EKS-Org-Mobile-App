import 'dart:convert';
import 'dart:typed_data';

import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:flutter/material.dart';

class AgencyContractImageViewer extends StatelessWidget {
  const AgencyContractImageViewer({
    super.key,
    required this.fileBase64,
  });

  final String fileBase64;

  static Future<void> show(
    BuildContext context, {
    required String fileBase64,
  }) async {
    await Navigator.of(context, rootNavigator: true).push<void>(
      MaterialPageRoute<void>(
        fullscreenDialog: true,
        builder: (_) => AgencyContractImageViewer(fileBase64: fileBase64),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final imageBytes = _decodeImage(fileBase64);

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: imageBytes == null
                  ? const _InvalidContractImageView()
                  : InteractiveViewer(
                      minScale: 0.8,
                      maxScale: 5,
                      child: Center(
                        child: Image.memory(
                          imageBytes,
                          fit: BoxFit.contain,
                          gaplessPlayback: true,
                          errorBuilder: (_, __, ___) {
                            return const _InvalidContractImageView();
                          },
                        ),
                      ),
                    ),
            ),
            Positioned(
              top: AppPadding.p8,
              right: AppPadding.p8,
              child: Material(
                color: Colors.black.withOpacity(0.45),
                shape: const CircleBorder(),
                child: IconButton(
                  tooltip: 'بستن',
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(
                    Icons.close_rounded,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Uint8List? _decodeImage(String value) {
    try {
      final trimmedValue = value.trim();
      if (trimmedValue.isEmpty) return null;

      final separatorIndex = trimmedValue.indexOf(',');
      final payload = separatorIndex >= 0
          ? trimmedValue.substring(separatorIndex + 1)
          : trimmedValue;
      final normalizedPayload = payload.replaceAll(RegExp(r'\s+'), '');

      if (normalizedPayload.isEmpty) return null;
      return base64Decode(base64.normalize(normalizedPayload));
    } catch (_) {
      return null;
    }
  }
}

class _InvalidContractImageView extends StatelessWidget {
  const _InvalidContractImageView();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p24),
        child: Text(
          'تصویر قرارداد قابل نمایش نیست.',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
        ),
      ),
    );
  }
}
