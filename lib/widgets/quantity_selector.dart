import 'package:flutter/material.dart';
import '../theme/colors.dart';

class QuantitySelector extends StatelessWidget {
  final int quantity;
  final ValueChanged<int> onChanged;
  final int min;
  final int max;

  const QuantitySelector({
    Key? key,
    required this.quantity,
    required this.onChanged,
    this.min = 1,
    this.max = 999,
  }) : super(key: key);

  void _increment() {
    if (quantity < max) {
      onChanged(quantity + 1);
    }
  }

  void _decrement() {
    if (quantity > min) {
      onChanged(quantity - 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(50),
        border: Border.all(color: AppColors.primary),
      ),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildButton(Icons.remove, _decrement, quantity > min),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              quantity.toString(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          _buildButton(Icons.add, _increment, quantity < max),
        ],
      ),
    );
  }

  Widget _buildButton(IconData icon, VoidCallback onPressed, bool enabled) {
    return SizedBox(
      width: 32,
      height: 32,
      child: ElevatedButton(
        onPressed: enabled ? onPressed : null,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          backgroundColor: enabled ? AppColors.primary.withOpacity(0.9) : AppColors.primary.withOpacity(0.4),
          minimumSize: Size(32, 32),
          elevation: 0,
        ),
        child: Icon(icon, size: 18),
      ),
    );
  }
}
