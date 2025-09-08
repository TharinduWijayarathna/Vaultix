import '../models/account.dart';
import '../models/transaction.dart';
import '../models/savings_goal.dart';
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

    // Create sample savings goals
    final sampleSavingsGoals = [
      SavingsGoal(
        id: 0,
        name: 'Emergency Fund',
        description: 'Build a 6-month emergency fund for unexpected expenses',
        targetAmount: 10000.00,
        currentAmount: 5000.00,
        targetDate: DateTime.now().add(const Duration(days: 365)),
        createdDate: DateTime.now().subtract(const Duration(days: 30)),
        category: 'Emergency Fund',
      ),
      SavingsGoal(
        id: 0,
        name: 'Vacation to Europe',
        description: 'Save for a dream vacation to Europe next summer',
        targetAmount: 5000.00,
        currentAmount: 1200.00,
        targetDate: DateTime.now().add(const Duration(days: 180)),
        createdDate: DateTime.now().subtract(const Duration(days: 15)),
        category: 'Vacation',
      ),
      SavingsGoal(
        id: 0,
        name: 'New Car',
        description: 'Save for a down payment on a new car',
        targetAmount: 8000.00,
        currentAmount: 2500.00,
        targetDate: DateTime.now().add(const Duration(days: 450)),
        createdDate: DateTime.now().subtract(const Duration(days: 45)),
        category: 'Car',
      ),
    ];

    for (final goal in sampleSavingsGoals) {
      await dbHelper.insertSavingsGoal(goal);
    }
  }
}
