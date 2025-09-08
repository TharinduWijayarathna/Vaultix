import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/app_provider.dart';
import '../models/account.dart';
import '../widgets/account_card.dart';
import '../widgets/transaction_list_item.dart';
import '../components/ui/card.dart' as ui;
import '../components/ui/button.dart' as ui;
import '../components/ui/badge.dart' as ui;
import 'add_account_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: Consumer<AppProvider>(
          builder: (context, provider, child) {
            if (provider.isLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF0F172A)),
                ),
              );
            }

            return CustomScrollView(
              slivers: [
                _buildAppBar(context, provider),
                _buildTotalBalanceCard(provider),
                _buildAccountsSection(context, provider),
                const SliverToBoxAdapter(child: SizedBox(height: 24)),
                _buildRecentTransactionsSection(context, provider),
                const SliverToBoxAdapter(child: SizedBox(height: 100)),
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddAccountScreen(),
            ),
          );
        },
        backgroundColor: const Color(0xFF0F172A),
        foregroundColor: const Color(0xFFFFFFFF),
        elevation: 0,
        child: const Icon(Icons.add, size: 24),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context, AppProvider provider) {
    return SliverAppBar(
      expandedHeight: 100,
      floating: false,
      pinned: true,
      backgroundColor: const Color(0xFFFFFFFF),
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: const BoxDecoration(
            color: Color(0xFFFFFFFF),
            border: Border(
              bottom: BorderSide(
                color: Color(0xFFE2E8F0),
                width: 1,
              ),
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Vaultix',
                            style: TextStyle(
                              color: Color(0xFF0F172A),
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              letterSpacing: -0.025,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            DateFormat('EEEE, MMMM d').format(DateTime.now()),
                            style: const TextStyle(
                              color: Color(0xFF64748B),
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              letterSpacing: -0.025,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF1F5F9),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.notifications_outlined,
                          color: Color(0xFF64748B),
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTotalBalanceCard(AppProvider provider) {
    return SliverToBoxAdapter(
      child: FutureBuilder<double>(
        future: provider.getTotalBalance(),
        builder: (context, snapshot) {
          final totalBalance = snapshot.data ?? 0.0;
          return Padding(
            padding: const EdgeInsets.all(16),
            child: ui.Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total Balance',
                        style: TextStyle(
                          color: Color(0xFF64748B),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          letterSpacing: -0.025,
                        ),
                      ),
                      ui.Badge(
                        variant: ui.BadgeVariant.secondary,
                        child: Text('${provider.accounts.length} accounts'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    NumberFormat.currency(symbol: '\$').format(totalBalance),
                    style: const TextStyle(
                      color: Color(0xFF0F172A),
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.025,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: FutureBuilder<double>(
                          future: provider.getTotalIncome(
                            DateTime.now().subtract(const Duration(days: 30)),
                            DateTime.now(),
                          ),
                          builder: (context, snapshot) {
                            return _buildStatCard(
                              'Income',
                              snapshot.data ?? 0.0,
                              Icons.trending_up,
                              const Color(0xFF10B981),
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: FutureBuilder<double>(
                          future: provider.getTotalExpenses(
                            DateTime.now().subtract(const Duration(days: 30)),
                            DateTime.now(),
                          ),
                          builder: (context, snapshot) {
                            return _buildStatCard(
                              'Expenses',
                              snapshot.data ?? 0.0,
                              Icons.trending_down,
                              const Color(0xFFEF4444),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildStatCard(String label, double amount, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: color.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: color,
                size: 16,
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  color: color,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  letterSpacing: -0.025,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            NumberFormat.currency(symbol: '\$').format(amount),
            style: const TextStyle(
              color: Color(0xFF0F172A),
              fontSize: 18,
              fontWeight: FontWeight.w600,
              letterSpacing: -0.025,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAccountsSection(BuildContext context, AppProvider provider) {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'My Accounts',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF0F172A),
                    letterSpacing: -0.025,
                  ),
                ),
                ui.Button(
                  variant: ui.ButtonVariant.outline,
                  size: ui.ButtonSize.sm,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AddAccountScreen(),
                      ),
                    );
                  },
                  child: const Text('Add Account'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          if (provider.accounts.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ui.Card(
                child: Column(
                  children: [
                    Icon(
                      Icons.account_balance_wallet_outlined,
                      size: 48,
                      color: const Color(0xFF64748B),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'No accounts yet',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF0F172A),
                        letterSpacing: -0.025,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Add your first account to get started',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF64748B),
                        letterSpacing: -0.025,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    ui.Button(
                      isFullWidth: true,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AddAccountScreen(),
                          ),
                        );
                      },
                      child: const Text('Create Account'),
                    ),
                  ],
                ),
              ),
            )
          else
            SizedBox(
              height: 180,
              child: PageView.builder(
                itemCount: provider.accounts.length,
                itemBuilder: (context, index) {
                  final account = provider.accounts[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: AccountCard(account: account),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildRecentTransactionsSection(BuildContext context, AppProvider provider) {
    final recentTransactions = provider.getRecentTransactions(limit: 5);
    
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Recent Transactions',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color(0xFF0F172A),
                letterSpacing: -0.025,
              ),
            ),
          ),
          const SizedBox(height: 16),
          if (recentTransactions.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(32),
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
                  children: [
                    Icon(
                      Icons.receipt_long_outlined,
                      size: 48,
                      color: const Color(0xFF64748B),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'No transactions yet',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF0F172A),
                        letterSpacing: -0.025,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Your recent transactions will appear here',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF64748B),
                        letterSpacing: -0.025,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            )
          else
            SizedBox(
              height: 200,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: recentTransactions.length,
                itemBuilder: (context, index) {
                  final transaction = recentTransactions[index];
                  final account = provider.getAccountById(transaction.accountId);
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: TransactionListItem(
                      transaction: transaction,
                      accountName: account?.name ?? 'Unknown Account',
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
