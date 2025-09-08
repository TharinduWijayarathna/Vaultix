import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/account.dart';
import '../models/transaction.dart' as app_transaction;
import '../models/category.dart';
import '../models/budget.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'vaultix.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    // Create accounts table
    await db.execute('''
      CREATE TABLE accounts(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        balance REAL NOT NULL,
        type TEXT NOT NULL,
        created_date INTEGER NOT NULL
      )
    ''');

    // Create categories table
    await db.execute('''
      CREATE TABLE categories(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        icon TEXT NOT NULL,
        color TEXT NOT NULL
      )
    ''');

    // Create transactions table
    await db.execute('''
      CREATE TABLE transactions(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        account_id INTEGER NOT NULL,
        amount REAL NOT NULL,
        type TEXT NOT NULL,
        category TEXT NOT NULL,
        description TEXT NOT NULL,
        date INTEGER NOT NULL,
        FOREIGN KEY (account_id) REFERENCES accounts (id)
      )
    ''');

    // Create budgets table
    await db.execute('''
      CREATE TABLE budgets(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        category_id INTEGER,
        limit_amount REAL NOT NULL,
        period TEXT NOT NULL,
        created_date INTEGER NOT NULL,
        FOREIGN KEY (category_id) REFERENCES categories (id)
      )
    ''');

    // Insert default categories
    await _insertDefaultCategories(db);
  }

  Future<void> _insertDefaultCategories(Database db) async {
    final defaultCategories = [
      {'name': 'Food & Dining', 'icon': '🍽️', 'color': '#FF6B6B'},
      {'name': 'Transportation', 'icon': '🚗', 'color': '#4ECDC4'},
      {'name': 'Entertainment', 'icon': '🎬', 'color': '#45B7D1'},
      {'name': 'Shopping', 'icon': '🛍️', 'color': '#96CEB4'},
      {'name': 'Healthcare', 'icon': '🏥', 'color': '#FFEAA7'},
      {'name': 'Education', 'icon': '📚', 'color': '#DDA0DD'},
      {'name': 'Utilities', 'icon': '⚡', 'color': '#98D8C8'},
      {'name': 'Income', 'icon': '💰', 'color': '#6C5CE7'},
      {'name': 'Other', 'icon': '📝', 'color': '#A29BFE'},
    ];

    for (var category in defaultCategories) {
      await db.insert('categories', category);
    }
  }

  // Account operations
  Future<int> insertAccount(Account account) async {
    final db = await database;
    return await db.insert('accounts', account.toMap());
  }

  Future<List<Account>> getAccounts() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('accounts');
    return List.generate(maps.length, (i) => Account.fromMap(maps[i]));
  }

  Future<int> updateAccount(Account account) async {
    final db = await database;
    return await db.update(
      'accounts',
      account.toMap(),
      where: 'id = ?',
      whereArgs: [account.id],
    );
  }

  Future<int> deleteAccount(int id) async {
    final db = await database;
    return await db.delete(
      'accounts',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Transaction operations
  Future<int> insertTransaction(app_transaction.Transaction transaction) async {
    final db = await database;
    return await db.insert('transactions', transaction.toMap());
  }

  Future<List<app_transaction.Transaction>> getTransactions({int? accountId}) async {
    final db = await database;
    List<Map<String, dynamic>> maps;
    
    if (accountId != null) {
      maps = await db.query(
        'transactions',
        where: 'account_id = ?',
        whereArgs: [accountId],
        orderBy: 'date DESC',
      );
    } else {
      maps = await db.query('transactions', orderBy: 'date DESC');
    }
    
    return List.generate(maps.length, (i) => app_transaction.Transaction.fromMap(maps[i]));
  }

  Future<List<app_transaction.Transaction>> getTransactionsByCategory(String category) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'transactions',
      where: 'category = ?',
      whereArgs: [category],
      orderBy: 'date DESC',
    );
    return List.generate(maps.length, (i) => app_transaction.Transaction.fromMap(maps[i]));
  }

  Future<List<app_transaction.Transaction>> getTransactionsByDateRange(DateTime start, DateTime end) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'transactions',
      where: 'date BETWEEN ? AND ?',
      whereArgs: [start.millisecondsSinceEpoch, end.millisecondsSinceEpoch],
      orderBy: 'date DESC',
    );
    return List.generate(maps.length, (i) => app_transaction.Transaction.fromMap(maps[i]));
  }

  // Category operations
  Future<List<Category>> getCategories() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('categories');
    return List.generate(maps.length, (i) => Category.fromMap(maps[i]));
  }

  // Budget operations
  Future<int> insertBudget(Budget budget) async {
    final db = await database;
    return await db.insert('budgets', budget.toMap());
  }

  Future<List<Budget>> getBudgets() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('budgets');
    return List.generate(maps.length, (i) => Budget.fromMap(maps[i]));
  }

  Future<int> updateBudget(Budget budget) async {
    final db = await database;
    return await db.update(
      'budgets',
      budget.toMap(),
      where: 'id = ?',
      whereArgs: [budget.id],
    );
  }

  Future<int> deleteBudget(int id) async {
    final db = await database;
    return await db.delete(
      'budgets',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Analytics queries
  Future<double> getTotalBalance() async {
    final db = await database;
    final result = await db.rawQuery('SELECT SUM(balance) as total FROM accounts');
    return result.first['total'] as double? ?? 0.0;
  }

  Future<double> getTotalExpensesByCategory(String category, DateTime start, DateTime end) async {
    final db = await database;
    final result = await db.rawQuery(
      'SELECT SUM(amount) as total FROM transactions WHERE category = ? AND type = ? AND date BETWEEN ? AND ?',
      [category, 'expense', start.millisecondsSinceEpoch, end.millisecondsSinceEpoch],
    );
    return result.first['total'] as double? ?? 0.0;
  }

  Future<double> getTotalIncome(DateTime start, DateTime end) async {
    final db = await database;
    final result = await db.rawQuery(
      'SELECT SUM(amount) as total FROM transactions WHERE type = ? AND date BETWEEN ? AND ?',
      ['income', start.millisecondsSinceEpoch, end.millisecondsSinceEpoch],
    );
    return result.first['total'] as double? ?? 0.0;
  }

  Future<double> getTotalExpenses(DateTime start, DateTime end) async {
    final db = await database;
    final result = await db.rawQuery(
      'SELECT SUM(amount) as total FROM transactions WHERE type = ? AND date BETWEEN ? AND ?',
      ['expense', start.millisecondsSinceEpoch, end.millisecondsSinceEpoch],
    );
    return result.first['total'] as double? ?? 0.0;
  }
}
