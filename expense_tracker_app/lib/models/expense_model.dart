import 'package:expense_tracker_app/constants/expense_category__enum.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

const Uuid uuid = Uuid();

const categoryIcons = {
  ExpenseCategory.food: Icons.lunch_dining,
  ExpenseCategory.leisure: Icons.movie,
  ExpenseCategory.travel: Icons.flight_takeoff,
  ExpenseCategory.work: Icons.work,
};

class ExpenseModel {
  ExpenseModel(
      {required this.title,
      required this.amount,
      required this.date,
      required this.category})
      : id = uuid.v4(); //Crea una id aleatoria
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final ExpenseCategory category;

  get formattedDate {
    return '${date.day}/${date.month}/${date.year}';
  }
}

class ExpenseBucket {
  const ExpenseBucket({required this.category, required this.expenses});

  //Constructor alternativo
  ExpenseBucket.forCategory(List<ExpenseModel> allExpenses, this.category)
      : expenses = allExpenses
            .where((expense) => expense.category == category)
            .toList();

  final ExpenseCategory category;
  final List<ExpenseModel> expenses;

  double get totalExpenses {
    double sum = 0;

    for (var expense in expenses) {
      sum += expense.amount;
    }

    return sum;
  }
}
