import 'dart:typed_data';

import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'svg_src.dart';


class SvgWidget extends StatelessWidget {
  const SvgWidget({
    super.key,
    required this.src,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
    this.alignment = Alignment.center,
    this.semanticsLabel,
    this.placeholder,
    this.errorBuilder,
    this.color,
    this.colorBlendMode = BlendMode.srcIn,
    this.matchTextDirection = false,
    this.allowDrawingOutsideViewBox = false,
    this.borderRadius,
    this.clipBehavior = Clip.none,
    this.cacheManager,
    this.cacheNetwork = true,
    this.networkTimeout = DurationConstant.d6000,
  });
  final SvgSrc src;
  final double? width;
  final double? height;
  final BoxFit fit;
  final AlignmentGeometry alignment;
  final String? semanticsLabel;
  final Widget? placeholder;
  final Widget Function(BuildContext context, Object error, StackTrace? stack)? errorBuilder;
  final Color? color;
  final BlendMode colorBlendMode;
  final bool matchTextDirection;
  final bool allowDrawingOutsideViewBox;
  final BorderRadius? borderRadius;
  final Clip clipBehavior;
  final BaseCacheManager? cacheManager;
  final bool cacheNetwork;
  final Duration networkTimeout;

  @override
  Widget build(BuildContext context) {
    final Widget child;

    switch (src) {
      case SvgAsset(:final assetName, :final bundle, :final package):
        child = _wrapSvg(
          SvgPicture.asset(
            assetName,
            bundle: bundle,
            package: package,
            width: width,
            height: height,
            fit: fit,
            alignment: alignment,
            matchTextDirection: matchTextDirection,
            allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
            colorFilter: _maybeColorFilter(),
            semanticsLabel: semanticsLabel,
          ),
        );
      case SvgMemory(:final bytes):
        child = _wrapSvg(
          SvgPicture.memory(
            bytes,
            width: width,
            height: height,
            fit: fit,
            alignment: alignment,
            matchTextDirection: matchTextDirection,
            allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
            colorFilter: _maybeColorFilter(),
            semanticsLabel: semanticsLabel,
          ),
        );
      case SvgNetwork(:final url, :final headers, :final cacheMaxAge):
        if (kIsWeb || !cacheNetwork) {
          child = _wrapSvg(
            SvgPicture.network(
              url,
              headers: headers,
              width: width,
              height: height,
              fit: fit,
              alignment: alignment,
              matchTextDirection: matchTextDirection,
              allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
              colorFilter: _maybeColorFilter(),
              semanticsLabel: semanticsLabel,
              placeholderBuilder:
              placeholder != null ? (_) => placeholder! : null,
            ),
          );
        } else {
          child = _wrapSvg(
            _CachedNetworkSvg(
              url: url,
              headers: headers,
              width: width,
              height: height,
              fit: fit,
              alignment: alignment,
              matchTextDirection: matchTextDirection,
              allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
              colorFilter: _maybeColorFilter(),
              semanticsLabel: semanticsLabel,
              placeholder: placeholder,
              errorBuilder: errorBuilder,
              cacheManager: cacheManager ?? DefaultCacheManager(),
              cacheMaxAge: cacheMaxAge,
              networkTimeout: networkTimeout,
            ),
          );
        }
    }
    return child;
  }
  ColorFilter? _maybeColorFilter() {
    if (color == null) return null;
    return ColorFilter.mode(color!, colorBlendMode);
  }
  Widget _wrapSvg(Widget svg) {
    if (borderRadius == null && clipBehavior == Clip.none) return svg;
    return ClipRRect(
      clipBehavior: clipBehavior,
      borderRadius: borderRadius ?? BorderRadius.zero,
      child: svg,
    );
  }
}
class _CachedNetworkSvg extends StatefulWidget {
  const _CachedNetworkSvg({
    required this.url,
    this.headers,
    this.width,
    this.height,
    required this.fit,
    required this.alignment,
    required this.matchTextDirection,
    required this.allowDrawingOutsideViewBox,
    required this.colorFilter,
    required this.semanticsLabel,
    this.placeholder,
    this.errorBuilder,
    required this.cacheManager,
    this.cacheMaxAge,
    required this.networkTimeout,
  });

  final String url;
  final Map<String, String>? headers;
  final double? width;
  final double? height;
  final BoxFit fit;
  final AlignmentGeometry alignment;
  final bool matchTextDirection;
  final bool allowDrawingOutsideViewBox;
  final ColorFilter? colorFilter;
  final String? semanticsLabel;
  final Widget? placeholder;
  final Widget Function(BuildContext, Object, StackTrace?)? errorBuilder;
  final BaseCacheManager cacheManager;
  final Duration? cacheMaxAge;
  final Duration networkTimeout;

  @override
  State<_CachedNetworkSvg> createState() => _CachedNetworkSvgState();
}

class _CachedNetworkSvgState extends State<_CachedNetworkSvg> {
  late Future<Uint8List> _future;

  @override
  void initState() {
    super.initState();
    _future = _loadBytes();
  }

  Future<Uint8List> _loadBytes() async {
    final cached = await widget.cacheManager.getFileFromCache(widget.url);
    if (cached != null &&
        (widget.cacheMaxAge == null ||
            DateTime.now()
                .difference(cached.validTill.subtract(widget.cacheMaxAge!)) <
                widget.cacheMaxAge!)) {
      final bytes = await cached.file.readAsBytes();
      if (bytes.isNotEmpty) return bytes;
    }

    final file = await widget.cacheManager
        .getSingleFile(widget.url, headers: widget.headers ?? {})
        .timeout(widget.networkTimeout);

    final bytes = await file.readAsBytes();
    if (bytes.isEmpty) {
      throw StateError('Empty SVG bytes from ${widget.url}');
    }
    return bytes;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Uint8List>(
      future: _future,
      builder: (context, snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return widget.placeholder ??
              SizedBox(
                width: widget.width,
                height: widget.height,
                child: const Center(
                    child: CircularProgressIndicator(strokeWidth: AppSize.s2)),
              );
        }
        if (snap.hasError) {
          final err = snap.error!;
          final st = snap.stackTrace;
          if (widget.errorBuilder != null) {
            return widget.errorBuilder!(context, err, st);
          }
          return SizedBox(
            width: widget.width,
            height: widget.height,
            child: const Icon(Icons.broken_image_outlined),
          );
        }
        final bytes = snap.data!;
        return SvgPicture.memory(
          bytes,
          width: widget.width,
          height: widget.height,
          fit: widget.fit,
          alignment: widget.alignment,
          matchTextDirection: widget.matchTextDirection,
          allowDrawingOutsideViewBox: widget.allowDrawingOutsideViewBox,
          colorFilter: widget.colorFilter,
          semanticsLabel: widget.semanticsLabel,
        );
      },
    );
  }
}