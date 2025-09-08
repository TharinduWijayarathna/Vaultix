import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/savings_goal.dart';
import '../providers/app_provider.dart';
import '../providers/currency_provider.dart';
import '../components/ui/button.dart' as ui;
import '../components/ui/input.dart' as ui;

class AddSavingsGoalScreen extends StatefulWidget {
  const AddSavingsGoalScreen({super.key});

  @override
  State<AddSavingsGoalScreen> createState() => _AddSavingsGoalScreenState();
}

class _AddSavingsGoalScreenState extends State<AddSavingsGoalScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _targetAmountController = TextEditingController();
  final _currentAmountController = TextEditingController();
  
  DateTime _targetDate = DateTime.now().add(const Duration(days: 30));
  String _selectedCategory = 'General';

  final List<String> _categories = [
    'General',
    'Emergency Fund',
    'Vacation',
    'Education',
    'Home',
    'Car',
    'Retirement',
    'Investment',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _targetAmountController.dispose();
    _currentAmountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Savings Goal'),
        backgroundColor: const Color(0xFF0F172A),
        foregroundColor: const Color(0xFFFFFFFF),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ui.Input(
                controller: _nameController,
                label: 'Goal Name',
                hintText: 'e.g., Emergency Fund',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a goal name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              ui.Input(
                controller: _descriptionController,
                label: 'Description',
                hintText: 'Brief description of your goal',
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: ui.Input(
                      controller: _targetAmountController,
                      label: 'Target Amount',
                      hintText: '0.00',
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter target amount';
                        }
                        if (double.tryParse(value) == null) {
                          return 'Please enter a valid amount';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ui.Input(
                      controller: _currentAmountController,
                      label: 'Current Amount',
                      hintText: '0.00',
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter current amount';
                        }
                        if (double.tryParse(value) == null) {
                          return 'Please enter a valid amount';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ui.Select(
                label: 'Category',
                value: _selectedCategory,
                items: _categories.map((category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                onChanged: (dynamic value) {
                  setState(() {
                    _selectedCategory = value as String? ?? 'General';
                  });
                },
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: const Color(0xFFE2E8F0),
                    width: 1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Target Date',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            '${_targetDate.day}/${_targetDate.month}/${_targetDate.year}',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Color(0xFF0F172A),
                            ),
                          ),
                        ),
                        ui.Button(
                          variant: ui.ButtonVariant.outline,
                          size: ui.ButtonSize.sm,
                          onPressed: _selectDate,
                          child: const Text('Select Date'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              ui.Button(
                isFullWidth: true,
                onPressed: _saveGoal,
                child: const Text('Create Savings Goal'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _targetDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365 * 5)),
    );
    if (picked != null && picked != _targetDate) {
      setState(() {
        _targetDate = picked;
      });
    }
  }

  void _saveGoal() {
    if (_formKey.currentState!.validate()) {
      final goal = SavingsGoal(
        id: 0, // Will be set by database
        name: _nameController.text,
        description: _descriptionController.text,
        targetAmount: double.parse(_targetAmountController.text),
        currentAmount: double.parse(_currentAmountController.text),
        targetDate: _targetDate,
        createdDate: DateTime.now(),
        category: _selectedCategory,
      );

      context.read<AppProvider>().addSavingsGoal(goal);
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Savings goal created successfully!'),
          backgroundColor: Color(0xFF10B981),
        ),
      );
      
      Navigator.pop(context);
    }
  }
}
