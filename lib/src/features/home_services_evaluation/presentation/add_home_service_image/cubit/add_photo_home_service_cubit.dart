import 'dart:convert';
import 'dart:io';
import 'package:eks_sana_plus_org/src/common/utils/extensions/iterable_ext.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/evaluation_image_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/entity/last_evaluation_response_entity.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/usecase/fetch_ocr_configuration_use_case.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/domain/usecase/post_evaluation_usecase.dart';

import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/add_home_service_image/cubit/add_photo_home_service_state.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/evaluation_draft.dart';
import 'package:eks_sana_plus_org/src/features/home_services_evaluation/presentation/home_service_evaluation_second_step/cubit/home_service_evaluation_second_step_cubit.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';



@injectable
class AddPhotoHomeServiceCubit extends Cubit<AddPhotoHomeServiceState> {
  final GetPhotosUseCase _getPhotosUseCase;
  final RemovePhotoUseCase  _removePhotoUseCase;
  final AddPhotoUseCase  _addPhotoUseCase;
  final RemoveAllPhotosUseCse _removeAllPhotosUseCse;
  final PostEvaluationUseCase _postEvaluationUseCase;
  final SubmitKilometerImageUseCase _submitKilometerImageUseCase;
  final FetchKilometerImageUseCase _fetchKilometerImageUseCase;
  final RemoveKilometerPhotoUseCase _removeKilometerPhotoUseCase;
  final FetchOcrConfigurationUseCase _fetchOcrConfigurationUseCase;
  final EvaluationDraftStore _draft;
  AddPhotoHomeServiceCubit(
      this._getPhotosUseCase,
      this._removePhotoUseCase,
      this._addPhotoUseCase,
      this._postEvaluationUseCase,
      this._removeAllPhotosUseCse,
      this._removeKilometerPhotoUseCase,
      this._submitKilometerImageUseCase,
      this._fetchKilometerImageUseCase,
      this._fetchOcrConfigurationUseCase,
      this._draft,
      ) : super(const AddPhotoHomeServiceState.idle());

  /// change name
  final BehaviorSubject<List<File?>> _photosController = BehaviorSubject<List<File?>>.seeded([]);
  Stream<List<File?>> get photosStream => _photosController.stream;

  final BehaviorSubject<bool> _validatorSubject = BehaviorSubject<bool>.seeded(false);
  Stream<bool> get validatorSubject => _validatorSubject.stream;

  final BehaviorSubject<File?> _kilometerPhotoController = BehaviorSubject<File?>();
  Stream<File?> get kilometerPhotoStream => _kilometerPhotoController.stream;

  File? get getKilometerPhotoList => _kilometerPhotoController.valueOrNull;

  List<File?> getPhotoList() => _photosController.valueOrNull ?? [];

  int? emdadgarEvaluationPostResultId;
  String? webViewURL;

  Future<void> _loadKilometerPhotos() async {
    emit(const AddPhotoHomeServiceState.loading());
    final result = await _fetchKilometerImageUseCase.call();
    result.whenOrNull(
      success: (data, failures, resultCode) async {
        if (resultCode == 0) {
          _kilometerPhotoController.add(data);
          if(_kilometerPhotoController.valueOrNull?.path.isNotEmpty ?? false) {
            _validatorSubject.add(true);
          } else {
            _validatorSubject.add(false);
          }
          emit(const AddPhotoHomeServiceState.success());
        } else {
          emit(AddPhotoHomeServiceState.error(
              dialogDataModel: DialogDataModel(title: '', description: failures?.listToString() ?? '')));
        }
      },
      failure: (NetworkExceptions error, msg) {
        emit(AddPhotoHomeServiceState.error(
            dialogDataModel: DialogDataModel(title: '', description: msg ?? '')));
      },
    );
  }

  Future<void> submitKilometerPhoto() async {
    emit(const AddPhotoHomeServiceState.loading());
    final result = await _submitKilometerImageUseCase.call();
    result.whenOrNull(
      success: (data, failures, resultCode) async {
        if (resultCode == 0) {
          _loadKilometerPhotos();
        } else {
          emit(AddPhotoHomeServiceState.error(
              dialogDataModel: DialogDataModel(title: '', description: failures?.listToString() ?? '')));
        }
      },
      failure: (NetworkExceptions error, msg) {
        emit(AddPhotoHomeServiceState.error(
            dialogDataModel: DialogDataModel(title: '', description: msg ?? '')));
      },
    );
  }

