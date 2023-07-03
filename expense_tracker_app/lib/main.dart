import 'package:expense_tracker_app/widgets/expense_tracker.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: const ExpenseTracker(),
    ),
  );
}
