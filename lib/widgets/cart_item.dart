import 'package:flutter/material.dart';
import '../models/product.dart';
import '../theme/colors.dart';
import '../theme/text_styles.dart';
import '../widgets/quantity_selector.dart';

class CartItem extends StatelessWidget {
  final Product product;
  final int quantity;
  final ValueChanged<int> onQuantityChanged;
  final VoidCallback onRemove;

  const CartItem({
    required this.product,
    required this.quantity,
    required this.onQuantityChanged,
    required this.onRemove,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.surface,
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                product.image,
                width: 90,
                height: 90,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.name,
                      style: AppTextStyles.textTheme.headlineSmall),
                  SizedBox(height: 8),
                  Text('\$${product.price.toStringAsFixed(2)}',
                      style: AppTextStyles.textTheme.bodyLarge
                          ?.copyWith(color: AppColors.primary)),
                  SizedBox(height: 12),
                  Row(
                    children: [
                      QuantitySelector(
                        quantity: quantity,
                        onChanged: (newQty) => onQuantityChanged(newQty),
                        min: 1,
                      ),
                      Spacer(),
                      IconButton(
                        icon: Icon(Icons.delete_forever, color: AppColors.error),
                        onPressed: onRemove,
                        splashRadius: 24,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
