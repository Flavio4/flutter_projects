import 'package:expense_tracker_app/widgets/expense_list/expense_list.dart';
import 'package:expense_tracker_app/widgets/new_expense/new_expense.dart';
import 'package:flutter/material.dart';

import '../constants/expense_category__enum.dart';
import '../models/expense_model.dart';
import 'chart/chart.dart';

class ExpenseTracker extends StatefulWidget {
  const ExpenseTracker({super.key});

  @override
  State<ExpenseTracker> createState() => _ExpenseTrackerState();
}

class _ExpenseTrackerState extends State<ExpenseTracker> {
  final List<ExpenseModel> _registeredExpenses = [
    ExpenseModel(
      title: 'Shoes',
      amount: 69.99,
      date: DateTime.now(),
      category: ExpenseCategory.leisure,
    ),
    ExpenseModel(
      title: 'Groceries',
      amount: 16.55,
      date: DateTime.now(),
      category: ExpenseCategory.food,
    ),
    ExpenseModel(
      title: 'Fuel',
      amount: 45.00,
      date: DateTime.now(),
      category: ExpenseCategory.work,
    ),
    ExpenseModel(
      title: 'Travel Toronto',
      amount: 45.00,
      date: DateTime.now(),
      category: ExpenseCategory.travel,
    ),
  ];

  void _addExpenseOverlay() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) {
        return NewExpense(_newExpense);
      },
    );
  }

  void _newExpense(ExpenseModel newExpense) {
    setState(() {
      _registeredExpenses.add(newExpense);
    });
  }

  void _removeExpense(ExpenseModel expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);
    final snackbar = ScaffoldMessenger.of(context);

    setState(() {
      _registeredExpenses.remove(expense);
    });
    snackbar.clearSnackBars();
    snackbar.showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 5),
        content: const Text("Elemento eliminado."),
        action: SnackBarAction(
          label: "Deshacer",
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(expenseIndex, expense);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Colors.orange,
        title: const Text('Expense Tracker'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _addExpenseOverlay,
          ),
        ],
      ),
      body: Column(
        children: [
          Chart(expenses: _registeredExpenses),
          Expanded(child: ExpenseList(_registeredExpenses, _removeExpense)),
        ],
      ),
    );
  }
}
