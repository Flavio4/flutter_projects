import 'package:expense_tracker_app/widgets/expense_item/expense_item.dart';
import 'package:flutter/material.dart';

import '../../models/expense_model.dart';

class ExpenseList extends StatelessWidget {
  const ExpenseList(this.registeredExpenses, this.removeExpense, {super.key});

  final List<ExpenseModel> registeredExpenses;
  final void Function(ExpenseModel) removeExpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: registeredExpenses.length,
      itemBuilder: (context, index) => Dismissible(
        key: ValueKey(registeredExpenses[index].id),
        onDismissed: (direction) {
          removeExpense(registeredExpenses[index]);
        },
        background: Container(
          color: Colors.red[300],
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 20),
          margin: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 4,
          ),
          child: const Icon(
            Icons.delete,
            color: Colors.white,
            size: 40,
          ),
        ),
        child: ExpenseItem(registeredExpenses[index]),
      ),
    );
  }
}
