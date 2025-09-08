# Vaultix - Personal Finance Management App

A comprehensive personal finance management application built with Flutter, featuring an intuitive iOS-inspired design that works seamlessly on both iOS and Android platforms.

## Features

### 🏠 Home Screen
- **Account Cards**: Credit card-style interface displaying all your financial accounts
- **Balance Overview**: Quick view of total balance across all accounts
- **Recent Transactions**: Latest transaction history at a glance
- **Account Management**: Easy access to add, edit, and manage accounts

### 💳 Account Management
- **Multiple Account Types**: Support for checking, savings, credit, and investment accounts
- **Real-time Balance Updates**: Automatic balance tracking with each transaction
- **Account Creation**: Simple setup process for new accounts
- **Visual Account Cards**: Beautiful gradient cards for each account type

### 💰 Spend Section
- **Transaction Processing**: Add income or expenses with category selection
- **Account Selection**: Choose from available accounts with balance display
- **Category Management**: Pre-defined categories with custom icons and colors
- **Transaction Validation**: Ensures sufficient balance for expenses

### 📊 Reports & Analytics
- **Visual Charts**: Interactive pie charts and line graphs for spending analysis
- **Time Period Filters**: View data by week, month, or year
- **Category Breakdown**: Detailed spending analysis by category
- **Income vs Expenses**: Comparative analysis with bar charts
- **Summary Cards**: Quick overview of total income and expenses

### 🎯 Budget & Savings Goals
- **Monthly Budget Tracking**: Set and monitor spending limits
- **Savings Goals**: Visual progress tracking for savings targets
- **Category Budgets**: Set specific limits for different spending categories
- **Progress Indicators**: Real-time budget usage with warnings
- **Budgeting Tips**: Helpful tips and best practices

## Technical Features

### 🗄️ Database
- **SQLite Integration**: Local database for offline functionality
- **Optimized Queries**: Fast data retrieval and updates
- **Data Persistence**: All data stored locally on device
- **Structured Schema**: Well-organized tables for accounts, transactions, categories, and budgets

### 🎨 UI/UX Design
- **iOS-Inspired Design**: Clean, modern interface with iOS design patterns
- **Material Design Compatibility**: Android-optimized where appropriate
- **Smooth Animations**: Subtle micro-interactions and transitions
- **Responsive Layout**: Works on various screen sizes
- **Accessibility**: Support for screen readers and dynamic text sizing

### 🔧 State Management
- **Provider Pattern**: Efficient state management with Provider
- **Real-time Updates**: Automatic UI updates when data changes
- **Data Synchronization**: Consistent data across all screens

## Getting Started

### Prerequisites
- Flutter SDK (3.7.2 or higher)
- Dart SDK
- Android Studio / VS Code
- iOS Simulator / Android Emulator

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd vaultix
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

### Dependencies

- **sqflite**: SQLite database integration
- **provider**: State management
- **fl_chart**: Beautiful charts and graphs
- **flutter_slidable**: Swipe actions
- **intl**: Internationalization and formatting
- **font_awesome_flutter**: Additional icons

## Project Structure

```
lib/
├── models/           # Data models
│   ├── account.dart
│   ├── transaction.dart
│   ├── category.dart
│   └── budget.dart
├── database/         # Database helper
│   └── database_helper.dart
├── providers/        # State management
│   └── app_provider.dart
├── screens/          # App screens
│   ├── main_screen.dart
│   ├── home_screen.dart
│   ├── spend_screen.dart
│   ├── reports_screen.dart
│   ├── budget_screen.dart
│   └── add_account_screen.dart
├── widgets/          # Reusable widgets
│   ├── account_card.dart
│   └── transaction_list_item.dart
└── main.dart         # App entry point
```

## Usage

1. **First Launch**: Create your first account to get started
2. **Add Accounts**: Use the floating action button to add multiple accounts
3. **Make Transactions**: Use the Spend tab to add income or expenses
4. **View Reports**: Check the Reports tab for spending analytics
5. **Set Budgets**: Use the Budget tab to set spending limits and savings goals

## Features in Detail

### Account Types
- **Checking**: For daily transactions
- **Savings**: For saving money
- **Credit**: Credit card accounts
- **Investment**: Investment portfolios

### Transaction Categories
- Food & Dining 🍽️
- Transportation 🚗
- Entertainment 🎬
- Shopping 🛍️
- Healthcare 🏥
- Education 📚
- Utilities ⚡
- Income 💰
- Other 📝

### Chart Types
- **Pie Charts**: Category spending breakdown
- **Line Charts**: Expense trends over time
- **Bar Charts**: Income vs expense comparison
- **Progress Bars**: Budget usage and savings goals

## Future Enhancements

- [ ] Cloud synchronization
- [ ] Biometric authentication
- [ ] Receipt scanning
- [ ] Bill reminders
- [ ] Investment tracking
- [ ] Multi-currency support
- [ ] Export to CSV/PDF
- [ ] Dark mode theme

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests if applicable
5. Submit a pull request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Support

For support, email support@vaultix.app or create an issue in the repository.

---

**Vaultix** - Your personal finance companion for a better financial future! 💰✨
