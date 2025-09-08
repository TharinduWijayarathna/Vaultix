class Account {
  final int? id;
  final String name;
  final double balance;
  final String type;
  final DateTime createdDate;

  Account({
    this.id,
    required this.name,
    required this.balance,
    required this.type,
    required this.createdDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'balance': balance,
      'type': type,
      'created_date': createdDate.millisecondsSinceEpoch,
    };
  }

  factory Account.fromMap(Map<String, dynamic> map) {
    return Account(
      id: map['id'],
      name: map['name'],
      balance: map['balance'],
      type: map['type'],
      createdDate: DateTime.fromMillisecondsSinceEpoch(map['created_date']),
    );
  }

  Account copyWith({
    int? id,
    String? name,
    double? balance,
    String? type,
    DateTime? createdDate,
  }) {
    return Account(
      id: id ?? this.id,
      name: name ?? this.name,
      balance: balance ?? this.balance,
      type: type ?? this.type,
      createdDate: createdDate ?? this.createdDate,
    );
  }
}
