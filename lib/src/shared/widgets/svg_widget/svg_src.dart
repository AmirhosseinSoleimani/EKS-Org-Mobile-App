import 'dart:typed_data';

import 'package:flutter/material.dart';

sealed class SvgSrc {
  const SvgSrc();

  factory SvgSrc.asset(
      String assetName, {
        AssetBundle? bundle,
        String? package,
      }) = SvgAsset;

  factory SvgSrc.network(
      String url, {
        Map<String, String>? headers,
        Duration? cacheMaxAge,
      }) = SvgNetwork;

  factory SvgSrc.memory(Uint8List bytes) = SvgMemory;
}

class SvgAsset extends SvgSrc {
  final String assetName;
  final AssetBundle? bundle;
  final String? package;
  const SvgAsset(this.assetName, {this.bundle, this.package});
}

class SvgNetwork extends SvgSrc {
  final String url;
  final Map<String, String>? headers;
  final Duration? cacheMaxAge;
  const SvgNetwork(this.url, {this.headers, this.cacheMaxAge});
}

class SvgMemory extends SvgSrc {
  final Uint8List bytes;
  const SvgMemory(this.bytes);
}