  Future<void> removeKilometerPhoto() async{
    emit(const AddPhotoHomeServiceState.loading());
    final result = await _removeKilometerPhotoUseCase.call();
    result.whenOrNull(
      success: (data, failures, resultCode) async {
        if (resultCode == 0) {
          _loadKilometerPhotos();
        } else {
          emit(AddPhotoHomeServiceState.error(
              dialogDataModel: DialogDataModel(title: '', description: failures?.listToString() ?? '')));
        }
      },
      failure: (NetworkExceptions error, msg) {
        emit(AddPhotoHomeServiceState.error(
            dialogDataModel: DialogDataModel(title: '', description: msg ?? '')));
      },
    );
  }

  Future<File> preprocessImage(File file) async {
    final bytes = await file.readAsBytes();
    final img.Image? originalImage = img.decodeImage(bytes);
    if (originalImage == null) return file;
    final grayscaleImage = img.grayscale(originalImage);
    final resizedImage = img.copyResize(grayscaleImage, width: 600);
    final processedBytes = img.encodeJpg(resizedImage, quality: 85);

    final processedFile = File('${file.parent.path}/processed_kilometer.jpg');
    return await processedFile.writeAsBytes(processedBytes);
  }

  String? extractNumberFromText(String text) {
    final numberRegExp = RegExp(r'\d[\d\s]{3,10}');
    final matches = numberRegExp.allMatches(text);

    int maxNumber = 0;
    for (final match in matches) {
      String raw = match.group(0)?.replaceAll(' ', '') ?? '';
      if (raw.length >= 4 && raw.length <= 6) {
        final numValue = int.tryParse(raw);
        if (numValue != null && numValue > maxNumber) {
          maxNumber = numValue;
        }
      }
    }

    if (maxNumber > 0) {
      return maxNumber.toString().padLeft(6, '0'); // مثلاً 91308 → 091308
    }
    return null;
  }

  Future<void> extractKilometerFromImage() async {
    final originalFile = _kilometerPhotoController.valueOrNull;
    if (originalFile == null || !await originalFile.exists()) return;

    final preprocessedFile = await preprocessImage(originalFile);
    final inputImage = InputImage.fromFile(preprocessedFile);
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
    final RecognizedText recognizedText = await textRecognizer.processImage(inputImage);
    final rawText = recognizedText.text;
    final kilometerString = extractNumberFromText(rawText);
    if (kilometerString != null) {
      final km = int.tryParse(kilometerString);
      _draft.updateKilometer(km: km, isValid: true);
    } else {
      _draft.updateKilometer(isValid: false);
    }
    textRecognizer.close();
  }

  Future<void> addImageKilometerToEvaluation() async{
    final kilometerImage = _kilometerPhotoController.value;
    final base64String = await fileToBase64WithMime(kilometerImage);
    final existingImageIndex = HomeServiceEvaluationSecondStepCubit.evaluationKilometerImageList?.indexWhere(
          (image) => image.type == 2,
    );
    if (existingImageIndex != -1) {
      HomeServiceEvaluationSecondStepCubit.evaluationKilometerImageList?[existingImageIndex!] = EvaluationImageEntity(
        imageBase64: base64String,
        type: 2,
      );
    } else {
      HomeServiceEvaluationSecondStepCubit.evaluationKilometerImageList?.add(
        EvaluationImageEntity(
          imageBase64: base64String,
          type: 2,
        ),
      );
    }
    HomeServiceEvaluationSecondStepCubit.evaluationKilometerImageList?.add(
      EvaluationImageEntity(
        imageBase64: base64String,
        type: 2
      ),
    );
  }

  Future<void> _loadPhotos() async {
    emit(const AddPhotoHomeServiceState.loading());
    final result = await _getPhotosUseCase.call();
    result.whenOrNull(
      success: (data, failures, resultCode) async {
        if (resultCode == 0) {
          _photosController.add(data);
          if(_photosController.valueOrNull?.isNotEmpty ?? false) {
            _validatorSubject.add(true);
          } else {
            _validatorSubject.add(false);
          }
          emit(const AddPhotoHomeServiceState.success());
        } else {
          emit(AddPhotoHomeServiceState.error(
              dialogDataModel: DialogDataModel(title: '', description: failures?.listToString() ?? '')));
        }
      },
      failure: (NetworkExceptions error, msg) {
        emit(AddPhotoHomeServiceState.error(
            dialogDataModel: DialogDataModel(title: '', description: msg ?? '')));
      },
    );
  }

