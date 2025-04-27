import 'package:expenses_app_demo/models/monthly_data.dart';
import 'package:expenses_app_demo/screens/income_expense_screen.dart';
import 'package:flutter/material.dart';

class MonthlyBreakdownCard extends StatelessWidget {
  final MonthlyData monthlyData;

  const MonthlyBreakdownCard({super.key, required this.monthlyData});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              monthlyData.month,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text('Income: \$${monthlyData.income.toStringAsFixed(2)}'),
            Text('Expenses: \$${monthlyData.expenses.toStringAsFixed(2)}'),
            const SizedBox(height: 8),
            Text(
              'Balance: \$${(monthlyData.income - monthlyData.expenses).toStringAsFixed(2)}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: (monthlyData.income - monthlyData.expenses) == 0
                    ? Colors.grey
                    : (monthlyData.income - monthlyData.expenses) >= 0
                        ? Colors.green
                        : Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
