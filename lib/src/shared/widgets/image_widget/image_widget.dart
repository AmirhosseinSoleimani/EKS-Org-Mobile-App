import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:eks_sana_plus_org/src/shared/resources/assets_manager.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';



class ImageWidget extends StatelessWidget {
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius? borderRadius;
  final bool isCircle;
  final Widget? placeholder;
  final Widget? errorWidget;
  final VoidCallback? onTap;
  final String? heroTag;
  final AlignmentGeometry alignment;
  final Color? backgroundColor;
  final String? url;
  final Map<String, String>? headers;
  final Duration fadeInDuration;
  final Duration? networkTimeout;
  final File? file;
  final String? assetName;
  final AssetBundle? bundle;
  final String? package;
  final Uint8List? bytes;

  const ImageWidget._({
    super.key,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.isCircle = false,
    this.placeholder,
    this.errorWidget,
    this.onTap,
    this.heroTag,
    this.alignment = Alignment.center,
    this.backgroundColor,
    this.url,
    this.headers,
    this.fadeInDuration = const Duration(milliseconds: 250),
    this.networkTimeout,
    this.file,
    this.assetName,
    this.bundle,
    this.package,
    this.bytes,
  });

  factory ImageWidget.network(
      String url, {
        Key? key,
        double? width,
        double? height,
        BoxFit fit = BoxFit.cover,
        BorderRadius? borderRadius,
        bool isCircle = false,
        Widget? placeholder,
        Widget? errorWidget,
        VoidCallback? onTap,
        String? heroTag,
        AlignmentGeometry alignment = Alignment.center,
        Color? backgroundColor,
        Map<String, String>? headers,
        Duration fadeInDuration = const Duration(milliseconds: 250),
        Duration networkTimeout = const Duration(seconds: 5),
      }) {
    return ImageWidget._(
      key: key,
      url: url,
      width: width,
      height: height,
      fit: fit,
      borderRadius: borderRadius,
      isCircle: isCircle,
      placeholder: placeholder,
      errorWidget: errorWidget,
      onTap: onTap,
      heroTag: heroTag,
      alignment: alignment,
      backgroundColor: backgroundColor,
      headers: headers,
      fadeInDuration: fadeInDuration,
      networkTimeout: networkTimeout,
    );
  }

  factory ImageWidget.file(
      File file, {
        Key? key,
        double? width,
        double? height,
        BoxFit fit = BoxFit.cover,
        BorderRadius? borderRadius,
        bool isCircle = false,
        Widget? placeholder,
        Widget? errorWidget,
        VoidCallback? onTap,
        String? heroTag,
        AlignmentGeometry alignment = Alignment.center,
        Color? backgroundColor,
      }) {
    return ImageWidget._(
      key: key,
      file: file,
      width: width,
      height: height,
      fit: fit,
      borderRadius: borderRadius,
      isCircle: isCircle,
      placeholder: placeholder,
      errorWidget: errorWidget,
      onTap: onTap,
      heroTag: heroTag,
      alignment: alignment,
      backgroundColor: backgroundColor,
    );
  }

  factory ImageWidget.asset(
      String assetName, {
        Key? key,
        double? width,
        double? height,
        BoxFit fit = BoxFit.cover,
        BorderRadius? borderRadius,
        bool isCircle = false,
        Widget? placeholder,
        Widget? errorWidget,
        VoidCallback? onTap,
        String? heroTag,
        AlignmentGeometry alignment = Alignment.center,
        Color? backgroundColor,
        AssetBundle? bundle,
        String? package,
      }) {
    return ImageWidget._(
      key: key,
      assetName: assetName,
      width: width,
      height: height,
      fit: fit,
      borderRadius: borderRadius,
      isCircle: isCircle,
      placeholder: placeholder,
      errorWidget: errorWidget,
      onTap: onTap,
      heroTag: heroTag,
      alignment: alignment,
      backgroundColor: backgroundColor,
      bundle: bundle,
      package: package,
    );
  }

