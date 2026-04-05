import 'package:eks_sana_plus_org/src/app/cubit/app_cubit/app_cubit.dart';
import 'package:eks_sana_plus_org/src/app/cubit/app_cubit/app_state.dart';
import 'package:eks_sana_plus_org/src/config/locale_configs.dart';
import 'package:eks_sana_plus_org/src/di/di_setup.dart';
import 'package:eks_sana_plus_org/src/features/authentication/presentation/login/login_page.dart';
import 'package:eks_sana_plus_org/src/shared/theme/cubit/theme_cubit.dart';
import 'package:eks_sana_plus_org/src/shared/theme/cubit/theme_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../routes/app_routing.dart';
import '../shared/theme/app_theme_data.dart';

class MyApp extends StatelessWidget {
  final GoRouter routerConfig;

  const MyApp({
    super.key,
    required this.routerConfig,
  });

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<AppCubit>(),
        ),
        BlocProvider(
          create: (context) {
            var bloc = getIt<ThemeCubit>();
            bloc.getTheme(AppTheme.light);
            return bloc;
          },
        ),
      ],
      child: MaterialApp.router(
        localizationsDelegates: LocaleConfigs.localizationsDelegates,
        locale: const Locale("fa", "IR"),
        supportedLocales: const[
          Locale.fromSubtags(languageCode: 'fa'),
        ],
        debugShowCheckedModeBanner: false,
        title: 'امداد خودرو',
        theme: LightThemeData().materialThemeData,
        routerConfig: routerConfig,
        builder: (context, child) {
          return BlocListener<AppCubit, AppState>(
            listener: (context, state) {
              state.whenOrNull(
                unauthenticated: (_) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    routerConfig.go(LoginPage.path);
                  });
                },
              );
            },
            child: child!,
          );
        },
      ),
    );
  }
}

class NetworkErrorBottomSheet extends StatelessWidget {
  const NetworkErrorBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.wifi_off_rounded,
            size: 56,
            color: colorScheme.error,
          ),
          const SizedBox(height: 16),
          Text(
            'اتصال به اینترنت برقرار نیست',
            style: Theme.of(context).textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'لطفاً اتصال اینترنت خود را بررسی کرده و دوباره تلاش کنید',
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              const Expanded(
                child: OutlinedButton(
                  onPressed: NetworkOverlay.hide,
                  child: Text('بستن'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: FilledButton(
                  onPressed: () {
                    print("yes!!");
                  },
                  child: const Text('تنظیمات اینترنت'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class NetworkOverlay {
  static OverlayEntry? _entry;

  static void show() {
    if (_entry != null) return;

    final navigatorState = Routes.parentNavigatorKey.currentState;
    final overlay = navigatorState?.overlay;

    if (overlay == null) return;

    _entry = OverlayEntry(
      builder: (_) => Container(
          color: Colors.white, child: const NetworkErrorBottomSheet()),
    );

    overlay.insert(_entry!);
  }

  static void hide() {
    _entry?.remove();
    _entry = null;
  }
}
