import 'package:flutter/material.dart';

class SearchAndFilterBox extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onOpenFilter;
  final VoidCallback onRefresh;

  const SearchAndFilterBox({
    super.key,
    required this.isLoading,
    required this.onOpenFilter,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final outline = colorScheme.outline;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: PhysicalModel(
        color: Colors.transparent,
        shadowColor: Colors.black.withAlpha(80),
        elevation: 12,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          color: Colors.transparent,
          child: Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: onOpenFilter,
                  child: AbsorbPointer(
                    absorbing: true,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: TextField(
                        readOnly: true,
                        decoration: InputDecoration(
                          isDense: true,
                          hintText: 'جستجو و فیلتر',
                          filled: true,
                          fillColor: Colors.white,
                          prefixIcon: Icon(
                            Icons.search,
                            size: 22,
                            color: outline,
                          ),
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 10,
                          ),
                          hintStyle: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 14),
              _AnimatedRefreshButton(isLoading: isLoading, onTap: onRefresh),
            ],
          ),
        ),
      ),
    );
  }
}

class _AnimatedRefreshButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onTap;

  const _AnimatedRefreshButton({required this.isLoading, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final outline = Theme.of(context).colorScheme.outline;

    return SizedBox(
      width: 40,
      height: 40,
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        child: InkWell(
          borderRadius: BorderRadius.circular(6),
          onTap: isLoading ? null : onTap,
          child: Center(
            child: AnimatedRotation(
              turns: isLoading ? 1 : 0,
              duration: const Duration(seconds: 1),
              child: Icon(Icons.sync, size: 24, color: outline),
            ),
          ),
        ),
      ),
    );
  }
}
