import 'package:flutter/material.dart';
import 'package:shopping_list_app/data/dummy_items.dart';

class GroceryList extends StatelessWidget {
  const GroceryList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Lista de Compras'),
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
        ));
  }
}
