import 'package:flutter/material.dart';
import 'package:shopping_list_app/data/categories.dart';
import 'package:shopping_list_app/models/category.dart';
import 'package:shopping_list_app/models/grocery_item.dart';

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
      //Submit new GroceryItem
      final newGroceryItem = GroceryItem(
        id: DateTime.now().toString(),
        name: _enteredName,
        quantity: _enteredQuantity,
        category: _selectedCategory!,
      );
      Navigator.pop(context, newGroceryItem);
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
                //Text Field optimizado para formularios
                TextFormField(
                  maxLength: 50,
                  //validator es una funcion que recibe el valor del campo y retorna un string con el error o null si no hay error
                  //Siempre que se llame a validate() se ejecutara esta funcion
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
                  //onSaved es una funcion que recibe el valor del campo y realiza alguna accion con el
                  //Siempre que se llame a save() se ejecutara esta funcion
                  onSaved: (value) {
                    _enteredName = value!;
                  },
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    //Expanded es un widget que expande su hijo para ocupar todo el espacio disponible
                    //Al usar row con expanded, el espacio disponible se divide entre los hijos expanded
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
                      //DropdownButtonFormField es un dropdown que se puede usar en formularios
                      child: DropdownButtonFormField(
                        value: _selectedCategory,
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
                        onChanged: (value) {
                          setState(() {
                            _selectedCategory = value;
                          });
                        },
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
