class SavingsGoal {
  final int id;
  final String name;
  final String description;
  final double targetAmount;
  final double currentAmount;
  final DateTime targetDate;
  final DateTime createdDate;
  final String category;

  SavingsGoal({
    required this.id,
    required this.name,
    required this.description,
    required this.targetAmount,
    required this.currentAmount,
    required this.targetDate,
    required this.createdDate,
    required this.category,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'targetAmount': targetAmount,
      'currentAmount': currentAmount,
      'targetDate': targetDate.millisecondsSinceEpoch,
      'createdDate': createdDate.millisecondsSinceEpoch,
      'category': category,
    };
  }

  factory SavingsGoal.fromMap(Map<String, dynamic> map) {
    return SavingsGoal(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      targetAmount: map['targetAmount'],
      currentAmount: map['currentAmount'],
      targetDate: DateTime.fromMillisecondsSinceEpoch(map['targetDate']),
      createdDate: DateTime.fromMillisecondsSinceEpoch(map['createdDate']),
      category: map['category'],
    );
  }

  double get progress => targetAmount > 0 ? (currentAmount / targetAmount).clamp(0.0, 1.0) : 0.0;
  double get remainingAmount => (targetAmount - currentAmount).clamp(0.0, double.infinity);
  bool get isCompleted => currentAmount >= targetAmount;
}
