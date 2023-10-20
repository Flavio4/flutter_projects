import 'package:flutter/material.dart';
import 'package:shopping_list_app/data/dummy_items.dart';
import 'package:shopping_list_app/widgets/new_item.dart';

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
//Panel de formularios para nuevo producto
  void _openNewItemScreen() {
    final route = MaterialPageRoute(
      builder: (ctx) => const NewItem(),
    );

    Navigator.push(context, route);
  }

  @override
  Widget build(BuildContext context) {
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
      body: ListView.builder(
        itemCount: groceryItems.length,
        itemBuilder: (ctx, index) {
          return ListTile(
            onTap: () {},
            leading: Container(
              height: 24,
              width: 24,
              decoration: BoxDecoration(
                color: groceryItems[index].category.color,
                border: Border.all(color: Colors.black, width: 2.0),
              ),
            ),
            title: Text(
              groceryItems[index].name,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            trailing: Text(
              groceryItems[index].quantity.toString(),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          );
        },
      ),
    );
  }
}
