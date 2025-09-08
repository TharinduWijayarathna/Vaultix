import '../models/account.dart';
import '../models/transaction.dart';
import '../database/database_helper.dart';

class SampleData {
  static Future<void> seedSampleData() async {
    final dbHelper = DatabaseHelper();
    
    // Check if data already exists
    final existingAccounts = await dbHelper.getAccounts();
    if (existingAccounts.isNotEmpty) {
      return; // Data already exists
    }

    // Create sample accounts
    final checkingAccount = Account(
      name: 'Main Checking',
      balance: 2500.00,
      type: 'checking',
      createdDate: DateTime.now().subtract(const Duration(days: 30)),
    );

    final savingsAccount = Account(
      name: 'Emergency Fund',
      balance: 5000.00,
      type: 'savings',
      createdDate: DateTime.now().subtract(const Duration(days: 60)),
    );

    final checkingId = await dbHelper.insertAccount(checkingAccount);
    final savingsId = await dbHelper.insertAccount(savingsAccount);

    // Create sample transactions
    final sampleTransactions = [
      Transaction(
        accountId: checkingId,
        amount: 3000.00,
        type: 'income',
        category: 'Income',
        description: 'Salary',
        date: DateTime.now().subtract(const Duration(days: 5)),
      ),
      Transaction(
        accountId: checkingId,
        amount: 45.50,
        type: 'expense',
        category: 'Food & Dining',
        description: 'Grocery shopping',
        date: DateTime.now().subtract(const Duration(days: 3)),
      ),
      Transaction(
        accountId: checkingId,
        amount: 25.00,
        type: 'expense',
        category: 'Transportation',
        description: 'Gas station',
        date: DateTime.now().subtract(const Duration(days: 2)),
      ),
      Transaction(
        accountId: checkingId,
        amount: 120.00,
        type: 'expense',
        category: 'Entertainment',
        description: 'Movie tickets',
        date: DateTime.now().subtract(const Duration(days: 1)),
      ),
      Transaction(
        accountId: savingsId,
        amount: 500.00,
        type: 'income',
        category: 'Income',
        description: 'Transfer from checking',
        date: DateTime.now().subtract(const Duration(days: 7)),
      ),
      Transaction(
        accountId: checkingId,
        amount: 80.00,
        type: 'expense',
        category: 'Shopping',
        description: 'Online purchase',
        date: DateTime.now().subtract(const Duration(days: 4)),
      ),
      Transaction(
        accountId: checkingId,
        amount: 150.00,
        type: 'expense',
        category: 'Healthcare',
        description: 'Doctor visit',
        date: DateTime.now().subtract(const Duration(days: 6)),
      ),
    ];

    for (final transaction in sampleTransactions) {
      await dbHelper.insertTransaction(transaction);
    }
  }
}
