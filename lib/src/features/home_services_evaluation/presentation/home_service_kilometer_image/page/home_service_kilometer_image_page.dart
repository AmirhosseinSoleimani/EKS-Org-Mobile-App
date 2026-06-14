import 'dart:io';
import 'package:camera/camera.dart';
import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/home_service_kilometer_image/cubit/home_service_kilometer_image_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:math';
import 'dart:ui';
import 'kilometer_preview_page.dart';


class HomeServiceKilometerImagePage extends StatefulWidget {
  const HomeServiceKilometerImagePage({Key? key}) : super(key: key);

  @override
  State<HomeServiceKilometerImagePage> createState() => _HomeServiceKilometerImagePageState();
}

class _HomeServiceKilometerImagePageState extends State<HomeServiceKilometerImagePage> {
  CameraController? _controller;
  Future<void>? _initFuture;

  Size? _lastScreenSize;
  Rect? _lastHoleRect;
  double _minZoom = 1.0, _maxZoom = 1.0, _currentZoom = 1.0, _baseZoom = 1.0;
  double _scrollAccum = 0.0;
  bool _zoomReady = false;
  int _scaleStartPointerCount = 0;
  static const double _scrollPixelsForFullRange = 280.0;

  @override
  void initState() {
    super.initState();
    _initFuture = _initCamera();
  }

