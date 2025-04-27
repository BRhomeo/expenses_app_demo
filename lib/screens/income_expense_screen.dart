import 'package:expenses_app_demo/models/monthly_data.dart';
import 'package:expenses_app_demo/widgets/form/custom_dropdown_button_form_field.dart';
import 'package:expenses_app_demo/widgets/form/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:expenses_app_demo/widgets/monthly_breakdown_card.dart';

class IncomeExpenseScreen extends StatefulWidget {
  const IncomeExpenseScreen({super.key});

  @override
  State<IncomeExpenseScreen> createState() => _IncomeExpenseScreenState();
}

class _IncomeExpenseScreenState extends State<IncomeExpenseScreen> {
  final _formKey = GlobalKey<FormState>();
  double _monthlyIncome = 0;
  final Map<String, double> _monthlyExpenses = {};
  double _yearlyBonus = 0;
  int? _bonusMonth;
  double _yearlyTravelExpense = 0;
  int? _travelMonth;

  final List<String> _months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];

  void _addExpense() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String? expenseName;
        double expenseAmount = 0;
        return AlertDialog(
          title: const Text('Add Expense'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(labelText: 'Expense Name'),
                onChanged: (value) {
                  expenseName = value;
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Amount'),
                onChanged: (value) {
                  expenseAmount = double.tryParse(value) ?? 0;
                },
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (expenseName != null &&
                    expenseName!.isNotEmpty &&
                    expenseAmount > 0) {
                  setState(() {
                    _monthlyExpenses[expenseName!] = expenseAmount;
                  });
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  List<MonthlyData> _generateMonthlyData() {
    List<MonthlyData> monthlyData = [];
    for (int i = 0; i < 12; i++) {
      double income = _monthlyIncome;
      double expenses =
          _monthlyExpenses.values.fold(0, (sum, amount) => sum + amount);

      if (_bonusMonth! <= i + 1) {
        income += _yearlyBonus;
      }
      if (_travelMonth == i + 1) {
        expenses += _yearlyTravelExpense;
      }

      monthlyData.add(MonthlyData(
        month: _months[i],
        income: income,
        expenses: expenses,
      ));
    }
    return monthlyData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Income & Expenses'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CustomTextFormField(
                keyboardType: TextInputType.number,
                labelText: 'Monthly Income',
                hintText: 'Monthly Income',
                // controller: _nameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your monthly income';
                  }
                  return null;
                },
                onChanged: (value) {
                  _monthlyIncome = double.tryParse(value) ?? 0;
                },
              ),
              const SizedBox(height: 20),
              const Text('Monthly Expenses:',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              ..._monthlyExpenses.entries.map((entry) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                            '${entry.key}: \$${entry.value.toStringAsFixed(2)}'),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            setState(() {
                              _monthlyExpenses.remove(entry.key);
                            });
                          },
                        ),
                      ],
                    ),
                  )),
              ElevatedButton(
                onPressed: _addExpense,
                child: const Text('Add Expense'),
              ),
              const SizedBox(height: 20),
              CustomTextFormField(
                keyboardType: TextInputType.number,
                labelText: ' Yearly bonus',
                hintText: ' Yearly bonus',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your yearly bonus';
                  }
                  return null;
                },
                onChanged: (value) {
                  _yearlyBonus = double.tryParse(value) ?? 0;
                },
              ),
              const SizedBox(height: 10),
              CustomDropdownButtonFormField(
                labelText: 'Bonus Month',
                hintText: 'Select Bonus Month',
                items: _months
                    .asMap()
                    .entries
                    .map((entry) => DropdownMenuItem<int>(
                          value: entry.key + 1,
                          child: Text(entry.value),
                        ))
                    .toList(),
                value: _bonusMonth,
                onChanged: (value) {
                  setState(() {
                    _bonusMonth = value;
                  });
                },
              ),
              const SizedBox(height: 30),
              CustomTextFormField(
                keyboardType: TextInputType.number,
                labelText: 'Yearly Travel Expense',
                hintText: 'Yearly Travel Expense',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your yearly travel expense';
                  }
                  return null;
                },
                onChanged: (value) {
                  _yearlyTravelExpense = double.tryParse(value) ?? 0;
                },
              ),
              const SizedBox(height: 10),
              CustomDropdownButtonFormField(
                labelText: 'Travel Month',
                hintText: 'Select Travel Month',
                items: _months
                    .asMap()
                    .entries
                    .map((entry) => DropdownMenuItem<int>(
                          value: entry.key + 1,
                          child: Text(entry.value),
                        ))
                    .toList(),
                value: _travelMonth,
                onChanged: (value) {
                  setState(() {
                    _travelMonth = value;
                  });
                },
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      List<MonthlyData> monthlyData = _generateMonthlyData();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              MonthlyBreakdownScreen(monthlyData: monthlyData),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Theme.of(context).colorScheme.onPrimary,
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 32.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  child: const Text('Show Monthly Breakdown'),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

class MonthlyBreakdownScreen extends StatelessWidget {
  final List<MonthlyData> monthlyData;

  const MonthlyBreakdownScreen({super.key, required this.monthlyData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Monthly Breakdown'),
      ),
      body: ListView.builder(
        itemCount: monthlyData.length,
        itemBuilder: (context, index) {
          final data = monthlyData[index];
          return MonthlyBreakdownCard(monthlyData: data);
        },
      ),
    );
  }
}
