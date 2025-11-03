import 'package:flutter/material.dart';
import '../theme/anatomy_colors.dart';

class GradientCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;
  final String label;

  const GradientCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            gradient: value
                ? const LinearGradient(
              colors: [AnatomyColors.primaryPurple, AnatomyColors.lightPurple],
            )
                : null,
            color: value ? null : Colors.transparent,
            border: Border.all(
              color: value ? Colors.transparent : Colors.white38,
              width: 2,
            ),
          ),
          child: Checkbox(
            value: value,
            onChanged: onChanged,
            activeColor: Colors.transparent,
            checkColor: Colors.white,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            visualDensity: VisualDensity.compact,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Text(
          label,
          style: const TextStyle(color: Colors.white70),
        ),
      ],
    );
  }
}