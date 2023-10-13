import 'package:expense_tracker_app/constants/expense_category__enum.dart';
import 'package:flutter/material.dart';

import '../../models/expense_model.dart';

class NewExpense extends StatefulWidget {
  const NewExpense(this.newExpense, {super.key});

  final void Function(ExpenseModel) newExpense;

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  //************Controles del Form ******************* */
  final _titleController =
      TextEditingController(); //TextEditingController, sirve para guardar inputs del usuario

  final _amountController = TextEditingController();
  DateTime? _pickedDateController;
  ExpenseCategory _selectedCategoryController = ExpenseCategory.food;
  //********************************************** */

  //Cuando el widget se cierra, se debe eliminar el controlador o se guardara en memoria.
  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  //Para elegir la fecha
  void selectDateDialog() async {
    final now = DateTime.now();
    final firstDateValue = DateTime(now.year - 1, now.month, now.day);

    final selectedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDateValue,
      lastDate: now,
    );

    setState(() {
      _pickedDateController = selectedDate;
    });
  }

  bool get _isFormInvalid {
    final amountNumber = double.tryParse(_amountController.text);
    final amountIsInvalid = amountNumber == null || amountNumber <= 0;

    return (_titleController.text.isEmpty ||
        amountIsInvalid ||
        _pickedDateController == null);
  }

  void _submitData() {
    if (_isFormInvalid) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid form'),
          content:
              const Text('Porfavor ingrese o verifica los campos requeridos'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('Ok'),
            ),
          ],
        ),
      );
      return;
    }

    final newExpenseValues = ExpenseModel(
      title: _titleController.text,
      amount: double.parse(_amountController.text),
      date: _pickedDateController!,
      category: _selectedCategoryController,
    );

    widget.newExpense(newExpenseValues);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 50, 16, 16),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            maxLength: 50,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
              labelText: 'Title',
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _amountController,
                  maxLength: 10,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    prefix: Text('\$'),
                    labelText: 'Amount',
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Row(
                children: [
                  Text(_pickedDateController == null
                      ? 'No date chosen'
                      : '${_pickedDateController!.day}/${_pickedDateController!.month}/${_pickedDateController!.year}'),
                  IconButton(
                    onPressed: selectDateDialog,
                    icon: const Icon(Icons.calendar_today),
                  ),
                ],
              )
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DropdownButton(
                value: _selectedCategoryController,
                items: ExpenseCategory.values
                    .map(
                      (enumElement) => DropdownMenuItem(
                        value: enumElement,
                        child: Text(
                          enumElement.name.toUpperCase(),
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  if (value == null) {
                    return;
                  }
                  setState(() {
                    _selectedCategoryController = value;
                  });
                },
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: _submitData,
                child: const Text('Save Expense'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
