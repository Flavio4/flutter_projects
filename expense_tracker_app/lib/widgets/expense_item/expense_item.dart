import 'package:expense_tracker_app/models/expense_model.dart';
import 'package:flutter/material.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem(this.expenseItem, {super.key});

  final ExpenseModel expenseItem;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          children: [
            Text(
              expenseItem.title,
            ),
            const SizedBox(
              height: 4,
            ),
            Row(
              children: [
                Text('\$${expenseItem.amount.toStringAsFixed(2)}'),
                const Spacer(),
                Row(children: [
                  Icon(
                    categoryIcons[expenseItem.category],
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Text(
                    expenseItem.formattedDate,
                  ),
                ]),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
