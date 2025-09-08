import 'package:flutter/foundation.dart';

class CurrencyProvider with ChangeNotifier {
  String _selectedCurrency = 'USD';
  
  final Map<String, String> _currencies = {
    'USD': '\$',
    'EUR': '€',
    'GBP': '£',
    'INR': '₹',
    'LKR': 'Rs.',
  };

  String get selectedCurrency => _selectedCurrency;
  String get currencySymbol => _currencies[_selectedCurrency] ?? '\$';
  Map<String, String> get currencies => Map.from(_currencies);

  void setCurrency(String currency) {
    if (_currencies.containsKey(currency)) {
      _selectedCurrency = currency;
      notifyListeners();
    }
  }

  String formatAmount(double amount) {
    switch (_selectedCurrency) {
      case 'USD':
        return '\$${amount.toStringAsFixed(2)}';
      case 'EUR':
        return '€${amount.toStringAsFixed(2)}';
      case 'GBP':
        return '£${amount.toStringAsFixed(2)}';
      case 'INR':
        return '₹${amount.toStringAsFixed(0)}';
      case 'LKR':
        return 'Rs.${amount.toStringAsFixed(0)}';
      default:
        return '\$${amount.toStringAsFixed(2)}';
    }
  }
}
