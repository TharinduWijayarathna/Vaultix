import 'package:flutter/material.dart';
import '../models/account.dart';
import '../models/transaction.dart';
import '../models/category.dart';
import '../models/budget.dart';
import '../database/database_helper.dart';

class AppProvider with ChangeNotifier {
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  
  List<Account> _accounts = [];
  List<Transaction> _transactions = [];
  List<Category> _categories = [];
  List<Budget> _budgets = [];
  bool _isLoading = false;

  List<Account> get accounts => _accounts;
  List<Transaction> get transactions => _transactions;
  List<Category> get categories => _categories;
  List<Budget> get budgets => _budgets;
  bool get isLoading => _isLoading;

  Future<void> loadData() async {
    _isLoading = true;
    notifyListeners();

    try {
      _accounts = await _databaseHelper.getAccounts();
      _transactions = await _databaseHelper.getTransactions();
      _categories = await _databaseHelper.getCategories();
      _budgets = await _databaseHelper.getBudgets();
    } catch (e) {
      debugPrint('Error loading data: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  // Account operations
  Future<void> addAccount(Account account) async {
    try {
      await _databaseHelper.insertAccount(account);
      await loadData();
    } catch (e) {
      debugPrint('Error adding account: $e');
    }
  }

  Future<void> updateAccount(Account account) async {
    try {
      await _databaseHelper.updateAccount(account);
      await loadData();
    } catch (e) {
      debugPrint('Error updating account: $e');
    }
  }

  Future<void> deleteAccount(int accountId) async {
    try {
      await _databaseHelper.deleteAccount(accountId);
      await loadData();
    } catch (e) {
      debugPrint('Error deleting account: $e');
    }
  }

  // Transaction operations
  Future<void> addTransaction(Transaction transaction) async {
    try {
      await _databaseHelper.insertTransaction(transaction);
      
      // Update account balance
      final account = _accounts.firstWhere((a) => a.id == transaction.accountId);
      final newBalance = transaction.type == 'income' 
          ? account.balance + transaction.amount
          : account.balance - transaction.amount;
      
      final updatedAccount = account.copyWith(balance: newBalance);
      await _databaseHelper.updateAccount(updatedAccount);
      
      await loadData();
    } catch (e) {
      debugPrint('Error adding transaction: $e');
    }
  }

  Future<List<Transaction>> getTransactionsByAccount(int accountId) async {
    try {
      return await _databaseHelper.getTransactions(accountId: accountId);
    } catch (e) {
      debugPrint('Error getting transactions by account: $e');
      return [];
    }
  }

  Future<List<Transaction>> getTransactionsByCategory(String category) async {
    try {
      return await _databaseHelper.getTransactionsByCategory(category);
    } catch (e) {
      debugPrint('Error getting transactions by category: $e');
      return [];
    }
  }

  Future<List<Transaction>> getTransactionsByDateRange(DateTime start, DateTime end) async {
    try {
      return await _databaseHelper.getTransactionsByDateRange(start, end);
    } catch (e) {
      debugPrint('Error getting transactions by date range: $e');
      return [];
    }
  }

  // Budget operations
  Future<void> addBudget(Budget budget) async {
    try {
      await _databaseHelper.insertBudget(budget);
      await loadData();
    } catch (e) {
      debugPrint('Error adding budget: $e');
    }
  }

  Future<void> updateBudget(Budget budget) async {
    try {
      await _databaseHelper.updateBudget(budget);
      await loadData();
    } catch (e) {
      debugPrint('Error updating budget: $e');
    }
  }

  Future<void> deleteBudget(int budgetId) async {
    try {
      await _databaseHelper.deleteBudget(budgetId);
      await loadData();
    } catch (e) {
      debugPrint('Error deleting budget: $e');
    }
  }

  // Analytics
  Future<double> getTotalBalance() async {
    try {
      return await _databaseHelper.getTotalBalance();
    } catch (e) {
      debugPrint('Error getting total balance: $e');
      return 0.0;
    }
  }

  Future<double> getTotalExpensesByCategory(String category, DateTime start, DateTime end) async {
    try {
      return await _databaseHelper.getTotalExpensesByCategory(category, start, end);
    } catch (e) {
      debugPrint('Error getting expenses by category: $e');
      return 0.0;
    }
  }

  Future<double> getTotalIncome(DateTime start, DateTime end) async {
    try {
      return await _databaseHelper.getTotalIncome(start, end);
    } catch (e) {
      debugPrint('Error getting total income: $e');
      return 0.0;
    }
  }

  Future<double> getTotalExpenses(DateTime start, DateTime end) async {
    try {
      return await _databaseHelper.getTotalExpenses(start, end);
    } catch (e) {
      debugPrint('Error getting total expenses: $e');
      return 0.0;
    }
  }

  // Helper methods
  Account? getAccountById(int id) {
    try {
      return _accounts.firstWhere((account) => account.id == id);
    } catch (e) {
      return null;
    }
  }

  Category? getCategoryByName(String name) {
    try {
      return _categories.firstWhere((category) => category.name == name);
    } catch (e) {
      return null;
    }
  }

  List<Transaction> getRecentTransactions({int limit = 5}) {
    final sortedTransactions = List<Transaction>.from(_transactions);
    sortedTransactions.sort((a, b) => b.date.compareTo(a.date));
    return sortedTransactions.take(limit).toList();
  }
}
