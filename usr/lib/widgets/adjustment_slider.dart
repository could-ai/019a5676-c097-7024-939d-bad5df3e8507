import 'package:flutter/material.dart';

class AdjustmentSlider extends StatelessWidget {
  final String label;
  final double value;
  final IconData icon;
  final ValueChanged<double> onChanged;

  const AdjustmentSlider({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: Theme.of(context).colorScheme.primary,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.grey[800],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  value.toStringAsFixed(1),
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          SliderTheme(
            data: SliderThemeData(
              activeTrackColor: Theme.of(context).colorScheme.primary,
              inactiveTrackColor: Colors.grey[800],
              thumbColor: Theme.of(context).colorScheme.primary,
              overlayColor: Theme.of(context).colorScheme.primary.withOpacity(0.2),
              trackHeight: 4,
            ),
            child: Slider(
              value: value,
              min: -100,
              max: 100,
              divisions: 200,
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }
}