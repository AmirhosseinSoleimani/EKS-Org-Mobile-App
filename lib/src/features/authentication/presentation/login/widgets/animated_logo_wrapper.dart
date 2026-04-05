import 'package:eks_sana_plus_org/src/features/authentication/presentation/login/cubit/login_cubit.dart';
import 'package:eks_sana_plus_org/src/shared/resources/value_manager.dart';
import 'package:eks_sana_plus_org/src/shared/widgets/logo_widget/logo_widget.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AnimatedLogoWrapper extends StatelessWidget {
  const AnimatedLogoWrapper({super.key});

  static const _moveDuration = Duration(milliseconds: 600);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LoginCubit>();
    final screenHeight = MediaQuery.of(context).size.height;
    final startY = (screenHeight / 2) - 50;
    return RepaintBoundary(
      child: const LogoWidget().animate(
        autoPlay: true,
        onComplete: (_) => cubit.onLogoAnimationFinished(),
      ).move(
        duration: _moveDuration,
        begin: Offset(0, startY),
        end: const Offset(0, AppPadding.p38),
      ),
    );
  }
}
