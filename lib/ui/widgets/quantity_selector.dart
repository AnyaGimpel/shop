import 'package:flutter/material.dart';

class QuantitySelector extends StatelessWidget {
  final int quantity;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final VoidCallback onRemoveItem;

  const QuantitySelector({
    super.key,
    required this.quantity,
    required this.onIncrement,
    required this.onDecrement,
    required this.onRemoveItem
  });

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown, // Адаптация размера под контейнер
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 30, // Заданный размер контейнера
            height: 30,
            decoration: BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.circular(8), // Менее округлые углы
            ),
            child: IconButton(
              padding: EdgeInsets.zero, // Убираем внутренние отступы
              icon: const Icon(
                Icons.remove,
                color: Colors.white,
                size: 18, // Уменьшенный размер иконки
              ),
              onPressed: onDecrement,
            ),
          ),
          const SizedBox(width: 8), // Расстояние между кнопкой и текстом
          Text(
            quantity.toString(),
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 8), // Расстояние между текстом и кнопкой
          Container(
            width: 30,
            height: 30,
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
