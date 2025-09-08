import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionListItem extends StatelessWidget {
  final Transaction transaction;
  final String accountName;

  const TransactionListItem({
    super.key,
    required this.transaction,
    required this.accountName,
  });

  @override
  Widget build(BuildContext context) {
    final isIncome = transaction.type == 'income';
    final isExpense = transaction.type == 'expense';
    
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFFE2E8F0),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: _getCategoryColor(transaction.category).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              _getCategoryIcon(transaction.category),
              color: _getCategoryColor(transaction.category),
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction.description,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF0F172A),
                    letterSpacing: -0.025,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${transaction.category} • $accountName',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF64748B),
                    fontWeight: FontWeight.w500,
                    letterSpacing: -0.025,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${isIncome ? '+' : isExpense ? '-' : ''}${NumberFormat.currency(symbol: '\$').format(transaction.amount)}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: isIncome 
                      ? const Color(0xFF10B981)
                      : isExpense 
                          ? const Color(0xFFEF4444)
                          : const Color(0xFF0F172A),
                  letterSpacing: -0.025,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                DateFormat('MMM d').format(transaction.date),
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF64748B),
                  fontWeight: FontWeight.w500,
                  letterSpacing: -0.025,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'food & dining':
        return Icons.restaurant;
      case 'transportation':
        return Icons.directions_car;
      case 'entertainment':
        return Icons.movie;
      case 'shopping':
        return Icons.shopping_bag;
      case 'healthcare':
        return Icons.local_hospital;
      case 'education':
        return Icons.school;
      case 'utilities':
        return Icons.electrical_services;
      case 'income':
        return Icons.attach_money;
      default:
        return Icons.category;
    }
  }

  Color _getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'food & dining':
        return const Color(0xFFFF6B6B);
      case 'transportation':
        return const Color(0xFF4ECDC4);
      case 'entertainment':
        return const Color(0xFF45B7D1);
      case 'shopping':
        return const Color(0xFF96CEB4);
      case 'healthcare':
        return const Color(0xFFFFEAA7);
      case 'education':
        return const Color(0xFFDDA0DD);
      case 'utilities':
        return const Color(0xFF98D8C8);
      case 'income':
        return const Color(0xFF10B981);
      default:
        return const Color(0xFF64748B);
    }
  }
}
