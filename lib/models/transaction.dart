class Transaction {
  final int? id;
  final int accountId;
  final double amount;
  final String type; // 'income', 'expense', 'transfer'
  final String category;
  final String description;
  final DateTime date;

  Transaction({
    this.id,
    required this.accountId,
    required this.amount,
    required this.type,
    required this.category,
    required this.description,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'account_id': accountId,
      'amount': amount,
      'type': type,
      'category': category,
      'description': description,
      'date': date.millisecondsSinceEpoch,
    };
  }

  factory Transaction.fromMap(Map<String, dynamic> map) {
    return Transaction(
      id: map['id'],
      accountId: map['account_id'],
      amount: map['amount'],
      type: map['type'],
      category: map['category'],
      description: map['description'],
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
    );
  }

  Transaction copyWith({
    int? id,
    int? accountId,
    double? amount,
    String? type,
    String? category,
    String? description,
    DateTime? date,
  }) {
    return Transaction(
      id: id ?? this.id,
      accountId: accountId ?? this.accountId,
      amount: amount ?? this.amount,
      type: type ?? this.type,
      category: category ?? this.category,
      description: description ?? this.description,
      date: date ?? this.date,
    );
  }
}
