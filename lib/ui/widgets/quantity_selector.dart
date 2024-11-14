import 'package:flutter/material.dart';

/// A widget to handle the display of product quantity and actions (increment, decrement, and remove).
class QuantitySelector extends StatelessWidget {
  /// The current quantity of the item in the cart.
  final int quantity;

  /// Callback to increment the quantity.
  final VoidCallback onIncrement;

  /// Callback to decrement the quantity.
  final VoidCallback onDecrement;

  /// Callback to remove the item from the cart.
  final VoidCallback onRemoveItem;

  ///Size of the increment/decrement buttons.
  final double buttonSize; 

  /// Size of the quantity text.
  final double textSize;   

  /// Spacing between the elements.
  final double spacing;   

  /// Constructor to initialize the parameters for the widget.
  const QuantitySelector({
    super.key,
    required this.quantity,
    required this.onIncrement,
    required this.onDecrement,
    required this.onRemoveItem,
    this.buttonSize = 30.0, 
    this.textSize = 16.0,   
    this.spacing = 8.0,     
  });

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown, 
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Decrement button with styling.
          Container(
            width: buttonSize,
            height: buttonSize,
            decoration: BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.circular(8),
            ),
            child: IconButton(
              padding: EdgeInsets.zero,
              icon: const Icon(
                Icons.remove,
                color: Colors.white,
                size: 18,
              ),
              onPressed: onDecrement,
            ),
          ),
          const SizedBox(width: 8),

          // Display the current quantity.
          Text(
            quantity.toString(),
            style: TextStyle(fontSize: textSize, fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 8),

          // Increment button with styling.
          Container(
            width: buttonSize,
            height: buttonSize,
            decoration: BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.circular(8),
            ),
            child: IconButton(
              padding: EdgeInsets.zero,
              icon: const Icon(
                Icons.add,
                color: Colors.white,
                size: 18,
              ),
              onPressed: onIncrement,
            ),
          ),
          SizedBox(width: spacing),  

          // Delete button to remove the item from the cart.
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: onRemoveItem,
            color: Colors.black,
          ),
        ],
      ),
    );
  }
}