  Future<void> addPhoto() async {
    emit(const AddPhotoHomeServiceState.loading());
    final result = await _addPhotoUseCase.call();
    result.whenOrNull(
      success: (data, failures, resultCode) async {
        if (resultCode == 0) {
          _loadPhotos();
        } else {
          emit(AddPhotoHomeServiceState.error(
              dialogDataModel: DialogDataModel(title: '', description: failures?.listToString() ?? '')));
        }
      },
      failure: (NetworkExceptions error, msg) {
        emit(AddPhotoHomeServiceState.error(
            dialogDataModel: DialogDataModel(title: '', description: msg ?? '')));
      },
    );
  }

  Future<void> removePhoto(File photo) async{
    emit(const AddPhotoHomeServiceState.loading());
    final result = await _removePhotoUseCase.call(photo);
    result.whenOrNull(
      success: (data, failures, resultCode) async {
        if (resultCode == 0) {
          _loadPhotos();
        } else {
          emit(AddPhotoHomeServiceState.error(
              dialogDataModel: DialogDataModel(title: '', description: failures?.listToString() ?? '')));
        }
      },
      failure: (NetworkExceptions error, msg) {
        emit(AddPhotoHomeServiceState.error(
            dialogDataModel: DialogDataModel(title: '', description: msg ?? '')));
      },
    );
  }

  Future<void> clearPhoto() async{
    emit(const AddPhotoHomeServiceState.loading());
    final result = await _removeAllPhotosUseCse.call();
    result.whenOrNull(
      success: (data, failures, resultCode) async {
        if (resultCode == 0) {
          emit(const AddPhotoHomeServiceState.success());
        } else {
          emit(AddPhotoHomeServiceState.error(
              dialogDataModel: DialogDataModel(title: '', description: failures?.listToString() ?? '')));
        }
      },
      failure: (NetworkExceptions error, msg) {
        emit(AddPhotoHomeServiceState.error(
            dialogDataModel: DialogDataModel(title: '', description: msg ?? '')));
      },
    );
  }

  Future<void> callEmdadgarEvaluation({LastEvaluationEntity? lastEvaluationEntity}) async {
    emit(const AddPhotoHomeServiceState.submitLoading());
    await convertAndAddImages(lastEvaluationEntity: lastEvaluationEntity);
    final result = await _postEvaluationUseCase.call(lastEvaluationEntity);
    result.whenOrNull(
      success: (data, failures, resultCode) async {
        if (resultCode == 0) {
          emdadgarEvaluationPostResultId = data?.id;
          emit(const AddPhotoHomeServiceState.submitSuccess());
        } else if (resultCode == 5) {
          emit(AddPhotoHomeServiceState.evaluation(
              dialogDataModel: DialogDataModel(
                  title: '', description: failures?.listToString() ?? '')));
        } else {
          emit(AddPhotoHomeServiceState.error(
              dialogDataModel: DialogDataModel(
                  title: '', description: failures?.listToString() ?? '')));
        }
      },
      failure: (NetworkExceptions error, msg) {
        emit(AddPhotoHomeServiceState.error(dialogDataModel: DialogDataModel(title: '', description: msg ?? '')));
      },
    );
  }

  Future<String?> fileToBase64WithMime(File? file) async {
    if (file == null) return null;
    try {
      final bytes = await file.readAsBytes();
      const mimeType = 'image/jpeg';
      final base64String = base64Encode(bytes);
      return 'data:$mimeType;base64,$base64String';
    } catch (e) {
      debugPrint('Error converting file to base64: $e');
      return null;
    }
  }

  Future<void> convertAndAddImages({LastEvaluationEntity? lastEvaluationEntity}) async {
    final files = _photosController.value;
    lastEvaluationEntity?.images ??= [];
    lastEvaluationEntity?.images?.removeWhere((image) => image.type == 1);
    for (final file in files) {
      final base64String = await fileToBase64WithMime(file);
      if (base64String != null) {
        lastEvaluationEntity?.images?.add(EvaluationImageEntity(imageBase64: base64String, type: 1));
      }
    }
  }

  @override
  Future<void> close() {
    _photosController.close();
    _validatorSubject.close();
    return super.close();
  }
}
