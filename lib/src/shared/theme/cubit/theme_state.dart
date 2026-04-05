import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'theme_state.freezed.dart';

enum AppTheme { light, dark, system }

@freezed
class ThemeState with _$ThemeState {
  const factory ThemeState.loading() = ThemeLoadingState;

  const factory ThemeState.error({required String errorMessage}) = ThemeErrorState;

  const factory ThemeState.success({required AppTheme appTheme, required IconData icon}) = ThemeSuccessState;
}