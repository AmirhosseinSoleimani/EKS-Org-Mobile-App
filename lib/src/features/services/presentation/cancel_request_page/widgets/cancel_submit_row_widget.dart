import 'package:eks_sana_plus_org/src/features/services/presentation/cancel_request_page/cubit/cancel_request_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CancelSubmitRowWidget extends StatelessWidget {
  final VoidCallback onSubmit;
  final VoidCallback onCancel;

  const CancelSubmitRowWidget({
    super.key,
    required this.onSubmit,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return BlocSelector<CancelRequestCubit, CancelRequestState, bool>(
      selector: (state) =>
          state.maybeWhen(submitLoading: () => true, orElse: () => false),
      builder: (context, isSubmitting) {
        return Row(
          children: [
            Expanded(
              flex: 60,
              child: InkWell(
                onTap: isSubmitting ? null : onSubmit,
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  height: 48,
                  decoration: BoxDecoration(
                    color: isSubmitting
                        ? Colors.grey.shade300
                        : Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.center,
                  child: isSubmitting
                      ? const SizedBox(
                          height: 22,
                          width: 22,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation(Colors.white),
                          ),
                        )
                      : const Text(
                          'لغو درخواست',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              flex: 40,
              child: TextButton(
                onPressed: onCancel,
                style: TextButton.styleFrom(
                  foregroundColor: Colors.grey.shade600,
                  backgroundColor: Colors.transparent,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text(
                  'انصراف',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
