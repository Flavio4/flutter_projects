import 'package:flutter/material.dart';
import 'package:shopping_list_app/widgets/new_item.dart';

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  final _groceryItems = [];
//Panel de formularios para nuevo producto
  void _openNewItemScreen() async {
    final route = MaterialPageRoute(
      builder: (ctx) => const NewItem(),
    );

    final result = await Navigator.push(context, route);
    if (result != null) {
      setState(() {
        _groceryItems.add(result);
      });
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

    if (_groceryItems.isNotEmpty) {
      content = ListView.builder(
        itemCount: _groceryItems.length,
        itemBuilder: (ctx, index) {
          return Dismissible(
            key: ValueKey(_groceryItems[index].id),
            onDismissed: (direction) {
              setState(() {
                _groceryItems.removeAt(index);
              });
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
