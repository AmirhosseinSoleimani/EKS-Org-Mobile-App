
import 'package:eks_sana_plus_org/src/shared/resources/assets_manager.dart';
import 'package:eks_sana_plus_org/src/shared/theme/app_theme_data.dart';
import 'package:eks_sana_plus_org/src/shared/theme/cubit/theme_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';


@injectable
class ThemeCubit extends Cubit<ThemeState> {

  ThemeCubit() : super(const ThemeState.loading()) {
    _initializeTheme();
  }

  Future<void> _initializeTheme() async{
    try {
      final systemTheme = await _getSystemTheme();
      final icon = _getIcon(systemTheme);
      emit(ThemeState.success(appTheme: systemTheme, icon: icon));
    } catch(e) {
      emit(ThemeState.error(errorMessage: e.toString()));
    }
  }

  Future<void> toggleTheme(AppTheme newTheme) async {
    emit(const ThemeState.loading());
    try {
      final icon = _getIcon(newTheme);
      emit(ThemeState.success(appTheme: newTheme, icon: icon));
    } catch (e) {
      emit(ThemeState.error(errorMessage: e.toString()));
    }
  }

  Future<AppTheme> _getSystemTheme() async{
    final brightness = WidgetsBinding.instance.platformDispatcher.platformBrightness;
    return brightness == Brightness.dark ? AppTheme.dark : AppTheme.light;
  }

  IconData _getIcon(AppTheme appTheme) {
    switch (appTheme) {
      case AppTheme.dark:
        return  Icons.dark_mode;
      case AppTheme.light:
        return Icons.sunny;
      case AppTheme.system:
      return Icons.sunny;
    }
  }

  ThemeData getTheme(AppTheme appTheme) {
    final lightTheme = LightThemeData().materialThemeData;
    return lightTheme;
  }
}