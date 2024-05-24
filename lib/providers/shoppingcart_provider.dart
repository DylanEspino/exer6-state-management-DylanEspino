import 'package:flutter/material.dart';
import '../models/item.dart';

// ShoppingCart class to manage the state of the shopping cart using ChangeNotifier.
class ShoppingCart with ChangeNotifier {
  // Private list to store items in the cart.
  final List<Item> _shoppingArray = [];
  // Variable to store the total price of items in the cart.
  double cartTotal = 0;

  // Getter to access the items in the cart.
  List<Item> get cart => _shoppingArray;

  // Method to add an item to the cart.
  void addItem(Item item) {
    _shoppingArray.add(item);  // Add item to the cart.
    cartTotal = cartTotal + item.price;  // Update the total price.
    notifyListeners();  // Notify listeners about the state change.
  }

  // Method to remove all items from the cart.
  void removeAll() {
    _shoppingArray.clear();  // Clear all items from the cart.
    cartTotal = 0;  // Reset the total price.
    notifyListeners();  // Notify listeners about the state change.
  }

  // Method to remove a specific item from the cart by its name.
  void removeItem(String name) {
    for (int i = 0; i < _shoppingArray.length; i++) {
      if (_shoppingArray[i].name == name) {
        cartTotal = cartTotal - _shoppingArray[i].price;  // Update the total price.
        _shoppingArray.remove(_shoppingArray[i]);  // Remove the item from the cart.
        break;  // Exit the loop once the item is found and removed.
      }
    }
    notifyListeners();  // Notify listeners about the state change.
  }
}
