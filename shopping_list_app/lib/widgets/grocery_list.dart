import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shopping_list_app/data/categories.dart';
import 'package:shopping_list_app/models/grocery_item.dart';
import 'package:shopping_list_app/widgets/new_item.dart';

//Panel de formularios para nuevo producto
class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  List<GroceryItem> _groceryItems = [];
  late bool _isLoading;
  String? _error;

  @override
  void initState() {
    _isLoading = true;
    _getMeals();
    super.initState();
  }

  Future _openNewItemScreen() async {
    final route = MaterialPageRoute(
      builder: (ctx) => const NewItem(),
    );

    final newGrocery = await Navigator.push(context, route);
    if (newGrocery != null) {
      setState(() {
        _groceryItems.add(newGrocery);
      });
    }
  }

  Future<void> _getMeals() async {
    final uri = Uri.https(
      'my-http-test-4e807-default-rtdb.firebaseio.com',
      'shopping-list.json',
    );
    final response = await http.get(uri);
    if (response.statusCode >= 400) {
      setState(() {
        _error = 'Error al obtener los productos, intenta de nuevo mas tarde';
      });
      return;
    }
    //Si no hay productos en la lista, firebase retorna null String
    if (response.body == 'null') {
      setState(() {
        _isLoading = false;
      });
      return;
    }
    _processMeals(response.body);
  }

  void _processMeals(String body) {
    final Map<String, dynamic> decodedBody = json.decode(body);
    final List<GroceryItem> loadedItems = [];
    decodedBody.forEach((key, value) {
      final category = categories.entries
          .firstWhere((element) => element.value.title == value['category'])
          .value;

      final groceryItem = GroceryItem(
        id: key,
        name: value['name'],
        quantity: value['quantity'],
        category: category,
      );

      loadedItems.add(groceryItem);
    });

    setState(() {
      _groceryItems = loadedItems;
      _isLoading = false;
    });
  }

  void _removeMeal(GroceryItem groceryItem) async {
    final index = _groceryItems.indexOf(groceryItem);
    setState(() {
      _groceryItems.remove(groceryItem);
    });

    final url = Uri.https(
      'my-http-test-4e807-default-rtdb.firebaseio.com',
      'shopping-list/${groceryItem.id}.json',
    );

    final response = await http.delete(url);

    if (response.statusCode >= 400) {
      setState(() {
        _groceryItems.insert(index, groceryItem);
      });

      if (context.mounted) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('No se pudo eliminar el producto'),
            action: SnackBarAction(
              label: 'Ok',
              onPressed: ScaffoldMessenger.of(context).hideCurrentSnackBar,
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Center(
      child: Text(
        'Aun no tienes productos en tu lista de compras',
        style: Theme.of(context)
            .textTheme
            .bodyLarge!
            .copyWith(color: Colors.white, fontWeight: FontWeight.normal),
      ),
    );

    if (_isLoading) {
      content = const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (_groceryItems.isNotEmpty) {
      content = ListView.builder(
        itemCount: _groceryItems.length,
        itemBuilder: (ctx, index) {
          return Dismissible(
            key: ValueKey(_groceryItems[index].id),
            onDismissed: (direction) {
              _removeMeal(_groceryItems[index]);
            },
            child: ListTile(
              onTap: () {},
              leading: Container(
                height: 24,
                width: 24,
                decoration: BoxDecoration(
                  color: _groceryItems[index].category.color,
                  border: Border.all(color: Colors.black, width: 2.0),
                ),
              ),
              title: Text(
                _groceryItems[index].name,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              trailing: Text(
                _groceryItems[index].quantity.toString(),
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          );
        },
      );
    }

    if (_error != null) {
      content = Center(
        child: Text(
          _error!,
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: Colors.white, fontWeight: FontWeight.normal),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Compras'),
        actions: [
          IconButton(
            onPressed: _openNewItemScreen,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: content,
    );
  }
}
