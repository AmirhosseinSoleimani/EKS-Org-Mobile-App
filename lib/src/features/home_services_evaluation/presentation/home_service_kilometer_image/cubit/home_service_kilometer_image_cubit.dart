import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:async';
import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:eks_sana_plus_org/src/common/utils/extensions/iterable_ext.dart';
import 'package:eks_sana_plus_org/src/core/uikit/dialog/dialog_data_model.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/evaluation_image_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/kilometer_from_image_request_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/usecase/fetch_kilometer_from_image_use_case.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/evaluation_draft.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import '../../home_service_evaluation_second_step/cubit/home_service_evaluation_second_step_cubit.dart';
import 'home_service_kilometer_image_state.dart';
import 'package:image/image.dart' as img;


class KilometerCapture {
  final File full;
  final File crop;
  KilometerCapture({required this.full, required this.crop});
}

@injectable
class HomeServiceKilometerImageCubit extends Cubit<HomeServiceKilometerImageState> {
  final FetchKilometerFromImageUseCase _submitKilometerImageUseCase;
  final EvaluationDraftStore _draft;

  HomeServiceKilometerImageCubit(
      this._submitKilometerImageUseCase,
      this._draft,
      ) : super(const HomeServiceKilometerImageState.idle());

  final BehaviorSubject<KilometerCapture?> _kmCapture$ =
  BehaviorSubject<KilometerCapture?>.seeded(null);
  Stream<KilometerCapture?> get kilometerPhotoStream => _kmCapture$.stream.distinct();
  KilometerCapture? get kilometerPhoto => _kmCapture$.valueOrNull;

  void setKilometerCapture(KilometerCapture cap) {
    _kmCapture$.add(cap);
    emit(const HomeServiceKilometerImageState.success());
  }

  void clearCapture() {
    _kmCapture$.add(null);
    emit(const HomeServiceKilometerImageState.idle());
  }

  Future<String?> _toBase64DataUri({File? file, Uint8List? bytes, String mime = 'image/jpeg'}) async {
    try {
      final data = bytes ?? await file?.readAsBytes();
      if (data == null) return null;
      return 'data:$mime;base64,${base64Encode(data)}';
    } catch (_) {
      return null;
    }
  }

  Future<Uint8List?> _prepareImageForUpload(
      File file, {
        int maxDimension = 1280,
        int maxBytes = 300 * 1024,
        int initialQuality = 85,
        int minQuality = 40,
        int qualityStep = 10,
      }) async {
    try {
      final bytes = await file.readAsBytes();
      final decoded = img.decodeImage(bytes);
      if (decoded == null) return null;
      img.Image image = img.bakeOrientation(decoded);
      final w = image.width, h = image.height;
      final longSide = w > h ? w : h;
      if (longSide > maxDimension) {
        if (w >= h) {
          image = img.copyResize(image, width: maxDimension);
        } else {
          image = img.copyResize(image, height: maxDimension);
        }
      }
      int q = initialQuality;
      Uint8List out = Uint8List.fromList(img.encodeJpg(image, quality: q));

      while (out.lengthInBytes > maxBytes && q > minQuality) {
        q -= qualityStep;
        out = Uint8List.fromList(img.encodeJpg(image, quality: q));
      }
      return out;
    } catch (_) {
      return null;
    }
  }

  Future<void> submitToBackend({required KilometerCapture capture, bool useCrop = true}) async {
    emit(const HomeServiceKilometerImageState.submitLoading());
    try {
      File fileToSend;
      try {
        final cropExists = await capture.crop.exists();
        fileToSend = (useCrop && cropExists) ? capture.crop : capture.full;
      } catch (_) {
        fileToSend = capture.full;
      }
      final optimizedBytes = await _prepareImageForUpload(
        fileToSend,
        maxDimension: 1280,
        maxBytes: 300 * 1024,
        initialQuality: 85,
        minQuality: 40,
        qualityStep: 10,
      );
      if (optimizedBytes == null) {
        emit(HomeServiceKilometerImageState.error(
          dialogDataModel: DialogDataModel(title: '', description: 'خطا در پردازش تصویر'),
        ));
        return;
      }
      final b64 = await _toBase64DataUri(bytes: optimizedBytes);
      final res = await _submitKilometerImageUseCase.call(
        KilometerFromImageRequestEntity(imageBase64: b64),
      );
      res.whenOrNull(
        success: (data, failures, code) async {
          if (code == 0) {
            try {
              final km = data?.kilometer;
              if (km != null) {
                _draft.updateKilometer(km: km, isValid: true);
              }
            } catch (_) {}
            _draft.updateKilometerPhoto(useCrop ? capture.crop : capture.full);
            _kmCapture$.add(capture);
            emit(const HomeServiceKilometerImageState.submitSuccess());
          } else {
            emit(HomeServiceKilometerImageState.error(
              dialogDataModel: DialogDataModel(title: '', description: failures?.listToString() ?? 'ارسال تصویر ناموفق بود'),
            ));
          }
        },
        failure: (e, msg) {
          emit(HomeServiceKilometerImageState.error(
            dialogDataModel: DialogDataModel(title: '', description: msg ?? 'خطای شبکه هنگام ارسال تصویر'),
          ));
        },
      );
    } catch (_) {
      emit(HomeServiceKilometerImageState.error(
        dialogDataModel: DialogDataModel(title: '', description: 'خطای غیرمنتظره در ارسال تصویر'),
      ));
    }
  }

