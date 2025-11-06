import 'package:flutter/material.dart';

class FilterModel {
  final String name;
  final ColorFilter colorFilter;

  FilterModel({
    required this.name,
    required this.colorFilter,
  });

  factory FilterModel.none() {
    return FilterModel(
      name: 'Original',
      colorFilter: const ColorFilter.mode(Colors.transparent, BlendMode.multiply),
    );
  }
}