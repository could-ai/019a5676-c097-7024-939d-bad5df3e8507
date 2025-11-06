class AdjustmentModel {
  final String type;
  final double value;

  AdjustmentModel({
    required this.type,
    required this.value,
  });

  AdjustmentModel copyWith({
    String? type,
    double? value,
  }) {
    return AdjustmentModel(
      type: type ?? this.type,
      value: value ?? this.value,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AdjustmentModel &&
        other.type == type &&
        other.value == value;
  }

  @override
  int get hashCode => type.hashCode ^ value.hashCode;
}