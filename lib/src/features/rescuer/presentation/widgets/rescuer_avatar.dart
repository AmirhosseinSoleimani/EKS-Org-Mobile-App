import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';

class RescuerAvatar extends StatelessWidget {
  final String? imageBase64;
  final double size;

  const RescuerAvatar({super.key, required this.imageBase64, this.size = 52});

  @override
  Widget build(BuildContext context) {
    final bytes = _decodeImage(imageBase64);

    return SizedBox.square(
      dimension: size,
      child: ClipOval(
        child: bytes == null
            ? _buildFallback(context)
            : Image.memory(
                bytes,
                fit: BoxFit.cover,
                gaplessPlayback: true,
                errorBuilder: (_, __, ___) => _buildFallback(context),
              ),
      ),
    );
  }

  Widget _buildFallback(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return ColoredBox(
      color: colorScheme.primary.withAlpha(24),
      child: Icon(
        Icons.person_outline,
        color: colorScheme.primary,
        size: size * 0.55,
      ),
    );
  }

  Uint8List? _decodeImage(String? source) {
    final value = source?.trim();
    if (value == null || value.isEmpty) return null;

    try {
      final base64Value = value.contains(',')
          ? value.substring(value.indexOf(',') + 1)
          : value;
      return base64Decode(base64Value);
    } catch (_) {
      return null;
    }
  }
}
