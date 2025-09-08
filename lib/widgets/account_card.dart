import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/account.dart';

class AccountCard extends StatelessWidget {
  final Account account;

  const AccountCard({
    super.key,
    required this.account,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 160,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                account.name,
                style: const TextStyle(
                  color: Color(0xFF0F172A),
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  letterSpacing: -0.025,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _getAccountTypeColor(account.type).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  account.type.toUpperCase(),
                  style: TextStyle(
                    color: _getAccountTypeColor(account.type),
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    letterSpacing: -0.025,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            'Balance',
            style: TextStyle(
              color: Color(0xFF64748B),
              fontSize: 14,
              fontWeight: FontWeight.w500,
              letterSpacing: -0.025,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            NumberFormat.currency(symbol: '\$').format(account.balance),
            style: const TextStyle(
              color: Color(0xFF0F172A),
              fontSize: 22,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.025,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '**** **** **** 1234',
                style: const TextStyle(
                  color: Color(0xFF64748B),
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1,
                ),
              ),
              Text(
                DateFormat('MM/yy').format(account.createdDate),
                style: const TextStyle(
                  color: Color(0xFF64748B),
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getAccountTypeColor(String type) {
    switch (type.toLowerCase()) {
      case 'checking':
        return const Color(0xFF3B82F6);
      case 'savings':
        return const Color(0xFF10B981);
      case 'credit':
        return const Color(0xFFF59E0B);
      case 'investment':
        return const Color(0xFF8B5CF6);
      default:
        return const Color(0xFF64748B);
    }
  }
}
