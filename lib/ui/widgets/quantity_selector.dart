import 'package:flutter/material.dart';

class QuantitySelector extends StatelessWidget {
  final int quantity;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final VoidCallback onRemoveItem;
  final double buttonSize; // Параметр для размера кнопок
  final double textSize;   // Параметр для размера текста
  final double spacing;    // Новый параметр для дополнительного отступа

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
          Text(
            quantity.toString(),
            style: TextStyle(fontSize: textSize, fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 8),
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
