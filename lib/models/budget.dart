class Budget {
  final int? id;
  final int? categoryId;
  final double limitAmount;
  final String period; // 'monthly', 'weekly', 'yearly'
  final DateTime createdDate;

  Budget({
    this.id,
    this.categoryId,
    required this.limitAmount,
    required this.period,
    required this.createdDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'category_id': categoryId,
      'limit_amount': limitAmount,
      'period': period,
      'created_date': createdDate.millisecondsSinceEpoch,
    };
  }

  factory Budget.fromMap(Map<String, dynamic> map) {
    return Budget(
      id: map['id'],
      categoryId: map['category_id'],
      limitAmount: map['limit_amount'],
      period: map['period'],
      createdDate: DateTime.fromMillisecondsSinceEpoch(map['created_date']),
    );
  }

  Budget copyWith({
    int? id,
    int? categoryId,
    double? limitAmount,
    String? period,
    DateTime? createdDate,
  }) {
    return Budget(
      id: id ?? this.id,
      categoryId: categoryId ?? this.categoryId,
      limitAmount: limitAmount ?? this.limitAmount,
      period: period ?? this.period,
      createdDate: createdDate ?? this.createdDate,
    );
  }
}
