import 'package:flutter/material.dart';
import 'package:myapp/providers/shoppingcart_provider.dart';
import 'package:provider/provider.dart';
import '../models/item.dart';

// StatelessWidget for the Checkout Page.
class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Checkout'), // Title for the AppBar.
        ),
        body: Center(
          child: Column(
            children: [
              const Text("Item Details"), // Header text for item details.
              getItems(context), // Call to getItems method to display the items.
            ],
          ),
        ));
  }

  // Method to get and display items in the cart.
  Widget getItems(BuildContext context) {
    List<Item> products = context.read<ShoppingCart>().cart; // Get the list of items in the cart.

    return products.isEmpty
        ? const Text("No items to checkout!") // Display message if cart is empty.
        : Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: ListView.builder(
                      itemCount: products.length, // Number of items in the cart.
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          title: Text(products[index].name), // Display item name.
                          trailing: Text(products[index].price.toString()), // Display item price.
                        );
                      }),
                ),
                computeCost(), // Display total cost.
                ElevatedButton(
                    onPressed: () {
                      context.read<ShoppingCart>().removeAll(); // Clear the cart.
                      Navigator.pushNamed(context, '/'); // Navigate to home page.
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Payment successful!"), // Display payment success message.
                        duration: Duration(seconds: 2),
                      ));
                    },
                    child: const Text("Pay Now!")) // Button to initiate payment.
              ],
            ),
          );
  }

  // Method to compute and display the total cost of items in the cart.
  Widget computeCost() {
    return Consumer<ShoppingCart>(builder: (context, cart, child) {
      return Text("Total: ${cart.cartTotal}"); // Display the total cost.
    });
  }
}
