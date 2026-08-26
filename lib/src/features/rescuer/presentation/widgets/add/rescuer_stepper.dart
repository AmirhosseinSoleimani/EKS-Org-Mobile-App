import 'package:eks_sana_plus_org/src/shared/widgets/text_widgets/body_small_text.dart';
import 'package:flutter/material.dart';

class RescuerStepper extends StatelessWidget {
  final int current;

  const RescuerStepper({super.key, required this.current});

  static const titles = ['اطلاعات هویتی', 'تماس', 'همکاری', 'مدارک'];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        4,
        (index) => Expanded(
          child: Column(
            children: [
              SizedBox(
                height: 40,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 2,
                            color: index > 0
                                ? index <= current
                                      ? const Color(0xFF00A878)
                                      : Colors.grey.shade300
                                : Colors.transparent,
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 2,
                            color: index < 3
                                ? index < current
                                      ? const Color(0xFF00A878)
                                      : Colors.grey.shade300
                                : Colors.transparent,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: index == current
                            ? Theme.of(context).colorScheme.primary
                            : Colors.white,
                        border: Border.all(
                          color: index < current
                              ? const Color(0xFF00A878)
                              : index == current
                              ? Theme.of(context).colorScheme.primary
                              : Colors.grey.shade300,
                          width: 2,
                        ),
                      ),
                      child: Center(
                        child: index < current
                            ? const Icon(
                                Icons.check,
                                color: Color(0xFF00A878),
                              )
                            : BodySmallText(
                                text: '${index + 1}',
                                color: index == current
                                    ? Colors.white
                                    : Colors.grey,
                                fontWeight: FontWeight.w700,
                              ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 6),
              BodySmallText(
                text: titles[index],
                color: index < current
                    ? const Color(0xFF00A878)
                    : index == current
                    ? Theme.of(context).colorScheme.primary
                    : Colors.grey,
                fontSize: 12,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