  factory ImageWidget.memory(
      Uint8List bytes, {
        Key? key,
        double? width,
        double? height,
        BoxFit fit = BoxFit.cover,
        BorderRadius? borderRadius,
        bool isCircle = false,
        Widget? placeholder,
        Widget? errorWidget,
        VoidCallback? onTap,
        String? heroTag,
        AlignmentGeometry alignment = Alignment.center,
        Color? backgroundColor,
      }) {
    return ImageWidget._(
      key: key,
      bytes: bytes,
      width: width,
      height: height,
      fit: fit,
      borderRadius: borderRadius,
      isCircle: isCircle,
      placeholder: placeholder,
      errorWidget: errorWidget,
      onTap: onTap,
      heroTag: heroTag,
      alignment: alignment,
      backgroundColor: backgroundColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget child;
    if (url != null) {
      child = _buildNetwork(context);
    } else if (file != null) {
      child = Image.file(
        file!,
        width: width,
        height: height,
        fit: fit,
        alignment: alignment,
        errorBuilder: (_, __, ___) => _errorFallback(),
      );
    } else if (assetName != null) {
      child = Image.asset(
        assetName!,
        width: width,
        height: height,
        fit: fit,
        alignment: alignment,
        package: package,
        bundle: bundle,
        errorBuilder: (_, __, ___) => _errorFallback(),
      );
    } else if (bytes != null) {
      child = Image.memory(
        bytes!,
        width: width,
        height: height,
        fit: fit,
        alignment: alignment,
        errorBuilder: (_, __, ___) => _errorFallback(),
      );
    } else {
      child = _errorFallback();
    }

    if (backgroundColor != null) {
      child = ColoredBox(color: backgroundColor!, child: child);
    }
    if (onTap != null) {
      child = GestureDetector(onTap: onTap, child: child);
    }
    if (heroTag != null && heroTag!.isNotEmpty) {
      child = Hero(tag: heroTag!, child: child);
    }

    if (isCircle) {
      return ClipOval(child: child);
    } else if (borderRadius != null) {
      return ClipRRect(borderRadius: borderRadius!, child: child);
    }
    return child;
  }

  Widget _buildNetwork(BuildContext context) {
    final urlStr = url!;
    if (networkTimeout == null) {
      return CachedNetworkImage(
        imageUrl: urlStr,
        httpHeaders: headers,
        width: width,
        height: height,
        fit: fit,
        fadeInDuration: fadeInDuration,
        placeholder: (_, __) => placeholder ?? _defaultPlaceholder(),
        errorWidget: (_, __, ___) => errorWidget ?? _errorFallback(),
        memCacheWidth: _memCache(width),
        memCacheHeight: _memCache(height),
        imageBuilder: (_, provider) => _wrapProvider(provider),
      );
    }
    ImageProvider provider = CachedNetworkImageProvider(
      urlStr,
      headers: headers,
    );

    final mw = _memCache(width);
    final mh = _memCache(height);
    if (mw != null || mh != null) {
      provider = ResizeImage(provider, width: mw, height: mh);
    }

    return _NetworkTimedImage(
      provider: provider,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      timeout: networkTimeout!,
      fadeInDuration: fadeInDuration,
      placeholder: placeholder ?? _defaultPlaceholder(),
      error: errorWidget ?? _errorFallback(),
    );
  }
  Widget _wrapProvider(ImageProvider provider) {
    final img = Image(
      image: provider,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
    );
    if (isCircle) return ClipOval(child: img);
    if (borderRadius != null) return ClipRRect(borderRadius: borderRadius!, child: img);
    return img;
  }

  int? _memCache(double? logical) {
    if (logical == null) return null;
    return (logical * 2).round();
  }

  Widget _defaultPlaceholder() => SizedBox(
    width: width,
    height: height,
    child: const Center(child: CircularProgressIndicator(strokeWidth: AppSize.s2)),
  );

  Widget _errorFallback() => SizedBox(
    width: width,
    height: height,
    child: const Center(child: Icon(IconManager.errorImage)),
  );
}

class _NetworkTimedImage extends StatefulWidget {
  const _NetworkTimedImage({
    required this.provider,
    required this.width,
    required this.height,
    required this.fit,
    required this.alignment,
    required this.timeout,
    required this.fadeInDuration,
    required this.placeholder,
    required this.error,
  });

  final ImageProvider provider;
  final double? width;
  final double? height;
  final BoxFit fit;
  final AlignmentGeometry alignment;
  final Duration timeout;
  final Duration fadeInDuration;
  final Widget placeholder;
  final Widget error;

  @override
  State<_NetworkTimedImage> createState() => _NetworkTimedImageState();
}

class _NetworkTimedImageState extends State<_NetworkTimedImage> {
  ImageStream? _stream;
  ImageStreamListener? _listener;
  Timer? _timer;
  bool _loaded = false;
  bool _failed = false;

  void _resolve() {
    _disposeStream();
    _loaded = false;
    _failed = false;

    _stream = widget.provider.resolve(const ImageConfiguration());
    _listener = ImageStreamListener(
          (ImageInfo _, bool __) {
        if (!mounted) return;
        _timer?.cancel();
        setState(() => _loaded = true);
      },
      onError: (Object _, StackTrace? __) {
        if (!mounted) return;
        _timer?.cancel();
        setState(() => _failed = true);
      },
    );
    _stream!.addListener(_listener!);

    _timer = Timer(widget.timeout, () {
      if (!mounted) return;
      if (!_loaded) {
        _stream?.removeListener(_listener!);
        setState(() => _failed = true);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _resolve();
  }

  @override
  void didUpdateWidget(covariant _NetworkTimedImage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.provider != widget.provider ||
        oldWidget.timeout != widget.timeout) {
      _resolve();
    }
  }

  void _disposeStream() {
    _timer?.cancel();
    if (_stream != null && _listener != null) {
      _stream!.removeListener(_listener!);
    }
    _stream = null;
    _listener = null;
  }

  @override
  void dispose() {
    _disposeStream();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_failed) return widget.error;
    if (!_loaded) return widget.placeholder;
    return AnimatedOpacity(
      opacity: 1,
      duration: widget.fadeInDuration,
      child: Image(
        image: widget.provider,
        width: widget.width,
        height: widget.height,
        fit: widget.fit,
        alignment: widget.alignment,
      ),
    );
  }
}