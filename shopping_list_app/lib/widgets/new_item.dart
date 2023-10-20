import 'package:flutter/material.dart';
import 'package:shopping_list_app/data/categories.dart';
import 'package:shopping_list_app/models/category.dart';

class NewItem extends StatefulWidget {
  const NewItem({super.key});

  @override
  State<NewItem> createState() => _NewItemState();
}

class _NewItemState extends State<NewItem> {
  //Es el identificador del formulario y nos permite acceder a el con su estado
  final _formKey = GlobalKey<FormState>();
  var _enteredName = '';
  var _enteredQuantity = 1;
  var _selectedCategory = categories[Categories.vegetables];

  void _submitForm() {
    //validate() llama a las validaciones de los TextFormField
    if (_formKey.currentState!.validate()) {
      //save() llama a los onSaved de los TextFormField
      _formKey.currentState!.save();
      print(_enteredName);
      print(_enteredQuantity);
      print(_selectedCategory);
    }
  }

  void _resetForm() {
    //reset() resetea el estado de los TextFormField
    _formKey.currentState!.reset();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Añadir nuevo producto'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  maxLength: 50,
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        value.trim().length > 50 ||
                        value.trim().length <= 1) {
                      return 'Porfavor, inserte un nombre valido';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Nombre',
                  ),
                  onSaved: (value) {
                    _enteredName = value!;
                  },
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        initialValue: '1',
                        decoration: const InputDecoration(
                          labelText: 'Cantidad',
                        ),
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              int.tryParse(value) == null ||
                              int.tryParse(value)! <= 0) {
                            return 'Inserte una cantidad valida';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _enteredQuantity = int.parse(value!);
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: DropdownButtonFormField(
                        items: [
                          for (final category in categories.entries)
                            DropdownMenuItem(
                              value: category.value,
                              child: Row(
                                children: [
                                  Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      color: category.value.color,
                                      border: Border.all(
                                        color: Colors.black,
                                        width: 2.0,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  Text(category.value.title),
                                ],
                              ),
                            )
                        ],
                        onChanged: (value) {},
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: _resetForm,
                      child: const Text('Resetear'),
                    ),
                    ElevatedButton(
                      onPressed: _submitForm,
                      child: const Text('Añadir Producto'),
                    )
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