  Future<void> _initCamera() async {
    final cams = await availableCameras();
    final back = cams.firstWhere(
          (c) => c.lensDirection == CameraLensDirection.back,
      orElse: () => cams.first,
    );
    _controller = CameraController(
      back, ResolutionPreset.high,
      enableAudio: false, imageFormatGroup: ImageFormatGroup.jpeg,
    );
    await _controller!.initialize();
    try {
      _minZoom = await _controller!.getMinZoomLevel();
      _maxZoom = await _controller!.getMaxZoomLevel();
      _currentZoom = _minZoom;
      await _controller!.setZoomLevel(_currentZoom);
      _zoomReady = true;
    } catch (e) {
      debugPrint('ZOOM INIT error: $e');
      _zoomReady = false;
    }
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Future<void> _openPreview(BuildContext ctx, KilometerCapture cap) async {
    try {
      final bool? ok = await Navigator.of(ctx).push<bool>(
        MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: ctx.read<HomeServiceKilometerImageCubit>(),
            child: KilometerPreviewPage(capture: cap),
          ),
        ),
      );

      if (ok == true && mounted) {
        Navigator.pop(ctx, true);
      }
    } catch (e) {
      debugPrint('OPEN_PREVIEW error: $e');
      if (mounted) {
        ScaffoldMessenger.of(ctx).showSnackBar(
          const SnackBar(content: Text('باز کردن پیش‌نمایش با خطا مواجه شد')),
        );
      }
    }
  }

  Future<void> _capture(BuildContext ctx) async {
    final c = _controller;
    if (c == null || !c.value.isInitialized || c.value.isTakingPicture) return;

    try {
      final shot = await c.takePicture();
      if (!mounted) return;

      final cubit = ctx.read<HomeServiceKilometerImageCubit>();
      final hole = _lastHoleRect;
      final size = _lastScreenSize;

      if (hole == null || size == null) {
        await _openPreview(ctx, KilometerCapture(full: File(shot.path), crop: File(shot.path)));
        return;
      }
      KilometerCapture cap;
      try {
        cap = await cubit.cropShot(
          shot: shot,
          holeRectOnScreen: hole,
          screenSize: size,
          cameraValue: c.value,
        );
      } catch (e) {
        debugPrint('CROP error: $e');
        cap = KilometerCapture(full: File(shot.path), crop: File(shot.path));
      }

      await _openPreview(ctx, cap);
    } catch (e) {
      debugPrint('CAPTURE error: $e');
      if (mounted) {
        ScaffoldMessenger.of(ctx).showSnackBar(
          const SnackBar(content: Text('گرفتن تصویر با خطا مواجه شد')),
        );
      }
    }
  }

  Future<void> _setZoom(double z) async {
    final c = _controller;
    if (c == null || !c.value.isInitialized) return;
    final clamped = z.clamp(_minZoom, _maxZoom);
    if ((clamped - _currentZoom).abs() < 0.01) return;
    _currentZoom = clamped;
    try {
      await c.setZoomLevel(_currentZoom);
    } catch (e) {
      debugPrint('SET_ZOOM error: $e');
    }
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeServiceKilometerImageCubit>(
      create: (_) => getIt<HomeServiceKilometerImageCubit>(),
      child: Builder(
        builder: (innerCtx) {
          return Scaffold(
            backgroundColor: Colors.black,
            body: FutureBuilder<void>(
              future: _initFuture,
              builder: (innerCtx, snap) {
                if (snap.connectionState != ConnectionState.done) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (_controller == null || !_controller!.value.isInitialized) {
                  return const Center(child: Text('دوربین در دسترس نیست', style: TextStyle(color: Colors.white)));
                }

                return LayoutBuilder(
                  builder: (innerCtx, constraints) {
                    final size = constraints.biggest;
                    final center = Offset(size.width / 2, size.height / 2 - 20);
                    final base = min(size.width, size.height);
                    const widthScale = 0.8;
                    const heightScale = 0.2;
                    final holeWidth  = (base * widthScale).clamp(0.0, size.width);
                    final holeHeight = (base * heightScale).clamp(0.0, size.height);
                    final holeRect = Rect.fromCenter(center: center, width: holeWidth, height: holeHeight);
                    _lastScreenSize = size;
                    _lastHoleRect   = holeRect;

                    return Stack(
                      children: [
                        Positioned.fill(
                          child: GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onScaleStart: _zoomReady ? (details) {
                              _baseZoom = _currentZoom;
                              _scrollAccum = 0.0;
                              try { _scaleStartPointerCount = details.pointerCount; } catch (_) { _scaleStartPointerCount = 2; }
                            } : null,
                            onScaleUpdate: _zoomReady ? (details) {
                              if ((details.scale - 1.0).abs() >= 0.01) {
                                final target = _baseZoom * details.scale;
                                _setZoom(target);
                                return;
                              }
                              if (_scaleStartPointerCount >= 2) {
                                _scrollAccum += -details.focalPointDelta.dy;
                                final range = (_maxZoom - _minZoom);
                                final delta = (_scrollAccum / _scrollPixelsForFullRange) * range;
                                final target = _baseZoom + delta;
                                _setZoom(target);
                              }
                            } : null,
                            onDoubleTap: _zoomReady ? () {
                              final quick = _maxZoom >= 2.0 ? 2.0 : _maxZoom;
                              final target = (_currentZoom <= (_minZoom + 0.1)) ? quick : _minZoom;
                              _setZoom(target);
                            } : null,
                            child: FittedBox(
                              fit: BoxFit.cover,
                              child: SizedBox(
                                width: _controller!.value.previewSize!.height,
                                height: _controller!.value.previewSize!.width,
                                child: CameraPreview(_controller!),
                              ),
                            ),
                          ),
                        ),
                        Positioned.fill(
                          child: IgnorePointer(
                            child: ClipPath(
                              clipper: _HoleClipper(holeRect, radius: 16),
                              child: BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
                                child: Container(color: Colors.black.withOpacity(0.25)),
                              ),
                            ),
                          ),
                        ),
                        Positioned.fromRect(
                          rect: holeRect,
                          child: IgnorePointer(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(color: Colors.white, width: 2),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: holeRect.bottom + 20,
                          left: 24, right: 24,
                          child: const Text(
                            'کادر را روی نمایشگر کیلومتر قرار دهید',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white, fontSize: 14, height: 1.4),
                          ),
                        ),
                        Positioned(
                          bottom: 32, left: 0, right: 0,
                          child: Center(
                            child: GestureDetector(
                              onTap: () => _capture(innerCtx),
                              child: Container(
                                width: 74, height: 74,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.white, width: 4),
                                ),
                                child: const Center(
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                                    child: SizedBox(width: 56, height: 56),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: MediaQuery.of(context).padding.top + 8,
                          left: 8,
                          child: IconButton(
                            icon: const Icon(Icons.close, color: Colors.white),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          );
        }
      ),
    );
  }
}

class _HoleClipper extends CustomClipper<Path> {
  _HoleClipper(this.holeRect, {this.radius = 12});
  final Rect holeRect;
  final double radius;

  @override
  Path getClip(Size size) {
    final outer = Path()..addRect(Offset.zero & size);
    final inner = Path()..addRRect(RRect.fromRectAndRadius(holeRect, Radius.circular(radius)));
    return Path.combine(PathOperation.difference, outer, inner);
  }

  @override
  bool shouldReclip(covariant _HoleClipper old) =>
      old.holeRect != holeRect || old.radius != radius;
}