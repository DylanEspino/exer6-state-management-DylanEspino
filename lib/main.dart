import 'package:flutter/material.dart';
import 'package:myapp/pages/cart.dart';
import 'package:myapp/pages/products.dart';
import 'package:myapp/pages/checkout.dart';
import 'package:myapp/providers/shoppingcart_provider.dart';
import 'package:provider/provider.dart';

void main() {
  // Initialize the application with a ChangeNotifierProvider to provide the ShoppingCart state to the widget tree.
  runApp(ChangeNotifierProvider(
    create: (context) => ShoppingCart(),
    child: const RootWidget(),
  ));
}

// RootWidget serves as the root of the widget tree.
class RootWidget extends StatelessWidget {
  const RootWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Week 6: State Management",
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          color: Colors.blue,
          iconTheme: IconThemeData(color: Colors.white),
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      // Define the initial route of the application.
      initialRoute: "/",
      // Define the routes and corresponding widgets.
      routes: {
        "/": (context) => const ProductsPage(),  // Route for the ProductsPage.
        "/cart": (context) => const CartPage(),  // Route for the CartPage.
        '/checkout': (context) => const CheckoutPage(),  // Route for the CheckoutPage.
      },
    );
  }
}
