import 'package:ecommerce/core/const/app_color.dart';
import 'package:flutter/material.dart';


class CategoryChips extends StatelessWidget {
  final Map<int, String> categories;
  final int? selectedId;
  final ValueChanged<int?> onSelected;

  const CategoryChips({
    super.key,
    required this.categories,
    required this.selectedId,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 46,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          _Chip(
            label: 'All',
            selected: selectedId == null,
            onTap: () => onSelected(null),
          ),
          ...categories.entries.map(
            (e) => _Chip(
              label: e.value,
              selected: selectedId == e.key,
              onTap: () => onSelected(e.key),
            ),
          ),
        ],
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _Chip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          padding: const EdgeInsets.symmetric(horizontal: 22),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            gradient: selected
                ? const LinearGradient(
                    colors: [AppColors.pink, AppColors.pinkDark],
                  )
                : null,
            color: selected ? null : AppColors.white,
            borderRadius: BorderRadius.circular(23),
            border: Border.all(
              color: selected
                  ? Colors.transparent
                  : AppColors.beigeDark.withValues(alpha: 0.7),
            ),
            boxShadow: selected
                ? [
                    BoxShadow(
                      color: AppColors.pinkDark.withValues(alpha: 0.35),
                      blurRadius: 12,
                      offset: const Offset(0, 5),
                    ),
                  ]
                : null,
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: selected ? AppColors.white : AppColors.textDark,
            ),
          ),
        ),
      ),
    );
  }
}
