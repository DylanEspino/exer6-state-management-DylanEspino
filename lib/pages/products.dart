import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:myapp/models/item.dart';
import 'package:myapp/providers/shoppingcart_provider.dart';

// StatefulWidget for the Products Page.
class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  // List of products to display on the products page.
  List<Item> productsList = [
    Item("Shampoo", 10.00, 5),
    Item("Soap", 12, 5),
    Item("Toothpaste", 40, 5)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Catalog")),
      // ListView.builder to dynamically create a list of product tiles.
      body: ListView.builder(
        itemCount: productsList.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: const Icon(Icons.star), // Icon for each list item.
            title: Text(
              "${productsList[index].name} - ${productsList[index].price}"), // Display product name and price.
            trailing: TextButton(
              child: const Text("Add"),
              onPressed: () {
                // Add item to the shopping cart when "Add" button is pressed.
                context.read<ShoppingCart>().addItem(productsList[index]);
                // Show a snackbar notification.
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("${productsList[index].name} added!"),
                  duration: const Duration(seconds: 2),
                ));
              },
            ),
          );
        },
      ),
      // Floating action button to navigate to the cart page.
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.shopping_cart),
        onPressed: () {
          Navigator.pushNamed(context, "/cart");
        },
      ),
    );
  }
}
