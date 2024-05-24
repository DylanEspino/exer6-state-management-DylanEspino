import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:myapp/models/item.dart';
import 'package:myapp/providers/shoppingcart_provider.dart';

// StatelessWidget for the Cart Page.
class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Cart")), // Title for the AppBar.
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          getItems(context), // Call to getItems method to display the items in the cart.
          computeCost(), // Display the total cost.
          const Divider(height: 5, color: Colors.black), // Divider for visual separation.
          Flexible(
              child: Center(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                ElevatedButton(
                    onPressed: () {
                      context.read<ShoppingCart>().removeAll(); // Clear the cart when "Reset" button is pressed.
                    },
                    child: const Text("Reset")),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "/checkout"); // Navigate to the checkout page.
                    },
                    child: const Text("Checkout"))
              ]))),
          TextButton(
            child: const Text("Go back to Products"), // Button to navigate back to the products page.
            onPressed: () {
              Navigator.pushNamed(context, "/");
            },
          ),
        ],
      ),
    );
  }

  // Method to get and display items in the cart.
  Widget getItems(BuildContext context) {
    List<Item> products = context.watch<ShoppingCart>().cart; // Get the list of items in the cart.
    String productname = "";
    return products.isEmpty
        ? const Text('Empty') // Display message if cart is empty.
        : Expanded(
            child: Column(
            children: [
              Flexible(
                  child: ListView.builder(
                itemCount: products.length, // Number of items in the cart.
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: const Icon(Icons.food_bank), // Icon for each list item.
                    title: Text(products[index].name), // Display item name.
                    trailing: IconButton(
                      icon: const Icon(Icons.delete), // Delete icon button.
                      onPressed: () {
                        productname = products[index].name;

                        if (products.isNotEmpty) {
                          context.read<ShoppingCart>().removeItem(productname); // Remove item from the cart.
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("$productname removed!"), // Show snackbar notification.
                            duration: const Duration(seconds: 2),
                          ));
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("Cart is Empty!"), // Show snackbar notification if cart is empty.
                            duration: Duration(seconds: 2),
                          ));
                        }
                      },
                    ),
                  );
                },
              )),
            ],
          ));
  }

  // Method to compute and display the total cost of items in the cart.
  Widget computeCost() {
    return Consumer<ShoppingCart>(builder: (context, cart, child) {
      return Text("Total: ${cart.cartTotal}"); // Display the total cost.
    });
  }
}
