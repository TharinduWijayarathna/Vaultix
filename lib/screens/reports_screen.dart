import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import '../providers/app_provider.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  String _selectedPeriod = 'month';
  DateTime _selectedDate = DateTime.now();

  final List<String> _periods = ['week', 'month', 'year'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text(
          'Reports & Analytics',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFF0F172A),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Consumer<AppProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF0F172A)),
              ),
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildPeriodSelector(),
                const SizedBox(height: 24),
                _buildSummaryCards(provider),
                const SizedBox(height: 24),
                _buildExpenseChart(provider),
                const SizedBox(height: 24),
                _buildCategoryBreakdown(provider),
                const SizedBox(height: 24),
                _buildIncomeVsExpense(provider),
                const SizedBox(height: 100), // Extra space for bottom navigation
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildPeriodSelector() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Time Period',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: _periods.map((period) {
              final isSelected = _selectedPeriod == period;
              return Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedPeriod = period;
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: isSelected ? const Color(0xFF0F172A) : const Color(0xFFF1F5F9),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      period.toUpperCase(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.grey[600],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCards(AppProvider provider) {
    return FutureBuilder<Map<String, double>>(
      future: _getSummaryData(provider),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final data = snapshot.data!;
        return Row(
          children: [
            Expanded(
              child: _buildSummaryCard(
                'Total Income',
                data['income'] ?? 0.0,
                const Color(0xFF10B981),
                Icons.trending_up,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildSummaryCard(
                'Total Expenses',
                data['expenses'] ?? 0.0,
                const Color(0xFFEF4444),
                Icons.trending_down,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSummaryCard(String title, double amount, Color color, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              const Spacer(),
              Text(
                NumberFormat.currency(symbol: '\$').format(amount),
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExpenseChart(AppProvider provider) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Expense Trends',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 200,
            child: FutureBuilder<List<FlSpot>>(
              future: _getExpenseChartData(provider),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                return LineChart(
                  LineChartData(
                    gridData: FlGridData(show: false),
                    titlesData: FlTitlesData(show: false),
                    borderData: FlBorderData(show: false),
                    lineBarsData: [
                      LineChartBarData(
                        spots: snapshot.data!,
                        isCurved: true,
                        color: const Color(0xFF0F172A),
                        barWidth: 3,
                        dotData: FlDotData(show: false),
                        belowBarData: BarAreaData(
                          show: true,
                          color: const Color(0xFF0F172A).withOpacity(0.1),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryBreakdown(AppProvider provider) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Expenses by Category',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 200,
            child: FutureBuilder<List<PieChartSectionData>>(
              future: _getCategoryChartData(provider),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                return PieChart(
                  PieChartData(
                    sections: snapshot.data!,
                    centerSpaceRadius: 40,
                    sectionsSpace: 2,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIncomeVsExpense(AppProvider provider) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Income vs Expenses',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 200,
            child: FutureBuilder<List<BarChartGroupData>>(
              future: _getIncomeVsExpenseData(provider),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                return BarChart(
                  BarChartData(
                    alignment: BarChartAlignment.spaceAround,
                    maxY: 1000,
                    barTouchData: BarTouchData(enabled: false),
                    titlesData: FlTitlesData(
                      show: true,
                      rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            return Text(
                              DateFormat('MMM').format(DateTime.now().subtract(Duration(days: (7 - value.toInt()) * 7))),
                              style: const TextStyle(fontSize: 12),
                            );
                          },
                        ),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            return Text(
                              '\$${value.toInt()}',
                              style: const TextStyle(fontSize: 12),
                            );
                          },
                        ),
                      ),
                    ),
                    borderData: FlBorderData(show: false),
                    barGroups: snapshot.data!,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<Map<String, double>> _getSummaryData(AppProvider provider) async {
    final dateRange = _getDateRange();
    final income = await provider.getTotalIncome(dateRange['start']!, dateRange['end']!);
    final expenses = await provider.getTotalExpenses(dateRange['start']!, dateRange['end']!);
    
    return {
      'income': income,
      'expenses': expenses,
    };
  }

  Future<List<FlSpot>> _getExpenseChartData(AppProvider provider) async {
    final dateRange = _getDateRange();
    final spots = <FlSpot>[];
    
    // Get daily expense data for the last 7 days
    for (int i = 6; i >= 0; i--) {
      final date = DateTime.now().subtract(Duration(days: i));
      final startOfDay = DateTime(date.year, date.month, date.day);
      final endOfDay = startOfDay.add(const Duration(days: 1));
      
      final expenses = await provider.getTotalExpenses(startOfDay, endOfDay);
      spots.add(FlSpot((6 - i).toDouble(), expenses));
    }
    
    return spots;
  }

  Future<List<PieChartSectionData>> _getCategoryChartData(AppProvider provider) async {
    final dateRange = _getDateRange();
    final categories = ['Food & Dining', 'Transportation', 'Entertainment', 'Shopping', 'Healthcare', 'Education', 'Utilities', 'Other'];
    final colors = [
      const Color(0xFFFF6B6B),
      const Color(0xFF4ECDC4),
      const Color(0xFF45B7D1),
      const Color(0xFF96CEB4),
      const Color(0xFFFFEAA7),
      const Color(0xFFDDA0DD),
      const Color(0xFF98D8C8),
      const Color(0xFF64748B),
    ];

    final sections = <PieChartSectionData>[];
    double totalExpenses = 0;
    
    // Calculate total expenses for the period
    for (String category in categories) {
      final categoryExpenses = await provider.getTotalExpensesByCategory(category, dateRange['start']!, dateRange['end']!);
      totalExpenses += categoryExpenses;
    }
    
    if (totalExpenses == 0) {
      // Show empty state
      sections.add(
        PieChartSectionData(
          color: Colors.grey[300]!,
          value: 100,
          title: 'No Data',
          radius: 50,
          titleStyle: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
      );
      return sections;
    }
    
    // Create sections for each category with actual data
    for (int i = 0; i < categories.length; i++) {
      final categoryExpenses = await provider.getTotalExpensesByCategory(categories[i], dateRange['start']!, dateRange['end']!);
      if (categoryExpenses > 0) {
        final percentage = (categoryExpenses / totalExpenses) * 100;
        sections.add(
          PieChartSectionData(
            color: colors[i],
            value: percentage,
            title: '${percentage.toStringAsFixed(0)}%',
            radius: 50,
            titleStyle: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        );
      }
    }
    
    return sections;
  }

  Future<List<BarChartGroupData>> _getIncomeVsExpenseData(AppProvider provider) async {
    final groups = <BarChartGroupData>[];
    
    // Get data for the last 7 days
    for (int i = 6; i >= 0; i--) {
      final date = DateTime.now().subtract(Duration(days: i));
      final startOfDay = DateTime(date.year, date.month, date.day);
      final endOfDay = startOfDay.add(const Duration(days: 1));
      
      final income = await provider.getTotalIncome(startOfDay, endOfDay);
      final expenses = await provider.getTotalExpenses(startOfDay, endOfDay);
      
      groups.add(
        BarChartGroupData(
          x: 6 - i,
          barRods: [
            BarChartRodData(
              toY: income,
              color: const Color(0xFF10B981),
              width: 8,
            ),
            BarChartRodData(
              toY: expenses,
              color: const Color(0xFFEF4444),
              width: 8,
            ),
          ],
        ),
      );
    }
    return groups;
  }

  Map<String, DateTime> _getDateRange() {
    final now = DateTime.now();
    DateTime start, end;

    switch (_selectedPeriod) {
      case 'week':
        start = now.subtract(const Duration(days: 7));
        end = now;
        break;
      case 'month':
        start = DateTime(now.year, now.month - 1, now.day);
        end = now;
        break;
      case 'year':
        start = DateTime(now.year - 1, now.month, now.day);
        end = now;
        break;
      default:
        start = now.subtract(const Duration(days: 30));
        end = now;
    }

    return {'start': start, 'end': end};
  }
}