  Future<KilometerCapture> cropShot({
    required XFile shot,
    required Rect holeRectOnScreen,
    required Size screenSize,
    required CameraValue cameraValue,
  }) async {
    emit(const HomeServiceKilometerImageState.loading());

    final fullFile = File(shot.path);

    final pv = cameraValue.previewSize!;
    final texW = pv.height; // به‌خاطر FittedBox/rotation
    final texH = pv.width;

    final scale = max(screenSize.width / texW, screenSize.height / texH);
    final dispW = texW * scale;
    final dispH = texH * scale;
    final dx = (screenSize.width - dispW) / 2;
    final dy = (screenSize.height - dispH) / 2;

    final holeTx = (holeRectOnScreen.left - dx) / scale;
    final holeTy = (holeRectOnScreen.top  - dy) / scale;
    final holeTw = holeRectOnScreen.width  / scale;
    final holeTh = holeRectOnScreen.height / scale;

    final nx = holeTx / texW;
    final ny = holeTy / texH;
    final nw = holeTw / texW;
    final nh = holeTh / texH;

    try {
      final bytes = await fullFile.readAsBytes();
      final original = img.decodeImage(bytes);
      if (original == null) {
        emit(const HomeServiceKilometerImageState.success());
        return KilometerCapture(full: fullFile, crop: fullFile);
      }

      final imgW = original.width;
      final imgH = original.height;

      int cx = (nx * imgW).round().clamp(0, max(0, imgW - 1));
      int cy = (ny * imgH).round().clamp(0, max(0, imgH - 1));
      int cw = (nw * imgW).round().clamp(1, imgW - cx);
      int ch = (nh * imgH).round().clamp(1, imgH - cy);

      final cropped = img.copyCrop(original, x: cx, y: cy, width: cw, height: ch);
      final croppedPath =
          '${fullFile.parent.path}/km_crop_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final cropFile =
      await File(croppedPath).writeAsBytes(img.encodeJpg(cropped, quality: 90));

      emit(const HomeServiceKilometerImageState.success());
      return KilometerCapture(full: fullFile, crop: cropFile);
    } catch (_) {
      emit(HomeServiceKilometerImageState.error(
        dialogDataModel: DialogDataModel(title: '', description: 'خطا در پردازش تصویر'),
      ));
      return KilometerCapture(full: fullFile, crop: fullFile);
    }
  }

  Future<String?> fileToBase64WithMime(
      File? file, {
        String mime = 'image/jpeg',
        bool withDataPrefix = true,
      }) async {
    if (file == null) return null;
    try {
      final bytes = await file.readAsBytes();
      final b64 = base64Encode(bytes);
      return withDataPrefix ? 'data:$mime;base64,$b64' : b64;
    } catch (e) {
      debugPrint('fileToBase64WithMime error: $e');
      return null;
    }
  }

  Future<void> addImageKilometerToEvaluation({required File fullImage}) async{
    final base64String = await fileToBase64WithMime(fullImage);
    if (base64String == null || base64String.isEmpty) return;
    final list = HomeServiceEvaluationSecondStepCubit.evaluationKilometerImageList ??= <EvaluationImageEntity>[];
    list.removeWhere((img) => img.type == 2);
    list.add(
      EvaluationImageEntity(
        imageBase64: base64String,
        type: 2,
      ),
    );
  }

  @override
  Future<void> close() async {
    await _kmCapture$.close();
    return super.close();
  }
}