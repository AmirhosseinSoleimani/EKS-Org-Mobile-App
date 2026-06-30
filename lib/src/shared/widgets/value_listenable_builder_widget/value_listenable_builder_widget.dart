import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ValueListenableBuilder2<A, B> extends StatelessWidget {
  const ValueListenableBuilder2({
    super.key,
    required this.first,
    required this.second,
    required this.builder,
  });

  final ValueListenable<A> first;
  final ValueListenable<B> second;
  final Widget Function(BuildContext context, A value1, B value2, Widget? child)
  builder;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<A>(
      valueListenable: first,
      builder: (context, value1, _) {
        return ValueListenableBuilder<B>(
          valueListenable: second,
          builder: (context, value2, _) {
            return builder(context, value1, value2, null);
          },
        );
      },
    );
  }
}