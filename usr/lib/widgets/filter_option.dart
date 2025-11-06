import 'package:flutter/material.dart';
import 'dart:io';
import '../models/filter_model.dart';

class FilterOption extends StatelessWidget {
  final FilterModel filter;
  final String imagePath;
  final bool isSelected;
  final VoidCallback onTap;

  const FilterOption({
    super.key,
    required this.filter,
    required this.imagePath,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 100,
        margin: const EdgeInsets.only(right: 12),
        child: Column(
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isSelected
                      ? Theme.of(context).colorScheme.primary
                      : Colors.grey[700]!,
                  width: isSelected ? 3 : 1,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: ColorFiltered(
                  colorFilter: filter.colorFilter,
                  child: Image.file(
                    File(imagePath),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              filter.name,
              style: TextStyle(
                color: isSelected ? Theme.of(context).colorScheme.primary : Colors.grey[400],
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}