import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

class EvaluationDraft {
  final int? customerKilometer;
  final bool? isKilometerValid;
  final File? kilometerPhoto;

  const EvaluationDraft({
    this.customerKilometer,
    this.isKilometerValid,
    this.kilometerPhoto,
  });

  EvaluationDraft copyWith({
    int? customerKilometer,
    bool? isKilometerValid,
    File? kilometerPhoto,
  }) => EvaluationDraft(
    customerKilometer: customerKilometer ?? this.customerKilometer,
    isKilometerValid: isKilometerValid ?? this.isKilometerValid,
    kilometerPhoto: kilometerPhoto ?? this.kilometerPhoto,
  );
}

@lazySingleton
class EvaluationDraftStore {
  final _subject = BehaviorSubject<EvaluationDraft>.seeded(const EvaluationDraft());

  Stream<EvaluationDraft> get stream => _subject.stream;
  EvaluationDraft get value => _subject.value;

  void updateKilometer({int? km, bool? isValid}) {
    _subject.add(value.copyWith(
      customerKilometer: km ?? value.customerKilometer,
      isKilometerValid: isValid ?? value.isKilometerValid,
    ));
  }

  void updateKilometerPhoto(File? file) {
    _subject.add(value.copyWith(kilometerPhoto: file));
  }

  void clear() => _subject.add(const EvaluationDraft());

  void dispose() => _subject.close();
}